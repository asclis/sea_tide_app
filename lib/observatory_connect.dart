import 'package:flutter/material.dart';
import 'dart:math';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'location.dart';



class _sea_tide_app extends StatefulWidget {
  @override
  _sea_tide_appState createState() => _sea_tide_appState();
// createState() => StatefulWidget이 상태를 관리하고 업데이트 하는 역할
}

class _sea_tide_appState extends State<_sea_tide_app> {
  @override
  _sea_tide_appState createState() => _sea_tide_appState();

// createState() => StatefulWidget이 상태를 관리하고 업데이트 하는 역할

  var latitude = 'Unknown'; //latitude 초기값
  var longitude = 'Unknown'; //longitude 초기값

  @override
  void initState() {
    super.initState();
    _requestLocationPermission(context); // 바로 호출
    //initState는 이 메소드는 위젯이 처음 생성될 때 호출되며, 일반적으로 위젯의 초기화 작업을 수행하는 데 사용됩니다. initState 메소드는 상태가 처음 생성되었을 때 한 번만 호출되며, 그 이후에는 다시 호출되지 않습니다.

  }

  // Longitude -로 나오는거 해결하는 메소드
  String formatLongitude(double longitude) {
    String hemisphere = longitude >= 0 ? 'E' : '';
    return '$hemisphere ${longitude.abs()}° ';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Observatory_connect'),
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
 // Material 위젯은 이따가 수정합시다...
  void _requestLocationPermission(BuildContext context) async {
    //예외가 발생할 수 있는 코드
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );

      setState(() {
        latitude = position.latitude.toString();
        longitude = formatLongitude(position.longitude);
      });
      // 예외 발생시 처리하는 코드
    } catch (e) {
      print('Error: $e');
      setState(() {
        latitude = 'Error';
        longitude = 'Error';
      });
    }
  }

}
class ObservationStation {
  String code;
  String name;
  double latitude;
  double longitude;

  ObservationStation(this.code, this.name, this.latitude, this.longitude);
}

