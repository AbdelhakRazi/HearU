import 'package:flutter/material.dart';
import 'package:hearu/config/assets.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/config/measures.dart';

import 'authentication_row.dart';

class NavigationComponent extends StatelessWidget {
  const NavigationComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Measures.basicRadius),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.dark.withOpacity(0.1),
                offset: const Offset(0, -5),
                blurRadius: 20,
                spreadRadius: 50)
          ]),
      padding: const EdgeInsets.symmetric(
          horizontal: Measures.leftRightPadding,
          vertical: Measures.topBottomPadding),
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
          Expanded(flex: 2, child: AuthenticationRow(title: "Sign in")),
          const Spacer(),
        ],
      ),
    );
  }
}
