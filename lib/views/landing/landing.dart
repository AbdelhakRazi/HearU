import 'package:flutter/material.dart';

import 'components/images_component.dart';
import 'components/navigation_component.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Stack(
      children: [
        Positioned(top: 0, child: ImagesComponent()),
        Positioned(bottom: 0, child: NavigationComponent())
      ],
    ));
  }
}