ObservationStation? findNearestObservationStation(double userLatitude, double userLongitude, List<ObservationStation> stations) {
  if (stations.isEmpty) {
    print('관측소 입력이 없습니다');
    return null; //Return null if the list is empty
  }

  ObservationStation? nearestStation = stations.first;
  double shortestDistance = double.infinity;

  for (ObservationStation station in stations) {
    double stationLatitude = station.latitude;
    double stationLongitude = station.longitude;

    double distance = calculateDistance(userLatitude, userLongitude, stationLatitude, stationLongitude);
    if (distance < shortestDistance) {
      shortestDistance = distance;
      nearestStation = station;
    }
  }

  return nearestStation;
}
//두 위치에서 거리 계산하는식(관측소위치와 나의위치)
double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const int earthRadius = 6371; // Earth's radius in kilometers

  double dLat = _degreesToRadians(lat2 - lat1);
  double dLon = _degreesToRadians(lon2 - lon1);

  double a = sin(dLat / 2) * sin(dLat / 2) +
      cos(_degreesToRadians(lat1)) * cos(_degreesToRadians(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distance = earthRadius * c;
  return distance;
}

double _degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

void main() {
  var appState = _sea_tide_appState();
  runApp(_sea_tide_app());

  // Sample data for observation stations
  List<ObservationStation> stations = [
    ObservationStation('DT_0063', '가덕도', 35.024, 128.81),
    ObservationStation('DT_0032', '강화대교', 37.731, 126.522),
    ObservationStation('DT_0031', '거문도', 34.028, 127.308),
    ObservationStation('DT_0029', '거제도', 34.801, 128.699),
    ObservationStation('DT_0026', '고흥발포', 34.481, 127.342),
    ObservationStation('DT_0049', '광양', 34.903, 127.754),
    ObservationStation('DT_0042', '교본초', 34.704, 128.306),
    ObservationStation('DT_0018', '군산', 35.975, 126.563),
    ObservationStation('DT_0017', '대산', 37.007, 126.352),
    ObservationStation('DT_0065', '덕적도', 37.226, 126.156),
    ObservationStation('DT_0057', '동해항', 37.494, 129.143),
    ObservationStation('DT_0062', '마산', 35.197, 128.576),
    ObservationStation('DT_0023', '모슬포', 33.214, 126.251),
    ObservationStation('DT_0007', '목포', 34.779, 126.375),
    ObservationStation('DT_0006', '묵호', 37.55, 129.116),
    ObservationStation('DT_0025', '보령', 36.406, 126.486),
    ObservationStation('DT_0041', '복사초', 34.098, 126.168),
    ObservationStation('DT_0005', '부산', 35.096, 129.035),
    ObservationStation('DT_0056', '부산항신항', 35.077, 128.786),
    ObservationStation('DT_0061', '삼천포', 34.924, 128.069),
    ObservationStation('DT_0010', '서귀포', 33.24, 126.561),
    ObservationStation('DT_0051', '서천마량', 36.128, 126.495),
    ObservationStation('DT_0022', '성산포', 33.474, 126.927),
    ObservationStation('DT_0093', '소무의도', 37.373, 126.44),
    ObservationStation('DT_0012', '속초', 38.207, 128.594),
    ObservationStation('IE_0061', '신안가거초', 33.941, 124.592),
    ObservationStation('DT_0008', '안산', 37.192, 126.647),
    ObservationStation('DT_0067', '안흥', 36.674, 126.129),
    ObservationStation('DT_0037', '어청도', 36.117, 125.984),
    ObservationStation('DT_0016', '여수', 34.747, 127.765),
    ObservationStation('DT_0092', '여호항', 34.661, 127.469),
    ObservationStation('DT_0003', '영광', 35.426, 126.42),
    ObservationStation('DT_0044', '영종대교', 37.545, 126.584),
    ObservationStation('DT_0043', '영흥도', 37.238, 126.428),
    ObservationStation('IE_0062', '옹진소청초', 37.423, 124.738),
    ObservationStation('DT_0027', '완도', 34.315, 126.759),
    ObservationStation('DT_0039', '왕돌초', 36.719, 129.732),
    ObservationStation('DT_0013', '울릉도', 37.491, 130.913),
    ObservationStation('DT_0020', '울산', 35.501, 129.387),
    ObservationStation('DT_0068', '위도', 35.618, 126.301),
    ObservationStation('IE_0060', '이어도', 32.122, 125.182),
    ObservationStation('DT_0001', '인천', 37.451, 126.592),
    ObservationStation('DT_0052', '인천송도', 37.338, 126.586),
    ObservationStation('DT_0024', '장항', 36.006, 126.687),
    ObservationStation('DT_0004', '제주', 33.527, 126.543),
    ObservationStation('DT_0028', '진도', 34.377, 126.308),
    ObservationStation('DT_0021', '추자도', 33.961, 126.3),
    ObservationStation('DT_0050', '태안', 36.913, 126.238),
    ObservationStation('DT_0014', '통영', 34.827, 128.434),
    ObservationStation('DT_0002', '평택', 36.966, 126.822),
    ObservationStation('DT_0091', '포항', 36.051, 129.376),
    ObservationStation('DT_0066', '향화도', 35.167, 126.359),
    ObservationStation('DT_0011', '후포', 36.677, 129.453),
    ObservationStation('DT_0035', '흑산도', 34.684, 125.435),

  ];



  // User's GPS coordinates
  double userLatitude = double.parse(appState.latitude);
  double userLongitude = double.parse(appState.longitude);
  print('User Latitude: $appState.latitude');


  // 일단 계산하는 식 먼저 나와야 될 거 같은데...
  // Find the nearest observation station
  ObservationStation? nearestStation = findNearestObservationStation(userLatitude, userLongitude, stations);

  print("유저의 현재 위치 : &userLatitude");
  print('Nearest observation station: ${nearestStation?.name}');
  // 물음표만 넣으니깐 됨... 앞에 findnearobseravationStation안에 있는 nearestStation이랑 위에 nearestStation 클래스랑 동일한가 봤는데 그거랑 별개라고 함

}
