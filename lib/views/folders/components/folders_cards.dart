// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hearu/config/spacing_widgets.dart';

import 'package:hearu/model/folder.dart';
import 'package:hearu/views/folders/components/folder_card.dart';
import 'package:hearu/views/folders/components/search_bar.dart';

class FoldersCards extends StatelessWidget {
  final List<Folder> folders;
  const FoldersCards({
    super.key,
    required this.folders,
  });

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Text(
            "Folders",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SliverToBoxAdapter(child: SpacingWidgets.emptyHeight),
        const SliverToBoxAdapter(child: AppSearchBar()),
        const SliverToBoxAdapter(child: SpacingWidgets.emptyHeight),
        SliverList.builder(
          itemBuilder: (context, index) => FolderCard(folder: folders[index]),
          itemCount: folders.length,
        ),
      ],
    );
  }
}
