import 'dart:math';
import 'location.dart';

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

  ObservationStation nearestStation = stations.first;
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
  // Sample data for observation stations
  List<ObservationStation> stations = [
    ObservationStation('SO_0732', '남애항', 37.944, 128.788),
    ObservationStation('SO_0733', '강릉항', 37.772, 128.951),
    ObservationStation('Station C', 36.987, -121.567),
  ];

  // User's GPS coordinates
  double userLatitude = longitude;
  double userLongitude = -122.789;

  // Find the nearest observation station
  ObservationStation? nearestStation = findNearestObservationStation(userLatitude, userLongitude, stations);

  print('Nearest observation station: ${nearestStation.name}');
}
