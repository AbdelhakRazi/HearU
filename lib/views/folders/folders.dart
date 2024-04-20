import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hearu/config/measures.dart';
import 'package:hearu/model/folder.dart';
import 'package:hearu/views/folders/components/folders_app_bar.dart';
import 'package:hearu/views/folders/components/folders_bottom_bar.dart';
import 'package:hearu/views/folders/components/folders_cards.dart';

class Folders extends StatefulWidget {
  const Folders({super.key});

  @override
  State<Folders> createState() => _FoldersState();
}

class _FoldersState extends State<Folders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const FoldersBottomNavbar(),
      body: CustomScrollView(
        slivers: [
          const FoldersAppBar(),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
                horizontal: Measures.leftRightPadding),
            sliver: FoldersCards(
                folders: List.generate(
              20,
              (index) => Folder(
                  name: "My Folder",
                  nbRecords: 5,
                  creationDate: "date",
                  totalLength: 50.4),
            )),
          ),
        ],
      ),
    );
  }
}
