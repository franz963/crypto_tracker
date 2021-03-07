import 'package:crypto_app/chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                children: [
                  Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[Chart()]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
