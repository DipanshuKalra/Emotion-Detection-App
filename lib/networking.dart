import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);
  var url;
  Future getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);
      return decodedData;
    }
    else {
      print(response.statusCode);
    }
  }
}

Future<dynamic> getTweets(dynamic username) async {
  NetworkHelper network = NetworkHelper(
      Uri.parse('https://anuj.jprq.io/predict/$username'));
  var tweetsData = await network.getData();
  return tweetsData;
}