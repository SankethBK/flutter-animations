import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum ScrollState { up, down, none }

class GmailComposeButton extends StatefulWidget {
  const GmailComposeButton({Key? key}) : super(key: key);

  @override
  State<GmailComposeButton> createState() => _GmailComposeButtonState();
}

class _GmailComposeButtonState extends State<GmailComposeButton> {
  // ScrollState scrollState = ScrollState.none;
  bool isButtonExpanded = true;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Gmail compose button")),
        body: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (_scrollController.position.userScrollDirection ==
                ScrollDirection.reverse) {
              if (isButtonExpanded == true) {
                setState(() {
                  isButtonExpanded = false;
                });
              }
            } else if (_scrollController.position.userScrollDirection ==
                ScrollDirection.forward) {
              if (isButtonExpanded == false) {
                setState(() {
                  isButtonExpanded = true;
                });
              }
            } else if (_scrollController.position.userScrollDirection ==
                ScrollDirection.idle) {}
            return true;
          },
          child: ListView.builder(
            controller: _scrollController,
            itemCount: 25,
            itemBuilder: (BuildContext content, int index) {
              return const ListTile(
                leading: Icon(Icons.face),
                title: Text(
                  "Your privacy is more important than ever",
                  maxLines: 1,
                ),
                subtitle: Text(
                  "With more and more of your personal information online — from banking and medical details to your physical location — it's more important than ever to protect yourself. (Don't believe us? Check out this episode of John Oliver's Last Week Tonight on data brokers.)",
                  maxLines: 1,
                ),
              );
            },
          ),
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 15),
          decoration: const BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              AnimatedContainer(
                padding: const EdgeInsets.only(left: 8),
                duration: const Duration(milliseconds: 300),
                width: isButtonExpanded ? 80 : 0,
                child: const Text(
                  "Compose",
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }
}
