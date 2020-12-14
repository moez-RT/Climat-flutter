import 'package:geolocator/geolocator.dart';

class Location {
  double longitude;
  double latitude;


  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      this.longitude = position.longitude;
      this.latitude = position.latitude;
      print(position);
    } catch (e) {
      print(e);
    }
  }
}