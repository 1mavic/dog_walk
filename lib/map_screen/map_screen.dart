import 'dart:developer';

import 'package:doggie_walker/bloc/user_bloc/user_bloc.dart';
import 'package:doggie_walker/ui/main_screen_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// scrren with map and controll fabs
class MapScreen extends StatefulWidget {
  /// scrren with map and controll fabs
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 4.4746,
  );

  // final CameraPosition _kLake = const CameraPosition(
  //   bearing: 192.8334901395799,
  //   target: LatLng(37.43296265331129, -122.08832357078792),
  //   tilt: 59.440717697143555,
  //   zoom: 19.151926040649414,
  // );
  final circle = Circle(
    circleId: const CircleId('first'),
    center: const LatLng(37.43296265331129, -122.08832357078792),
    radius: 50,
    fillColor: Colors.blueAccent,
    // visible: true,
    strokeColor: Colors.blue,
    consumeTapEvents: true,
    onTap: () => log(
      'tap',
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerWidget(),
      body: Stack(
        children: [
          GoogleMap(
            // mapType: MapType.normal, //satellite normal
            initialCameraPosition: _kGooglePlex,
            //myLocationButtonEnabled: false,
            circles: {circle},
            myLocationButtonEnabled: false,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {},
          ),
          const _DrawerButtonWidget()
        ],
      ),
      floatingActionButton: const FloatingButtonsWidget(),
    );
  }
}

class _DrawerButtonWidget extends StatelessWidget {
  const _DrawerButtonWidget();

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
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
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

/// fab on main button widget
class FloatingButtonsWidget extends HookWidget {
  /// fab on main button widget
  const FloatingButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isExpanded = useState(false);
    return SafeArea(
      child: SizedBox.expand(
        child: Stack(
          alignment: Alignment.bottomRight,
          //mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _SmallFabWidget(
              heroTag: 'a',
              bottom: isExpanded.value ? 65 : 0,
              right: 7,
              icon: CupertinoIcons.person,
              onTap: () => context.read<UserBloc>().add(
                    const LoginUserEvent(
                      email: 'amacegora1@gmail.com',
                      password: 'password',
                    ),
                  ),
            ),
            _SmallFabWidget(
              heroTag: 'b',
              bottom: isExpanded.value ? 120 : 0,
              right: 7,
              icon: CupertinoIcons.arrow_turn_left_down,
              onTap: () =>
                  context.read<UserBloc>().add(const LogOutUserEvent()),
            ),
            _SmallFabWidget(
              heroTag: 'c',
              bottom: 7,
              right: isExpanded.value ? 65 : 0,
              icon: CupertinoIcons.location_circle,
              onTap: () => context.read<UserBloc>().add(
                    const CreateUserEvent(
                      email: 'test@gmail.com',
                      password: 'password',
                    ),
                  ),
            ),
            FloatingActionButton(
              heroTag: '1',
              onPressed: () {
                isExpanded.value = !isExpanded.value;
              },
              child: const Icon(CupertinoIcons.settings),
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallFabWidget extends StatelessWidget {
  const _SmallFabWidget({
    required this.bottom,
    required this.right,
    required this.icon,
    required this.onTap,
    required this.heroTag,
  });
  final double bottom;
  final double right;
  final IconData icon;
  final VoidCallback onTap;
  final String heroTag;
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 400),
      curve: Curves.decelerate,
      bottom: bottom,
      right: right,
      child: SizedBox.square(
        dimension: 45,
        child: FloatingActionButton(
          heroTag: heroTag,
          onPressed: onTap,
          //  {
          // S.load(
          //   const Locale(
          //     'ru_RU',
          //   ),
          // );
          //   context.read<UserBloc>().add(CreateUserEvent());
          // },
          child: Icon(icon),
        ),
      ),
    );
  }
}
