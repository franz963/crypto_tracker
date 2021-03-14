import 'package:crypto_app/models/coin.dart';
import 'package:crypto_app/models/coin_price.dart';
import 'package:crypto_app/models/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinTile extends StatelessWidget {
  final Coin coin;
  CoinTile(this.coin);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<Data>(context, listen: false)
            .updateCurrentCoin(coin.coinName);
      },
      child: Container(
        margin: EdgeInsets.only(right: 20, bottom: 30, top: 30),
        height: 150,
        width: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                color: Colors.black54,
                blurRadius: 20,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    coin.coinName + ' (' + coin.coinShortName + ')',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: FutureBuilder(
                  future: getCurrentCoinPrice(coin.coinName),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        '\$' + snapshot.data,
                        style: TextStyle(fontSize: 30),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
