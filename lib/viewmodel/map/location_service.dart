import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geoloc;

class LocationService {
  static Future locationGet() async {
    Location location = Location();
    late bool _serviceEnabled;
    late PermissionStatus _permissionGranted;

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

  static Future getAddress() async {
    var location = await locationGet();
    double lat = location.latitude;
    double lng = location.longitude;
    print(lat);
    print(lng);
    var address = await geoloc.placemarkFromCoordinates(lat, lng);
    var street = address.first.street;
    var city = address.first.locality;
    var postalCode = address.first.postalCode;

    return street! + ', ' + city! + ', ' + postalCode!;
  }
}
