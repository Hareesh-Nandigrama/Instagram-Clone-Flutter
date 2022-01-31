import 'package:flutter/material.dart';

popUp(String x, BuildContext context, int a, int b, var col){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: a, milliseconds: b),
      backgroundColor: Colors.white,
      content: Text(x, style: TextStyle(color: col), textAlign: TextAlign.center,),
    ),
  );
}