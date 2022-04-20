import 'package:location/location.dart';

class LocationService {
  Future getLocation() async {
    Location location = new Location();
    late bool _serviceEnabled;
    late PermissionStatus _permissionGranted;
    late LocationData _locationData;
    bool _isGetLocation = false;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) return;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) return;
    }

    return await location.getLocation();
  }
}
