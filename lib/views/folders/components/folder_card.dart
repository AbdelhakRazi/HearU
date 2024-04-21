// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hearu/config/colors.dart';
import 'package:hearu/config/measures.dart';

import 'package:hearu/model/folder.dart';
import 'package:hearu/utils/time_utils.dart';
import 'package:intl/intl.dart';

class FolderCard extends StatelessWidget {
  final Folder folder;
  FolderCard({
    super.key,
    required this.folder,
  });
  final DateFormat formatter = DateFormat('dd.MM.yy');
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            onPressed: (context) {},
            foregroundColor: AppColors.red,
            icon: FontAwesomeIcons.trashCan,
          ),
        ],
      ),
      child: Container(
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
                  formatter.format(folder.creationDate),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: AppColors.baseWhite),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Measures.smallPadding),
                      child: Icon(
                        FontAwesomeIcons.headset,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      TimeUtils.printDuration(
                          Duration(seconds: folder.totalLength)),
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
      ),
    );
  }
}
