import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsTile extends StatelessWidget {
  final String newsTile;
  final DateTime publishingDate;
  final String newsUrl;

  NewsTile(this.newsTile, this.publishingDate, this.newsUrl);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _launchURL();
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 15),
        height: 100,
        // width: 200,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              new BoxShadow(
                color: Colors.black54,
                blurRadius: 10,
              ),
            ],
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  (newsTile.length <= 100)
                      ? newsTile
                      : newsTile.substring(0, 100) + '...',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Text(formatDate()),
          ],
        ),
      ),
    );
  }

  String formatDate() {
    final DateFormat formatter = DateFormat('MM/dd/yyyy - H:mm:ss');
    return formatter.format(publishingDate);
  }

  Future<void> _launchURL() async {
    if (await canLaunch(newsUrl)) {
      await launch(
        newsUrl,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $newsUrl';
    }
  }
}
