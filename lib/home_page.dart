import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const LatLng currentLocation = LatLng(25.1193, 55.3773);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;
  MapType mapType = MapType.normal;
  LatLng dohaLocation = const LatLng(25.2854, 51.5310);
  LatLng saudiLocation = const LatLng(23.8859, 45.0792);
  Map<String, Marker> _markers = {};

  Future<bool> _onWillPop() async {
    if (_markers.isEmpty) {
      // Navigator.of(context).pop(true);
      return true;
    } else {
      _markers.clear();
      setState(() {});
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: GoogleMap(
          mapType: mapType,
          initialCameraPosition: const CameraPosition(
            target: currentLocation,
            zoom: 14,
            // bearing: 90,
          ),
          onMapCreated: (controller) {
            mapController = controller;
          },
          markers: _markers.values.toSet(),
          onTap: _handleTap,
          onLongPress: (location) {
            _markers.clear();
            setState(() {});
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: Column(
          verticalDirection: VerticalDirection.up,
          children: [
            FloatingActionButton(
                // heroTag: 'btn1',
                heroTag: UniqueKey(),
                child: const Icon(Icons.assistant_navigation),
                onPressed: () {
                  mapController.moveCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(target: dohaLocation, zoom: 13)));
                  // mapController.moveCamera(CameraUpdate.newLatLng(dohaLocation));
                }),
            FloatingActionButton(
                // heroTag: 'btn2',
                heroTag: UniqueKey(),
                backgroundColor: Colors.red,
                child: const Icon(Icons.animation),
                onPressed: () {
                  mapController.animateCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(target: saudiLocation, zoom: 13)));
                  setState(() {
                    mapType = MapType.hybrid;
                  });
                }),
          ],
        ),
      ),
    );
  }

  void _handleTap(LatLng location) {
    addMarker(location.toString(), location);
  }

  void addMarker(String id, LatLng location) {
    Marker marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: InfoWindow(title: location.toString()),
    );

    _markers[id] = marker;
    setState(() {});
  }
}
