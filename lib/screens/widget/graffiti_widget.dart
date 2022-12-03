import 'package:flutter/material.dart';
import 'package:nfc_tagger/functions/arguments.dart';
import 'package:nfc_tagger/functions/device_size.dart';
import 'package:nfc_tagger/functions/helper_functions.dart';
import 'package:nfc_tagger/models/tag_data.dart';
import 'package:nfc_tagger/screens/stack/add_new_graffito.dart';
import 'package:nfc_tagger/styles/themes.dart';

import '../../database/db_operations.dart';
import 'graffiti_tile.dart';

class GraffitiScreen extends StatefulWidget {
  final List identifier;
  const GraffitiScreen({required this.identifier, super.key});

  @override
  State<GraffitiScreen> createState() => _GraffitiScreenState();
}

/// Look at the graffiti that are added to the tag
class _GraffitiScreenState extends State<GraffitiScreen> {
  TagData? tagData;
  bool? documentExists;
  double? height;
  double? width;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await checkIfTagExists(widget.identifier).then((value) async {
      if (value) {
        tagData = await getTagData(widget.identifier);
        tagData!.graffiti = sortByTime(tagData!.graffiti!);
        documentExists = value;
      } else {
        documentExists = value;
      }
      setState(() {});
    });
  }

  Widget showLoading() {
    return Stack(
      children: const [
        Opacity(
          opacity: 0.8,
          child: ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: CircularProgressIndicator(),
        ),
      ],
    );
  }

  Widget showGraffitiRecords() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
              backgroundColor: secondary,
            ),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(
                AddNewGraffito.routeName,
                arguments: AddNewGraffitiArguments(
                  widget.identifier,
                  tagData!.graffiti!,
                ),
              )
                  .whenComplete(() {
                fetchData();
              });
            },
            child: const Text(
              'Add Graffiti',
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        SizedBox(
          height: DeviceSize.screenHeight / 40,
        ),
        Expanded(
          child: (tagData!.graffiti != null && tagData!.graffiti!.isNotEmpty)
              ? ListView.separated(
                  separatorBuilder: ((context, index) {
                    return const SizedBox(
                      height: 30,
                    );
                  }),
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: tagData!.graffiti!.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 10, 0),
                      child: graffitiTile(tagData!.graffiti!.elementAt(index)),
                    );
                  }),
                )
              : const Text("Empty Records"),
        ),
        SizedBox(
          height: DeviceSize.screenHeight / 40,
        ),
      ],
    );
  }

  invalidTag() {
    return const Center(
      child: Text("This tag is not valid"),
    );
  }

  /// tagData is null = show loading icon;
  /// tagData is not null but tagData.graffiti is null/array empty = No records exists for the tag
  /// tagData is not null  & tagData.graffiti is not null/not empty = show records in a list.

  @override
  Widget build(BuildContext context) {
    return documentExists == null
        ? showLoading()
        : documentExists == true
            ? showGraffitiRecords()
            : invalidTag();
  }
}
