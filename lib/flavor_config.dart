import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:doggie_walker/environment.dart';
import 'package:flutter/material.dart';

enum Flavor {
  dev,
  prod,
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  static FlavorConfig? _instance;

  factory FlavorConfig({required Flavor flavor}) {
    _instance ??= FlavorConfig._internal(flavor, flavor.toString());
    return _instance!;
  }
  FlavorConfig._internal(
    this.flavor,
    this.name,
  );
  static bool isProduction() => _instance!.flavor == Flavor.prod;
  static bool isDevelopment() => _instance!.flavor == Flavor.dev;
}

class FlavorBanner extends StatelessWidget {
  final Widget child;

  const FlavorBanner({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (env.appNamePostfix == 'PROD') return child;
    return Stack(
      children: <Widget>[child, const _BannerWidget()],
    );
  }
}

class _BannerWidget extends StatelessWidget {
  const _BannerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BannerConfig config = BannerConfig(bannerName: env.appNamePostfix);
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return const _DeviseInfoDialog();
            });
      },
      child: Container(
        width: 50,
        height: 50,
        child: CustomPaint(
          painter: BannerPainter(
              message: config.bannerName,
              textDirection: Directionality.of(context),
              layoutDirection: Directionality.of(context),
              location: BannerLocation.topStart,
              color: config.getBannerColor()),
        ),
      ),
    );
  }
}

class BannerConfig {
  final String bannerName;
  BannerConfig({required this.bannerName});

  Color getBannerColor() {
    if (bannerName == 'DEV') {
      return Colors.green;
    } else {
      return Colors.transparent;
    }
  }
}

class _DeviseInfoDialog extends StatelessWidget {
  const _DeviseInfoDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BannerConfig config = BannerConfig(bannerName: env.appNamePostfix);
    return AlertDialog(
      contentPadding: const EdgeInsets.only(bottom: 10.0),
      title: Container(
        padding: const EdgeInsets.all(15.0),
        color: config.getBannerColor(),
        child: const Text(
          'Info',
          style: TextStyle(color: Colors.white),
        ),
      ),
      titlePadding: const EdgeInsets.all(0),
      content: _getContent(),
    );
  }

  Widget _getContent() {
    if (Platform.isAndroid) {
      return _androidContent();
    }
    if (Platform.isIOS) {
      return _iosContent();
    }
    return const Text("not ios or android device");
  }

  _androidContent() {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return FutureBuilder(
        future: deviceInfo.androidInfo,
        builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
          if (!snapshot.hasData) return Container();
          AndroidDeviceInfo? device = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTile('Flavor:', '${env.appNamePostfix}'),
                _buildTile('Physical device?:', '${device?.isPhysicalDevice}'),
                _buildTile('Manufacturer:', '${device?.manufacturer}'),
                _buildTile('Model:', '${device?.model}'),
                _buildTile('Android version:', '${device?.version.release}'),
                _buildTile('Android SDK:', '${device?.version.sdkInt}')
              ],
            ),
          );
        });
  }

  _iosContent() {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    return FutureBuilder(
        future: deviceInfo.iosInfo,
        builder: (context, AsyncSnapshot<IosDeviceInfo> snapshot) {
          if (!snapshot.hasData) return Container();
          IosDeviceInfo? device = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _buildTile('Flavor:', '${env.appNamePostfix}'),
                _buildTile('Physical device?:', '${device?.isPhysicalDevice}'),
                _buildTile('Model:', '${device?.model}'),
                _buildTile('system version:', '${device?.systemVersion}'),
                _buildTile('Device name:', '${device?.name}'),
                _buildTile('Id vendor:', '${device?.identifierForVendor}')
              ],
            ),
          );
        });
  }

  Widget _buildTile(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Text(
            key,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 2,
            ),
          )
        ],
      ),
    );
  }
}
