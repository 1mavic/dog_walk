import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:doggie_walker/config/flavor/flavor_enum.dart';
import 'package:doggie_walker/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Flavor Banner Widget. Helps indicate running flavor of application.
/// On tap calls device info popup.
class FlavorBanner extends StatelessWidget {
  /// Banner constructor.
  const FlavorBanner({
    super.key,
    required this.child,
    required this.flavor,
  });

  /// Widget to show under bunner
  final Widget child;

  /// Flavor config
  final Flavor flavor;

  @override
  Widget build(BuildContext context) {
    if (flavor.isProd) return child;
    return _DebugGridWidget(
      show: false, //_debugGrid,
      child: Stack(
        children: <Widget>[
          child,
          Positioned(
            bottom: 0,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onLongPress: () {
                showDialog<Widget>(
                  context: context,
                  builder: (BuildContext context) {
                    return _DeviseInfoDialog(
                      flavor: flavor,
                    );
                  },
                );
              },
              child: SizedBox(
                width: 50,
                height: 50,
                child: CustomPaint(
                  painter: BannerPainter(
                    message: flavor.toString(),
                    textDirection: Directionality.of(context),
                    layoutDirection: Directionality.of(context),
                    location: BannerLocation.bottomStart,
                    color: flavor.getBannerColor,
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

class _DeviseInfoDialog extends StatelessWidget {
  const _DeviseInfoDialog({
    required this.flavor,
  });
  final Flavor flavor;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.only(bottom: 10),
      title: Container(
        padding: const EdgeInsets.all(15),
        color: flavor.getBannerColor,
        child: const Text(
          'Инфо',
          style: TextStyle(color: AppColors.white),
        ),
      ),
      titlePadding: EdgeInsets.zero,
      content: _getContent(
        flavor.toString(),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => const QaScreen(),
            //   ),
            // );
          },
          child: const Text('Экран отладки'),
        )
      ],
    );
  }

  Widget _getContent(String name) {
    if (Platform.isAndroid) {
      return _androidContent(name);
    }
    if (Platform.isIOS) {
      return _iosContent(name);
    }
    return const Text('not ios or android device');
  }

  Widget _androidContent(String name) {
    final deviceInfo = DeviceInfoPlugin();
    return FutureBuilder(
      future: deviceInfo.androidInfo,
      builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
        if (!snapshot.hasData) return Container();
        final device = snapshot.data;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTile('Flavor:', name),
              _buildTile('Physical device?:', '${device?.isPhysicalDevice}'),
              _buildTile('Manufacturer:', '${device?.manufacturer}'),
              _buildTile('Model:', '${device?.model}'),
              _buildTile('Android version:', '${device?.version.release}'),
              _buildTile('Android SDK:', '${device?.version.sdkInt}')
            ],
          ),
        );
      },
    );
  }

  Widget _iosContent(String name) {
    final deviceInfo = DeviceInfoPlugin();
    return FutureBuilder(
      future: deviceInfo.iosInfo,
      builder: (context, AsyncSnapshot<IosDeviceInfo> snapshot) {
        if (!snapshot.hasData) return Container();
        final device = snapshot.data;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTile('Flavor:', name),
              _buildTile('Physical device?:', '${device?.isPhysicalDevice}'),
              _buildTile('Model:', '${device?.model}'),
              _buildTile('system version:', '${device?.systemVersion}'),
              _buildTile('Device name:', '${device?.name}'),
              _buildTile('Id vendor:', '${device?.identifierForVendor}')
            ],
          ),
        );
      },
    );
  }

  Widget _buildTile(String key, String value) {
    return Padding(
      padding: const EdgeInsets.all(5),
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

class _DebugGridWidget extends StatelessWidget {
  const _DebugGridWidget({
    required this.child,
    required this.show,
  });
  final Widget child;
  final bool show;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final size = width / 20;
    if (show == false) {
      return child;
    }
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        alignment: Alignment.center,
        children: [
          child,
          IgnorePointer(
            child: CustomPaint(
              size: Size(width, height),
              painter: _LinePainter(squareSize: size),
            ),
          )
          // InkWell(
          //   //behavior: HitTestBehavior.opaque,
          //   child: GridView.builder(
          //     padding: EdgeInsets.zero,
          //     physics: const NeverScrollableScrollPhysics(),
          //     shrinkWrap: true,
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: _width ~/ _size),
          //     itemBuilder: (BuildContext context, int index) {
          //       return Container(
          //         decoration: BoxDecoration(
          //           border: Border.all(color: AppColors.black, width: 0.1),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _LinePainter extends CustomPainter {
  _LinePainter({
    required this.squareSize,
  });
  final double squareSize;
  @override
  void paint(Canvas canvas, Size size) {
    const strokeColor = Colors.black;
    final line = Paint()
      ..color = strokeColor
      ..strokeWidth = 0.4
      ..style = PaintingStyle.stroke;
    var p1 = Offset(0, size.height - squareSize);
    var p2 = Offset(size.width, size.height - squareSize);
    while (p2.dy > 0) {
      canvas.drawLine(p1, p2, line);
      p1 = Offset(0, p1.dy - squareSize);
      p2 = Offset(size.width, p2.dy - squareSize);
    }
    p1 = Offset(size.width, 0);
    p2 = Offset(size.width, size.height);
    while (p2.dx > 0) {
      canvas.drawLine(p1, p2, line);
      p1 = Offset(p1.dx - squareSize, 0);
      p2 = Offset(p2.dx - squareSize, size.height);
    }
  }

  @override
  bool shouldRepaint(_LinePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_LinePainter oldDelegate) => false;
}
