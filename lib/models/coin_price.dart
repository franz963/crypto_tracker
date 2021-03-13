import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

Future<String> getCurrentCoinPrice(String coinName) async {
  final endpoint = Uri.https('api.coingecko.com', 'api/v3/simple/price',
      {'ids': coinName, 'vs_currencies': 'usd'});
  final response = await http.get(endpoint);

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    return jsonResponse[coinName.toLowerCase()]['usd'].toString();
  } else {
    throw Exception('Failed to get coin price');
  }
}
