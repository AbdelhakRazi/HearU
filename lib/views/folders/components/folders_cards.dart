// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hearu/model/folder.dart';
import 'package:hearu/views/folders/components/folder_card.dart';

class FoldersCards extends StatelessWidget {
  final List<Folder> folders;
  const FoldersCards({
    super.key,
    required this.folders,
  });

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemBuilder: (context, index) => FolderCard(folder: folders[index]),
      itemCount: folders.length,
    );
  }
}
