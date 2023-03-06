import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

const LatLng currentLocation = LatLng(25.1193, 55.3773);

class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  State<HomePage3> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage3> {
  late GoogleMapController mapController;
  MapType mapType = MapType.normal;
  LatLng dohaLocation = const LatLng(25.2854, 51.5310);
  LatLng saudiLocation = const LatLng(23.8859, 45.0792);
  List<Marker> droppedPin = [];

  String place = '';
  List<String> p = [];

  Future<bool> _onWillPop() async {
    if (droppedPin.isEmpty) {
      // Navigator.of(context).pop(true);
      return true;
    } else {
      droppedPin.clear();
      place = '';
      setState(() {});
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              child: GoogleMap(
                mapType: mapType,
                initialCameraPosition: const CameraPosition(
                  target: currentLocation,
                  zoom: 14,
                  // bearing: 90,
                ),
                onMapCreated: (controller) {
                  mapController = controller;
                },
                markers: droppedPin.toSet(),
                onTap: addSingleMarker,
                onLongPress: (location) {
                  droppedPin.clear();
                  setState(() {});
                },
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     print(droppedPin.toSet());
            //     print('object');
            //   },
            //   child: Container(
            //     height: MediaQuery.of(context).size.height / 2,
            //     width: MediaQuery.of(context).size.width,
            //     color: Colors.grey,
            //     child: Text(place),
            //     alignment: Alignment.topCenter,
            //   ),
            // ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Text(p.toString()),
              alignment: Alignment.topCenter,
            ),
          ],
        ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButton: Column(
          verticalDirection: VerticalDirection.up,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
                heroTag: 'btn1',
                child: const Icon(Icons.assistant_navigation),
                onPressed: () {
                  mapController.moveCamera(
                      CameraUpdate.newCameraPosition(CameraPosition(target: dohaLocation, zoom: 13)));
                  // mapController.moveCamera(CameraUpdate.newLatLng(dohaLocation));
                }),
            FloatingActionButton(
                heroTag: 'btn2',
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

  void addSingleMarker(LatLng location) {
    droppedPin = [
      Marker(
        markerId: MarkerId(location.toString()),
        position: location,
      )
    ];
    placemarkFromCoordinates(location.latitude, location.longitude, localeIdentifier: 'ar_AE')
        .then((placemarks) {
      var output = 'No results found.';
      if (placemarks.isNotEmpty) {
        output = placemarks[0].toString();
        Placemark pm = placemarks[0];
        p.clear();
        p.addAll([
          '${pm.locality}\n' ?? '',
          '${pm.country}\n' ?? '',
          '${pm.subLocality}'
              '--\n',
        ]);
      }

      setState(() {
        place = output;
      });
    });

    setState(() {});
  }
}
