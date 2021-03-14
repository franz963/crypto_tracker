import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsTile extends StatelessWidget {
  final String newsTile;
  final DateTime publishingDate;
  final String newsUrl;

  NewsTile(this.newsTile, this.publishingDate, this.newsUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Text(
              (newsTile.length <= 100)
                  ? newsTile
                  : newsTile.substring(0, 100) + '...',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Text(formatDate()),
        ],
      ),
    );
  }

  String formatDate() {
    final DateFormat formatter = DateFormat('MM/dd/yyyy - H:mm:ss');
    return formatter.format(publishingDate);
  }
}
