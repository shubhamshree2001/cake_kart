import 'package:geolocator/geolocator.dart';

class GeolocatorService {

  Stream<Position> getCurrentLocation() {
    return Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );
  }

  Future<Position> getInitialLocation() async {
    return  Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

}