import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(SeaTideApp());
}

class SeaTideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sea Tide App'),
        ),
        body: Center(
          child: ElevatedButton(
            child: Text('Get Tide Table'),
            onPressed: () {
              _requestLocationPermission(context);
            },
          ),
        ),
      ),
    );
  }

  void _requestLocationPermission(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle the case when location permission is denied by the user.
        return;
      }
    }

    _getTideTable(context);
  }

  void _getTideTable(BuildContext context) async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );

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



// Use the position object to fetch the tide table data.
  }


