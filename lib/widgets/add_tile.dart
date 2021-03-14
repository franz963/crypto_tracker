import 'dart:convert' as convert;

import 'package:crypto_app/models/data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddTile extends StatefulWidget {
  @override
  _AddTileState createState() => _AddTileState();
}

class _AddTileState extends State<AddTile> {
  TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _displayTextInputDialog(context);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_circle_outline,
              color: Colors.blue,
            ),
            Text(
              'Add Coin',
              style: TextStyle(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    String coinName;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('What coin do you want to add?'),
          content: TextField(
            onChanged: (value) {
              setState(() {
                coinName = value;
              });
            },
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Coin name"),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'CANCEL',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                _textFieldController.clear();
                setState(() {
                  Navigator.pop(context);
                });
              },
            ),
            TextButton(
              child: Text(
                'ADD',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                _textFieldController.clear();
                setState(() {
                  Navigator.pop(context);
                });
                addCoin(coinName.trim());
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _incorrectCoin(String coinName) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Coin Not Found'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Please check that the coin name you provided is correct. Please note that the you need to provide the full name of the coin and not an abbreviation or symbol'),
                Text('Coin name: $coinName'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future addCoin(String coinName) async {
    final String unencodedPath = 'api/v3/coins/' + coinName.toLowerCase();
    final endpoint = Uri.https('api.coingecko.com', unencodedPath, {
      'localization': 'false',
      'tickers': 'false',
      'market_data': 'false',
      'community_data': 'false',
      'developer_data': 'false',
      'sparkline': 'false'
    });
    final response = await http.get(endpoint);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      Provider.of<Data>(context, listen: false)
          .addCoin(coinName, jsonResponse['symbol'].toString().toUpperCase());
    } else {
      _incorrectCoin(coinName);
    }
  }
}
