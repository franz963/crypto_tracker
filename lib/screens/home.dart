import 'package:crypto_app/widgets/chart.dart';
import 'package:crypto_app/widgets/coin_selector.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Center(
            child: Column(
              children: [
                Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Chart()]),
                CoinSelector(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
