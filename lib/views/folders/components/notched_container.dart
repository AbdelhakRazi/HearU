// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hearu/views/folders/components/notched_clipper.dart';

class NotchedContainer extends StatelessWidget {
  final Widget child;
  const NotchedContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: NotchClipper(),
          child: Container(
            width: 50, // width of the notch
            height: 50, // height of the notch
            color: Colors.blue, // same color as the container
            child: Center(child: child),
          ),
        ),
        Text("alo")
      ],
    );
  }
}
