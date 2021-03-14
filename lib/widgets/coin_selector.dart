import 'package:crypto_app/models/coin.dart';
import 'package:crypto_app/models/data.dart';
import 'package:crypto_app/widgets/add_tile.dart';
import 'package:crypto_app/widgets/coin_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CoinSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (context, coinList, child) {
      return Container(
        constraints: BoxConstraints.expand(height: 150),
        child: ListView(
          padding: EdgeInsets.only(left: 30),
          scrollDirection: Axis.horizontal,
          children: getCoinList(coinList.coins),
        ),
      );
    });
  }

  List<Widget> getCoinList(List<Coin> coins) {
    List<Widget> coinTiles = [];
    for (Coin coin in coins) {
      coinTiles.add(CoinTile(coin));
    }
    coinTiles.add(AddTile());
    return coinTiles;
  }
}
