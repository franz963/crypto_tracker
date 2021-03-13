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
        child: FutureBuilder<List<dynamic>>(
          future: coinData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return LineChart(
                sampleData1(snapshot.data),
                // swapAnimationDuration: const Duration(milliseconds: 250),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  LineChartData sampleData1(List<dynamic> data) {
    return LineChartData(
      gridData: FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: false,
          // reservedSize: 22,
          // getTextStyles: (value) => const TextStyle(
          //   color: Color(0xff72719b),
          //   fontWeight: FontWeight.bold,
          //   fontSize: 16,
          // ),
          // margin: 10,
          // getTitles: (value) {
          //   print(value);
          //   switch (value.toInt()) {
          //     case 2:
          //       return 'SEPT';
          //     case 7:
          //       return 'OCT';
          //     case 12:
          //       return 'DEC';
          //   }
          //   return '';
          // },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: findMin(data, 0) - 20000000,
      maxX: findMax(data, 0) + 20000000,
      maxY: findMax(data, 1) + 500,
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

  Future<List<dynamic>> coinData() async {
    final endpoint = Uri.https(
        'api.coingecko.com',
        'api/v3/coins/bitcoin/market_chart',
        {'vs_currency': 'usd', 'days': '2'});
    print(endpoint);
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

  List<FlSpot> getSpotList(List<dynamic> prices) {
    List<FlSpot> returnValue = [];
    for (final price in prices) {
      var x = price[0];
      var y = price[1];
      final graphValue = FlSpot(x.toDouble(), y.toDouble());
      returnValue.add(graphValue);
    }
    print(returnValue);
    return returnValue;
  }
}
