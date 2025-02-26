import 'package:flutter/material.dart';

class NotchClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(
        0, size.height * 0.7); // adjust this value to change notch depth
    path.lineTo(size.width * 0.7,
        size.height * 0.7); // adjust this value to change notch position
    path.lineTo(size.width * 0.7, 0); // adjust this value to change notch width
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
