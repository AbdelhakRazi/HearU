import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/config/measures.dart';

class FoldersAppBar extends StatelessWidget {
  const FoldersAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      leading: Icon(
        FontAwesomeIcons.chevronLeft,
        color: AppColors.dark,
      ),
      actions: [
        Icon(
          FontAwesomeIcons.magnifyingGlass,
          color: AppColors.dark,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: Measures.smallPadding),
            child: Icon(FontAwesomeIcons.ellipsis))
      ],
    );
  }
}
