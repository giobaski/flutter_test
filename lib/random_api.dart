import 'dart:convert';
import 'package:http/http.dart' as http;

class RandomApi {

  static Future<int> fetchRandom() async {
    var response = await http.get(Uri.parse('https://csrng.net/csrng/csrng.php?min=1&max=1000'));

    int _randomInt = 0;
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body) as List;
      _randomInt =  (data[0]['status'] == 'success') ? data[0]['random'] : 0;
    } else {
      throw Exception('Failed to load random');
    }

    return _randomInt;
  }

}