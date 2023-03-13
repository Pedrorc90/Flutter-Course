import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:band_names/services/socket_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  static const MAX_BAND_ALLOWED = 8;
  List<Band> bands = [];
  
  

  @override
  void initState() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.on('active-bands', _handleActiveBands );
    super.initState();
  }

  _handleActiveBands( dynamic payload) {
    this.bands = ( payload as List )
      .map( (band) => Band.fromMap(band) )
      .toList();
      setState(() {});
  }

  @override
  void dispose() {
    final socketService = Provider.of<SocketService>(context, listen: false);
    socketService.socket.off('active-bands');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final socketService = Provider.of<SocketService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('BandNames', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: (socketService.serverStatus == ServerStatus.Online) 
            ? Icon(Icons.check_circle, color: Colors.blue[300]) 
            : Icon(Icons.offline_bolt, color: Colors.red),
          )
        ],
      ),
      body: Column(
        children: [
          _showGraph(),
          Expanded(
            child: ListView.builder (
              itemCount: bands.length,
              itemBuilder: ( context, i ) => _buildBandTile( bands[i] )
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: (_isAddNewBandAllowed()) ? addNewBand : null,
        backgroundColor: (_isAddNewBandAllowed()) ? Colors.blue : Colors.blue.shade200,
      ),

   );
  }

  Widget _buildBandTile( Band band ) {
    final socketService = Provider.of<SocketService>(context, listen: false);
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: ( _ ) => socketService.socket.emit('delete-band', {'id': band.id}),
      background: Container(
        padding: EdgeInsets.only( left: 8.0 ),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete band', style: TextStyle(color: Colors.white))
        )
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Text( band.name.substring(0,2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text( band.name ),
        trailing: Text('${band.votes}', style: TextStyle( fontSize: 20.0 )),
        onTap: () => socketService.socket.emit('vote-band', { 'id': band.id })
      ),
    );
  }

  addNewBand() {

    final TextEditingController textController = new TextEditingController();

    if ( Platform.isAndroid ) {
      return showDialog(
        context: context, 
        builder: ( _ ) => AlertDialog(
          title: Text('New Band Name'),
          content: TextField(
            controller: textController,
          ),
          actions: [
            MaterialButton(
              child: Text('Add'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => addBandToList( textController.text )
            )
          ],
        )
      );
    }

    showCupertinoDialog(
      context: context, 
      builder: ( _ ) =>
         CupertinoAlertDialog(
          title: Text('New Band name:'),
          content: CupertinoTextField(
            controller: textController
          ),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Add'),
              onPressed: () => addBandToList( textController.text )
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('Dismiss'),
              onPressed: () => Navigator.pop(context)
            )
          ],
        )
    );
  }

  void addBandToList( String name ) {


    if (name.length > 1 ) {
      final socketService = Provider.of<SocketService>(context, listen: false);
      socketService.socket.emit('add-band', ( {'name': name} ));
    }
  
    Navigator.pop(context);
  }

  Widget _showGraph() {
    Map<String, double> dataMap = { '': 0 };
    bands.forEach(( band ) {
      dataMap.putIfAbsent(band.name, () => band.votes.toDouble());
      if (dataMap.length > 1) {
        dataMap.remove('');
      }
    });
    return Container(
      width: double.infinity,
      child: (dataMap.isNotEmpty) ? _buildChart(dataMap) : _buildLoading()
    ); 
  }

  Widget _buildLoading() {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator()
            ],
          ),
          
        ],
      );
  }

  Widget _buildChart( Map<String, double> dataMap ) {

    final List<Color> colorList = [
      Colors.deepOrangeAccent.shade200,
      Colors.orange.shade200,
      Colors.green.shade200,
      Colors.red.shade200,
      Colors.blue.shade200,
      Colors.purple.shade200,
      Colors.yellow.shade200,
      Colors.pink.shade200
    ];

    return Column(
      children: [ PieChart(
          emptyColor: Colors.grey.shade300,
          dataMap: dataMap,
          animationDuration: Duration(milliseconds: 1500),
          chartLegendSpacing: 32,
          chartRadius: MediaQuery.of(context).size.width / 3.2,
          colorList: colorList,
          initialAngleInDegree: 0,
          chartType: ChartType.disc,
          ringStrokeWidth: 32,
          legendOptions: LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: (dataMap.length > 1),
            legendShape: BoxShape.circle,
            legendTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          chartValuesOptions: ChartValuesOptions(
            showChartValueBackground: false,
            showChartValues: true,
            showChartValuesInPercentage: false,
            showChartValuesOutside: false,
            decimalPlaces: 0,
          )
        ),
        SizedBox(height: 10.0),
        (_isAddNewBandAllowed())
        ? Text('Use + button to add a new band', style: TextStyle(color: Colors.green, fontSize: 16.0, fontWeight: FontWeight.bold))
        : Text('You cannot add more bands...', style: TextStyle(color: Colors.red, fontSize: 16.0,  fontWeight: FontWeight.bold)),
        SizedBox(height: 20.0)
      ]
    );
  }

  bool _isAddNewBandAllowed() {
    return bands.length < MAX_BAND_ALLOWED;
  }
}