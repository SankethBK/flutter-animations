import 'package:flutter/material.dart';

import 'static_layout.dart';

class WhatsAppAppbar2 extends StatelessWidget {
  const WhatsAppAppbar2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  const SliverAppBar(
                    title: Text("Whatsapp"),
                    centerTitle: false,
                    automaticallyImplyLeading: false,
                    floating: true,
                    backgroundColor: Color.fromARGB(255, 4, 94, 84),
                    actions: [
                      Icon(Icons.search, size: 30, color: Colors.white),
                      SizedBox(width: 10),
                      Icon(Icons.more_vert, size: 30, color: Colors.white),
                    ],
                    elevation: 0.0,
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: WhatsappTabs(50.0),
                  ),
                ];
              },
              body: TabBarView(
                  children: tabs.map((String name) {
                return const CustomScrollView(
                  slivers: [
                    Messages(),
                  ],
                );
              }).toList())),
        ),
      ),
    );
  }
}

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Camera Page"),
    );
  }
}

class StatusPage extends StatelessWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [],
    );
  }
}
