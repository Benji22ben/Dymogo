import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

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
  bool _isGetLocation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
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

                  _locationData = await location.getLocation();

                  setState(() {
                    _isGetLocation = true;
                  });
                },
                child: const Text('Récupérer localisation')),
            _isGetLocation
                ? Text(
                    'Localisation: ${_locationData.latitude}/${_locationData.longitude}')
                : Container(),
            _isGetLocation
                ? Flexible(
                    child: FlutterMap(
                    options: MapOptions(
                        center: LatLng(
                            _locationData.latitude!, _locationData.longitude!),
                        zoom: 15),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                        attributionBuilder: (_) {
                          return const Text("© OpenStreetMap contributors");
                        },
                      ),
                      MarkerLayerOptions(markers: [
                        Marker(
                            point: LatLng(_locationData.latitude!,
                                _locationData.longitude!),
                            builder: (context) => const Icon(
                                  Icons.pin_drop,
                                  size: 40,
                                ))
                      ])
                    ],
                  ))
                : Container()
          ],
        ),
      ),
    );
  }
}
