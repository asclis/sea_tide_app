import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sea_tide_app/location.dart';
import 'dart:math';


void main() {
  runApp(sea_tide_app());
}

class sea_tide_app extends StatefulWidget {
  @override
  _sea_tide_appState createState() => _sea_tide_appState();
}

class _sea_tide_appState extends State<sea_tide_app> {
  String latitude = 'Unknown'; //latitude 초기값
  String longitude = 'Unknown'; //longitude 초기값

  @override
  void initState() {
    super.initState();
    _requestLocationPermission(context); // 바로 호출

  }

  String formatLongitude(double longitude) {
    String hemisphere = longitude >= 0 ? 'E' : '';
    return '$hemisphere ${longitude.abs()}° ';
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sea Tide App'),
        ),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Latitude: $latitude',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Longitude: $longitude',
                  style: TextStyle(fontSize: 20),
                )
              ]

            ),
          ),
        ),
      )
    );
  }

  void _requestLocationPermission(BuildContext context) async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      setState(() {
        latitude = position.latitude.toString();
        longitude = formatLongitude(position.longitude);
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        latitude = 'Error';
        longitude = 'Error';
      });
    }
  }
  _getTideTable(context);
}

void _getTideTable(BuildContext context) async {

  final url = 'https://api.example.com/tide-table?lat=${position.latitude}&lng=${position.longitude}';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Parse the tide table data from the response and display it in the app.
    // You may need to use a JSON decoding library like the built-in `jsonDecode()` function or the `dart:convert` package.
  } else {
    // Handle the case when the API request fails.
  }

  // Use the position object to fetch the tide table data.
}


}











