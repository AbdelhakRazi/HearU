// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/config/measures.dart';
import 'package:hearu/config/spacing_widgets.dart';

import 'package:hearu/model/folder.dart';
import 'package:hearu/views/folders/components/notched_container.dart';

class FolderCard extends StatelessWidget {
  final Folder folder;
  const FolderCard({
    super.key,
    required this.folder,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: Measures.topBottomPadding),
      padding: const EdgeInsets.symmetric(
          horizontal: Measures.leftRightPadding,
          vertical: Measures.topBottomPadding),
      decoration: BoxDecoration(
        color: AppColors.blueMain,
        borderRadius: BorderRadius.circular(Measures.basicRadius / 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            folder.name,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColors.baseWhite),
          ),
          Text(
            "${folder.nbRecords} Records",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: AppColors.baseWhite),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${folder.creationDate}",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: AppColors.baseWhite),
              ),
              Row(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Measures.smallPadding),
                    child: Icon(
                      FontAwesomeIcons.headset,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    "${folder.totalLength}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: AppColors.baseWhite),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
