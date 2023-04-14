import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final String route;
  final String accountText;
  final String labelText;

  const Labels({super.key, required this.route, required this.labelText, required this.accountText});
  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(accountText, style: TextStyle( color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300 )),
          SizedBox( height: 10 ),
          GestureDetector(
            child: Text(labelText, style: TextStyle( color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold )),
            onTap: () {
              Navigator.pushReplacementNamed(context, route);
            },

          )
        ],
      ),
    );
  }
}