import 'package:flutter/material.dart';

class WhatsAppAppbar extends StatelessWidget {
  const WhatsAppAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    return DefaultTabController(
      length: 4,
      initialIndex: 1,
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
              children: tabs.map(
                (String name) {
                  return const CustomScrollView(
                    slivers: [
                      Messages(),
                    ],
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class WhatsappTabs extends SliverPersistentHeaderDelegate {
  final double size;

  WhatsappTabs(this.size);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color.fromARGB(255, 4, 94, 84),
      height: size,
      child: const TabBar(
        indicatorWeight: 3,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        // isScrollable: true,
        tabs: <Widget>[
          Tab(icon: Icon(Icons.camera_alt)),
          Tab(text: "Chats"),
          Tab(text: "Status"),
          Tab(text: "Calls"),
        ],
      ),
    );
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(WhatsappTabs oldDelegate) {
    return oldDelegate.size != size;
  }
}

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
            ),
            title: Text("Mr. H"),
            subtitle: Text("Hey there, look at the appbar"),
          );
        },
      ),
    );
  }
}
