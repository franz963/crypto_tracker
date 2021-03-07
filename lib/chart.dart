import 'dart:convert' as convert;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 200,
        child: LineChart(
          sampleData1(),
          // swapAnimationDuration: const Duration(milliseconds: 250),
        ),
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff72719b),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 10,
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'SEPT';
              case 7:
                return 'OCT';
              case 12:
                return 'DEC';
            }
            return '';
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 14,
      maxY: 4,
      minY: 0,
      lineBarsData: linesBarData1(),
    );
  }

  List<LineChartBarData> linesBarData1() {
    coinData();
    final LineChartBarData lineChartBarData1 = LineChartBarData(
      spots: [
        FlSpot(1, 1),
        FlSpot(3, 1.5),
        FlSpot(5, 1.4),
        FlSpot(7, 3.4),
        FlSpot(10, 2),
        FlSpot(12, 2.2),
        FlSpot(13, 1.8),
      ],
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

  Future<List<FlSpot>> coinData() async {
    List<FlSpot> returnValue = [];

    final endpoint = Uri.https(
        'api.coingecko.com',
        'api/v3/coins/bitcoin/market_chart',
        {'vs_currency': 'usd', 'days': '2', 'interval': 'daily'});
    print(endpoint);
    final response = await http.get(endpoint);

    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      var prices = jsonResponse['prices'];
      for (final price in prices) {
        var x = price[0];
        var y = price[1];
        final graphValue = FlSpot(x.toDouble(), y.toDouble());
        returnValue.add(graphValue);
      }
      print(returnValue);
      return returnValue;
    } else {
      throw Exception('Failed to get coin data');
    }
  }
}
