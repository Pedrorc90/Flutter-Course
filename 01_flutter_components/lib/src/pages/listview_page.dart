
import 'package:flutter/material.dart';
import 'dart:async';

class ListPage extends StatefulWidget {
  const ListPage();

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  ScrollController _scrollController = new ScrollController();
  List<int> _numberList = [];
  int _lastItem = 0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addTen();

    _scrollController.addListener(() {
      
      if ( _scrollController.position.pixels == _scrollController.position.maxScrollExtent ) {
       fetchData();
      }

    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListView Builder')
      ),
      body: Stack(
        children: [
          _createList(),
          _createLoading()
        ],
      )
      
      
    );
  }

  Widget _createList() {
    return RefreshIndicator(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _numberList.length,
        itemBuilder: (BuildContext context, int index) {
    
          final image = _numberList[index];
    
          return FadeInImage(
            placeholder: AssetImage('assets/jar-loading.gif'), 
            image: NetworkImage('https://picsum.photos/id/$image/500/300')
          );
        }
      ),
      onRefresh: getPage1,
    );
  }

  Future<Null> getPage1() async {
    final duration = Duration(seconds: 2);
    await new Timer(duration, () {
      _numberList.clear();
      _lastItem++;
      _addTen();
    });

    return Future.delayed(duration);
  }

  void _addTen() {
    for (var i = 0; i < 10; i++) {
      _lastItem++;
      _numberList.add( _lastItem );
      setState(() {
        
      });
    }
  }

  Future<Null> fetchData() async {

    _isLoading = true;
    setState(() {
      final duration = new Duration(seconds: 2);
      new Timer(duration, respHttp);
    });

  }

  void respHttp() {
    _isLoading = false;
    _scrollController.animateTo(
      _scrollController.position.pixels + 100, 
      duration: Duration( milliseconds: 250 ), 
      curve: Curves.fastOutSlowIn);
    _addTen();
  }

  Widget _createLoading() {

    if ( _isLoading ) {
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
          SizedBox(height: 15.0,)
          
        ],
      );
    } else {
      return Container();
    }
  }
}