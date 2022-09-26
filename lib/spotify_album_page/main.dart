import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpotifyAblbumPage extends StatelessWidget {
  const SpotifyAblbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            delegate: SpotifyAppBar(),
            pinned: true,
          ),
          const AlbumInfo(),
          SongsList(),
        ],
      ),
    );
  }
}

class SpotifyAppBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      children: [
        Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.only(top: 25.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.white.withOpacity(0.4),
                Colors.white.withOpacity(0.2)
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            ),
            child: Align(
              alignment: Alignment.center,
              child: AlbumCoverImage(shrinkOffset: shrinkOffset),
            ),
          ),
        ),
        Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 25),
              onPressed: () => Navigator.of(context).pop(),
            )),
        Positioned(
          top: 20,
          left: 60,
          child: AlbumName(
            shrinkoffset: shrinkOffset,
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => 280;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SpotifyAppBar oldDelegate) {
    return true;
  }
}

class AlbumName extends StatelessWidget {
  final double shrinkoffset;
  AlbumName({Key? key, required this.shrinkoffset}) : super(key: key);

  final opacityTween = Tween<double>(begin: 0.0, end: 1.0);

  double getOpacity() {
    // shrinkOffset range: 237 -> 259

    if (shrinkoffset < 237) {
      return 0.0;
    } else if (shrinkoffset > 259) {
      return 1.0;
    }

    return getFractionalValue(259, 237, shrinkoffset);
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: opacityTween.transform(getOpacity()),
      child: const Text("evermore (deluxe version)",
          style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold)),
    );
  }
}

class AlbumCoverImage extends StatelessWidget {
  final double shrinkOffset;

  AlbumCoverImage({Key? key, required this.shrinkOffset}) : super(key: key);

  final scaleTween = Tween<double>(begin: 7.0, end: 2.0);

  final opacityTween = Tween<double>(begin: 1.0, end: 0.0);

  double getScaleValue() {
    // appbarsize start: 280, end: 130

    return min(shrinkOffset, 150) / 150;
  }

  double getOpacityValue() {
    // shrikOffset sttart 160, end: 213

    if (shrinkOffset < 160) {
      return 0;
    } else if (shrinkOffset > 213) {
      return 1;
    }

    return getFractionalValue(213, 160, shrinkOffset);
  }

  @override
  Widget build(BuildContext context) {
    var transformScaleValue = scaleTween.transform(getScaleValue());
    return Opacity(
      opacity: opacityTween.transform(getOpacityValue()),
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..scale(transformScaleValue),
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 15,
            ),
          ], color: Colors.red),
          child: Image.network(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuJBdL2kT21myYKJSZZqqz4pbzcF1kOXCBCyhLlQRCkA&s",
            height: 35,
          ),
        ),
      ),
    );
  }
}

class SongsList extends StatelessWidget {
  SongsList({Key? key}) : super(key: key);

  final songNames = [
    "willow",
    "champagne problems",
    "gold rush",
    "`tis the dam season",
    "tolerate it",
    "no body no crime",
    "happiness",
    "dorothea",
    "coney island",
    "ivy",
    "cowboy like me",
    "long story short",
    "marjorie",
    "closure",
    "evermore",
    "right where you left me",
    "it's time to go"
  ];

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return ListTile(
            tileColor: Colors.black,
            title: Text(
              songNames[index],
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold),
            ),
            subtitle: const Text(
              "Taylor Swift",
              style: TextStyle(color: Colors.white),
            ),
            trailing: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          );
        },
        childCount: songNames.length,
      ),
    );
  }
}

double getFractionalValue(double max, double min, double current) {
  return (current - min) / (max - min);
}

class AlbumInfo extends StatelessWidget {
  const AlbumInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white.withOpacity(0.2),
            Colors.white.withOpacity(0.01),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "evermore (deluxe version)",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 13),
            Row(
              children: const [
                CircleAvatar(
                  radius: 13,
                  backgroundImage: NetworkImage(
                    "https://media.pitchfork.com/photos/618c3ab295b32339a9955837/1:1/w_320,c_limit/Taylor-Swift-Red-Taylors-Version.jpeg",
                  ),
                ),
                SizedBox(width: 8),
                Text("Taylor Swift",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Text("Album",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white.withOpacity(0.7))),
                const SizedBox(width: 5),
                Text("·",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white.withOpacity(0.7))),
                const SizedBox(width: 5),
                Text("2021",
                    style: TextStyle(
                        fontSize: 16, color: Colors.white.withOpacity(0.7))),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(
                  Icons.favorite,
                  color: Color.fromARGB(255, 31, 213, 97),
                  size: 30,
                ),
                const SizedBox(width: 25),
                Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                        )),
                    child: Icon(
                      Icons.arrow_downward,
                      color: Colors.white.withOpacity(0.8),
                    )),
                const SizedBox(width: 25),
                const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                  size: 30,
                ),
                const Spacer(),
                Icon(
                  Icons.shuffle,
                  size: 30,
                  color: Colors.white.withOpacity(0.8),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
