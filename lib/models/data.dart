import 'dart:collection';

import 'package:crypto_app/models/coin.dart';
import 'package:flutter/foundation.dart';

class Data extends ChangeNotifier {
  List<Coin> _coins = [
    Coin(coinName: 'Bitcoin', coinShortName: 'BTC'),
    Coin(coinName: 'Ethereum', coinShortName: 'ETH'),
    Coin(coinName: 'Litecoin', coinShortName: 'LTC')
  ];

  UnmodifiableListView<Coin> get coins {
    return UnmodifiableListView(_coins);
  }

  void addCoin(String coinName, String coinShortName) {
    final coin = Coin(coinName: coinName, coinShortName: coinShortName);
    _coins.add(coin);
    notifyListeners();
  }
}