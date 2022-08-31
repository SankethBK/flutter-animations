import 'package:flutter/material.dart';

class ScrollControllerDemo extends StatefulWidget {
  const ScrollControllerDemo({Key? key}) : super(key: key);

  @override
  State<ScrollControllerDemo> createState() => _ScrollControllerDemoState();
}

class _ScrollControllerDemoState extends State<ScrollControllerDemo> {
  late ScrollController _scrollController;
  final int numListElements = 30;
  final double listTileHeight = 70;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToTop() {
    _scrollController.jumpTo(0.0);
  }

  void scrollToBottom() {
    // to scroll to bottom, we need to subtract screen's height from the total height of the list
    _scrollController.jumpTo(
        numListElements * listTileHeight - MediaQuery.of(context).size.height);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: _scrollController,
      children: [
        for (int i = 0; i < numListElements; i++)
          SizedBox(
            height: listTileHeight,
            child: ListTile(
              title: Text("Tile $i"),
            ),
          ),
      ],
    );
  }
}
