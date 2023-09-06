import 'dart:convert';
import 'package:http/http.dart' as http;
import 'observatory_connect.dart';

void main() {
  fetchUserData();
}

void fetchUserData() async {
  String apiUrl =
      'http://www.khoa.go.kr/api/oceangrid/tideObsPreTab/search.do?ServiceKey=20C6kyJi/7GdgN/mQ1dfg==&ObsCode={$nearestStation.code}&Date=20160101&ResultType=json';

  try {
    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);

      for (var user in jsonData) {
        String name = user['name'];
        String email = user['email'];

        print('User: $name, Email: $email');
      }
    } else {
      print('Failed to fetch user data. Status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching user data: $e');
  }
}
