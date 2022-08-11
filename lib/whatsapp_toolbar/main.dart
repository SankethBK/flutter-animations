import 'package:flutter/material.dart';

class WhatsappAppbar extends StatelessWidget {
  const WhatsappAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: 4,
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: <Widget>[
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
              const Messages()
            ],
          ),
        ),
      ),
    );
  }
}

class FloatingAppBar extends SliverPersistentHeaderDelegate {
  final double size;
  FloatingAppBar(this.size);

  @override
  double get minExtent => size;
  @override
  double get maxExtent => size;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      height: size,
      width: double.infinity,
      color: Colors.green[600],
      child: Row(
        children: const [
          Text(
            "Whatsapp",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Spacer(),
          Icon(Icons.search, size: 30, color: Colors.white),
          SizedBox(width: 10),
          Icon(Icons.more_vert, size: 30, color: Colors.white)
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(FloatingAppBar oldDelegate) {
    return false;
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
            title: Text("Mr. White"),
            subtitle: Text("We need to cook"),
          );
        },
      ),
    );
  }
}
