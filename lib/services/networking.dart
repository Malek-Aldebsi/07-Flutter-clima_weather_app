import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  String URL;
  Networking({this.URL});

  Future getData() async {
    http.Response Temp = await http.get(Uri.parse(URL));
    if (Temp.statusCode == 200) {
      String data = Temp.body;
      return jsonDecode(data);
    } else {
      print(Temp.statusCode);
    }
  }
}
