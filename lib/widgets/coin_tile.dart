import 'dart:convert' as convert;

import 'package:crypto_app/models/coin.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoinTile extends StatelessWidget {
  final Coin coin;
  CoinTile(this.coin);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(coin.coinShortName);
      },
      child: Container(
        padding: EdgeInsets.all(10),
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
                  future: getCurrentCoinPrice(),
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

  Future<String> getCurrentCoinPrice() async {
    final endpoint = Uri.https('api.coingecko.com', 'api/v3/simple/price',
        {'ids': coin.coinName, 'vs_currencies': 'usd'});
    final response = await http.get(endpoint);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse[coin.coinName.toLowerCase()]['usd'].toString();
    } else {
      throw Exception('Failed to get coin price');
    }
    return '60274';
  }
}
