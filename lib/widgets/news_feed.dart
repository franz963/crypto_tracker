import 'package:crypto_app/models/data.dart';
import 'package:crypto_app/widgets/news_tile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:webfeed/webfeed.dart';

class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (context, coinData, child) {
      return FutureBuilder(
        future: getNews(coinData.currentCoin),
        builder: (context, news) {
          if (news.hasData) {
            return Expanded(
              child: ListView(
                children: getNewsFeed(news.data),
              ),
            );
          }
          return CircularProgressIndicator();
        },
      );
    });
  }

  Future getNews(String coinName) async {
    var client = http.Client();

    Uri url = Uri.https('news.google.com', '/rss/search',
        {'q': coinName, 'hl': 'en-US', 'gl': 'US', 'ceid': 'US:en'});
    var response = await client.get(url);
    var channel = RssFeed.parse(response.body);
    // print(channel.items[0].title);
    // print(channel.items[0].link);
    // print(channel.items[0].pubDate);

    client.close();
    return channel.items;
  }

  List<Widget> getNewsFeed(List<RssItem> news) {
    List<Widget> newsFeed = [];
    for (RssItem newsItem in news) {
      newsFeed.add(NewsTile(newsItem.title, newsItem.pubDate, newsItem.link));
    }
    return newsFeed;
  }
}
