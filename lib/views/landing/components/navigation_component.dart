import 'package:flutter/material.dart';
import 'package:hearu/config/assets.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/config/measures.dart';

import 'authentication_row.dart';

class NavigationComponent extends StatelessWidget {
  const NavigationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.37,
      width: screenSize.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Measures.basicRadius),
          color: AppColors.white),
      padding: const EdgeInsets.only(
          left: Measures.leftRightPadding,
          right: Measures.leftRightPadding,
          bottom: Measures.topBottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Assets.landingTitle,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            Assets.landingBody,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Spacer(),
          const Expanded(flex: 2, child: AuthenticationRow()),
          const Spacer(),
        ],
      ),
    );
  }
}
