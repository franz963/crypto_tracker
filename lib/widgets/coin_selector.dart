import 'package:crypto_app/models/coin.dart';
import 'package:crypto_app/models/data.dart';
import 'package:crypto_app/widgets/coin_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (context, coinList, child) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        constraints: BoxConstraints.expand(height: 200),
        child: ListView(
          padding: EdgeInsets.only(left: 40),
          scrollDirection: Axis.horizontal,
          children: getCoinList(coinList.coins),
        ),
      );
    });
  }

  List<CoinTile> getCoinList(List<Coin> coins) {
    List<CoinTile> coinTiles = [];
    for (Coin coin in coins) {
      coinTiles.add(CoinTile(coin));
    }
    return coinTiles;
  }
}
