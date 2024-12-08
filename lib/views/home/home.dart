import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hearu/config/assets.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/views/recording/recording.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          Assets.logo,
          height: 54,
          width: 54,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        width: MediaQuery.of(context).size.height,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.blueMain.withOpacity(0.1),
        ),
        child: Container(
            padding: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.blueMain.withOpacity(0.3),
            ),
            child: Container(
                padding: const EdgeInsets.all(50),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blueMain.withOpacity(0.6),
                ),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.blueMain,
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Recording()));
                      },
                      icon: const Icon(
                        Icons.mic_sharp,
                        size: 54,
                        color: AppColors.white,
                      )),
                ))),
      ),
    );
  }
}
