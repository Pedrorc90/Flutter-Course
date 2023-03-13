import 'package:flutter/material.dart';

class SliderPage extends StatefulWidget {
  const SliderPage();

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {

  double _sliderValue = 100.0;
  bool _checkBlock = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sliders'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            _createSlider(),
            _createCheckBox(),
            _createSwitch(),
            Expanded(child: _createImage())
          ],
        ),
      ),
    );
  }

  Widget _createSlider() {
    return Slider(
      activeColor: Colors.indigoAccent,
      label: 'Image size',
      value: _sliderValue,
      min: 10.0,
      max: 400.0,
      onChanged: ( _checkBlock ) ? null : ( value ) {
        setState(() => _sliderValue = value );
      },
    );
  }

  Widget _createImage() {

    return Image(
      width: _sliderValue,
      fit: BoxFit.contain,
      image: NetworkImage('https://images.unsplash.com/photo-1484591974057-265bb767ef71?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MXx8fGVufDB8fHx8&w=1000&q=80')
    );

  }

  Widget _createCheckBox() {

    return CheckboxListTile(
      title: Text(' Block slider'),
      value: _checkBlock,
      onChanged: ( value ) {
         setState(() => _checkBlock = value as bool);
       });
  }

  Widget _createSwitch() {

    return SwitchListTile(
      title: Text(' Block slider'),
      value: _checkBlock,
      onChanged: ( value ) {
         setState(() => _checkBlock = value as bool);
       });
  }
}