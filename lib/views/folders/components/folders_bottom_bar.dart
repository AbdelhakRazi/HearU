import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/config/spacing_widgets.dart';

class FoldersBottomNavbar extends StatelessWidget {
  const FoldersBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    // bottom app bar because i don't need to include navigation here
    return const BottomAppBar(
        color: AppColors.white,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(children: [
            Icon(FontAwesomeIcons.folderPlus, color: AppColors.dark),
            SpacingWidgets.emptyArea,
            Text("CREATE"),
          ]),
        ));
  }
}
