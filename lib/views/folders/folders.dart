import 'package:flutter/material.dart';
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
          FoldersCards(
            folders: [
              Folder(
                  name: "abdeka",
                  nbRecords: 5,
                  creationDate: "date",
                  totalLength: 50.4),
              Folder(
                  name: "abdeka",
                  nbRecords: 5,
                  creationDate: "date",
                  totalLength: 50.4),
              Folder(
                  name: "abdeka",
                  nbRecords: 5,
                  creationDate: "date",
                  totalLength: 50.4),
            ],
          ),
        ],
      ),
    );
  }
}
