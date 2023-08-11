import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

    class MyHomePage extends StatefulWidget {
    @override
    _MyHomePageState createState() => _MyHomePageState();

    }

    class _MyHomePageState extends State<MyHomePage> {
    String latitude = 'Unknown';
    String longitude = 'Unknown';



    @override
    void initState() {
    super.initState();
    _getCurrentLocation();
    }

    String formatLongitude(double longitude) {
    String hemisphere = longitude >= 0 ? 'E' : '';
    return '$hemisphere ${longitude.abs()}° ';
    }



    Future<void> _getCurrentLocation() async {
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location method'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Latitude: $latitude',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Longitude: $longitude',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
