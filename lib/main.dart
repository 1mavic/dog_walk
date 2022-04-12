import 'dart:developer';

import 'package:doggie_walker/environment.dart';
import 'package:doggie_walker/flavor_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() async {
  env = await loadEnvironment();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlavorBanner(child: MapScreen()),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  final CameraPosition _kLake = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final circle = Circle(
      circleId: CircleId('first'),
      center: LatLng(37.43296265331129, -122.08832357078792),
      radius: 50,
      fillColor: Colors.blueAccent,
      visible: true,
      strokeColor: Colors.blue,
      consumeTapEvents: true,
      onTap: () => log('tap'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _DrawerWidget(),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal, //satellite normal
            initialCameraPosition: _kGooglePlex,
            //myLocationButtonEnabled: false,
            circles: {circle},
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {},
          ),
          _DrawerButtonWidget()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(CupertinoIcons.location_circle),
      ),
    );
  }
}

class _DrawerButtonWidget extends StatelessWidget {
  const _DrawerButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      right: 16,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            Scaffold.of(context).openEndDrawer();
          },
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor, shape: BoxShape.circle),
            padding: const EdgeInsets.all(6),
            child: const Icon(
              CupertinoIcons.line_horizontal_3,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerWidget extends StatelessWidget {
  const _DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Text('header'),
                duration: Duration(microseconds: 900),
              )
            ],
          ),
          Positioned(
            top: 10,
            right: 16,
            child: SafeArea(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    CupertinoIcons.clear,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
