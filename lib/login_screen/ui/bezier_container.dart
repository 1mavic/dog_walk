import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// container with bezier shape widget
class BezierContainerWidget extends StatelessWidget {
  /// container with bezier shape widget
  const BezierContainerWidget({
    super.key,
    required this.color,
    required this.height,
  });

  /// color of container
  final Color color;

  /// container height
  final double height;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _BezierClipper(),
      child: ColoredBox(
        color: color,
        child: SizedBox(
          height: height,
          width: double.infinity,
          child: Align(
            alignment: const Alignment(-1, -0.5),
            child: IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: Theme.of(context).secondaryHeaderColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final height = size.height;
    final width = size.width;
    final path = Path()
      ..lineTo(0, height / 2)
      ..quadraticBezierTo(width / 4, height / 4, width / 2, height / 2)
      ..quadraticBezierTo(width / 4 * 3, height / 4 * 3, width, height / 2)
      ..lineTo(width, 0)
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
