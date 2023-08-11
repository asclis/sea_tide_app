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

}











