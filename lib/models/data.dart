import 'dart:collection';

import 'package:crypto_app/models/coin.dart';
import 'package:flutter/foundation.dart';

class Data extends ChangeNotifier {
  List<Coin> _coins = [
    Coin(coinName: 'Bitcoin', coinShortName: 'BTC'),
    Coin(coinName: 'Ethereum', coinShortName: 'ETH'),
    Coin(coinName: 'Litecoin', coinShortName: 'LTC')
  ];

  String _currentCoin = 'Bitcoin';
  String _numberOfDays = '1';

  UnmodifiableListView<Coin> get coins {
    return UnmodifiableListView(_coins);
  }

  String get currentCoin {
    return _currentCoin;
  }

  String get numberOfDays {
    return _numberOfDays;
  }

  void addCoin(String coinName, String coinShortName) {
    final coin = Coin(coinName: coinName, coinShortName: coinShortName);
    _coins.add(coin);
    updateCurrentCoin(coinName);
    notifyListeners();
  }

  void updateCurrentCoin(String coinName) {
    _currentCoin = coinName;
    notifyListeners();
  }

  void updatenNumberOfDays(String days) {
    _numberOfDays = days;
    notifyListeners();
  }
}
