import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  const BlueButton({super.key, required this.textButton, required this.onPressed});

  final String textButton;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        shape: StadiumBorder()
      ),
      onPressed: onPressed, 
      child: Container(
        width: double.infinity,
        height: 55,
        child: Center(
          child: Text(
            textButton, 
            style: TextStyle( 
              color: Colors.white, 
              fontSize: 18 
              )
            ),
        ),
      )
    );
  }
}