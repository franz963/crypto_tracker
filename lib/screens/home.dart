import 'package:crypto_app/widgets/chart.dart';
import 'package:crypto_app/widgets/coin_selector.dart';
import 'package:crypto_app/widgets/graph_time_selector.dart';
import 'package:crypto_app/widgets/news_feed.dart';
import 'package:crypto_app/widgets/title.dart';
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
                AppTitle(),
                Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Chart()]),
                GraphTimeSelector(),
                CoinSelector(),
                NewsFeed(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
