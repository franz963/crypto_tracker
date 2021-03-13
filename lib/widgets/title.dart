import 'package:crypto_app/models/coin_price.dart';
import 'package:crypto_app/models/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (context, coin, child) {
      return Align(
        alignment: Alignment.topLeft,
        child: Container(
          margin: EdgeInsets.only(left: 25),
          child: Column(
            children: [
              Text(
                coin.currentCoin,
                style: TextStyle(fontSize: 30),
              ),
              FutureBuilder(
                future: getCurrentCoinPrice(coin.currentCoin),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      '\$' + snapshot.data,
                      style: TextStyle(fontSize: 30),
                    );
                  }
                  return Text('');
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
