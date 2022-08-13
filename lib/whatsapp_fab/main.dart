import 'package:flutter/material.dart';

class WhatsAppFab extends StatefulWidget {
  const WhatsAppFab({Key? key}) : super(key: key);

  @override
  State<WhatsAppFab> createState() => _WhatsAppFabState();
}

class _WhatsAppFabState extends State<WhatsAppFab>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int activeTab = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);

    tabController!.addListener(() {
      if (tabController?.index != activeTab) {
        setState(() {
          activeTab = tabController!.index;
        });
      }
    });
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  Widget getIoncForFab(index) {
    switch (index) {
      case 2:
        return const Icon(Icons.camera_alt);
      case 3:
        return const Icon(Icons.phone);
      case 1:
        return const Icon(Icons.post_add);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        floatingActionButton: (activeTab != 0)
            ? Stack(
                alignment: AlignmentDirectional.center,
                clipBehavior: Clip.none,
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    bottom: activeTab == 2 ? 70 : 0,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[500],
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                  FloatingActionButton(
                      backgroundColor: const Color.fromARGB(255, 4, 94, 84),
                      onPressed: () {},
                      child: getIoncForFab(activeTab)),
                ],
              )
            : const SizedBox.shrink(),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                delegate: WhatsappTabs(50.0, tabController!),
              ),
            ];
          },
          body: TabBarView(
            controller: tabController,
            children: const [
              CustomScrollView(
                slivers: [
                  CameraPage(),
                ],
              ),
              CustomScrollView(
                slivers: [
                  Messages(),
                ],
              ),
              CustomScrollView(
                slivers: [
                  Status(),
                ],
              ),
              CustomScrollView(
                slivers: [
                  Calls(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CameraPage extends StatelessWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: Center(
        child: Text("Camera Page"),
      ),
    );
  }
}

class WhatsappTabs extends SliverPersistentHeaderDelegate {
  final double size;
  final TabController tabController;

  WhatsappTabs(this.size, this.tabController);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color.fromARGB(255, 4, 94, 84),
      height: size,
      child: TabBar(
        controller: tabController,
        indicatorWeight: 3,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white60,
        // isScrollable: true,
        tabs: const <Widget>[
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

class Status extends StatelessWidget {
  const Status({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          const Padding(
            padding: EdgeInsets.all(
              15.0,
            ),
            child: Text(
              "Status",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
            ),
            title: Text("Mr. White"),
            subtitle: Text("Today 12:13 PM"),
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
            ),
            title: Text("Mr. White"),
            subtitle: Text("Today 12:14 PM"),
          ),
          const ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEgzwHNJhsADqquO7m7NFcXLbZdFZ2gM73x8I82vhyhg&s"),
            ),
            title: Text("Mr. White"),
            subtitle: Text("Today 12:14 PM"),
          )
        ],
      ),
    );
  }
}

class Calls extends StatelessWidget {
  const Calls({Key? key}) : super(key: key);

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
            subtitle: Text("12:15 PM"),
            trailing: Icon(
              Icons.call_received,
              color: Colors.green,
            ),
          );
        },
        childCount: 6,
      ),
    );
  }
}
