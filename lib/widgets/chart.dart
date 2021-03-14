import 'dart:convert' as convert;
import 'dart:math';

import 'package:crypto_app/models/data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Chart extends StatefulWidget {
  // final String coinName;
  // const Chart(this.coinName);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  // final String coinName;
  // _ChartState(this.coinName);

  @override
  Widget build(BuildContext context) {
    return Consumer<Data>(builder: (context, coins, child) {
      return Expanded(
        child: Container(
          height: 200,
          margin: EdgeInsets.only(left: 15, right: 15),
          child: FutureBuilder<List<dynamic>>(
            future: coinData(coins.currentCoin, coins.numberOfDays),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  margin: EdgeInsets.only(left: 30, right: 30),
                  child: LineChart(
                    sampleData1(snapshot.data),
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      );
    });
  }

  LineChartData sampleData1(List<dynamic> data) {
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: false,
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: findMin(data, 0),
      maxX: findMax(data, 0),
      maxY: findMax(data, 1),
      minY: findMin(data, 1),
      lineBarsData: linesBarData1(data),
    );
  }

  List<LineChartBarData> linesBarData1(List<dynamic> data) {
    // coinData();
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: getSpotList(data),
      isCurved: true,
      colors: [
        const Color(0xff4af699),
      ],
      barWidth: 8,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: false,
      ),
      belowBarData: BarAreaData(
        show: false,
      ),
    );
    return [lineChartBarData1];
  }

  Future<List<dynamic>> coinData(String coin, String days) async {
    final String unencodedPath =
        'api/v3/coins/' + coin.toLowerCase() + '/market_chart';
    final endpoint = Uri.https('api.coingecko.com', unencodedPath,
        {'vs_currency': 'usd', 'days': days});
    final response = await http.get(endpoint);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return jsonResponse['prices'];
    } else {
      throw Exception('Failed to get coin data');
    }
  }

  double findMin(List<dynamic> data, int position) {
    double min = -1;
    for (final value in data) {
      if (min == -1 || value[position] < min) {
        min = value[position].toDouble();
      }
    }
    return min;
  }

  double findMax(List<dynamic> data, int position) {
    double max = -1;
    for (final value in data) {
      if (value[position] > max) {
        max = value[position].toDouble();
      }
    }
    return max;
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  List<FlSpot> getSpotList(List<dynamic> prices) {
    List<FlSpot> returnValue = [];
    for (final price in prices) {
      var x = roundDouble(price[0].toDouble(), 2);
      var y = roundDouble(price[1].toDouble(), 2);
      final graphValue = FlSpot(x, y);
      returnValue.add(graphValue);
    }
    return returnValue;
  }
}
