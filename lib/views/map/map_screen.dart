import 'package:dymogo/constants.dart';
import 'package:dymogo/widgets/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:dymogo/viewmodel/map/location_service.dart';

void main() {
  runApp(const MaterialApp(home: MapScreen()));
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;
  late final VoidCallback latLng;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: LocationService.locationGet(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return const Text(
            'There was an error :(',
          );
        } else if (snapshot.hasData) {
          var lat = snapshot.data.latitude;
          var lng = snapshot.data.longitude;
          return Scaffold(
              endDrawer: NavigationDrawerWidget(),
              appBar: AppBar(
                leading: GestureDetector(
                  onTap: () => {
                    Navigator.pop(context),
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: kDarkTextColor,
                  ),
                ),
                backgroundColor: Color.fromARGB(0, 255, 255, 255),
                elevation: 0.0,
              ),
              extendBodyBehindAppBar: true,
              body: FlutterMap(
                options: MapOptions(center: LatLng(lat, lng), zoom: 14.0),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c'],
                  ),
                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 80.0,
                        height: 80.0,
                        point: LatLng(lat, lng),
                        builder: (ctx) => Container(
                          child: Icon(Icons.location_on),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
        }
        return const Center(
            child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor)));
      },
    );
  }
}
