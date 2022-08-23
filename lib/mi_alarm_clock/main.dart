import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class MIAlarmCustomModalAnatiomPage extends StatefulWidget {
  const MIAlarmCustomModalAnatiomPage({Key? key}) : super(key: key);

  @override
  State<MIAlarmCustomModalAnatiomPage> createState() =>
      _MIAlarmCustomModalAnatiomPageState();
}

class _MIAlarmCustomModalAnatiomPageState
    extends State<MIAlarmCustomModalAnatiomPage> {
  int? openTileId;

  final ScrollController _scrollController = ScrollController();

  void onTileTap(int tileId) {
    print("scroll offset =  ${_scrollController.position.pixels}}");
    setState(() {
      openTileId = tileId;
    });
    print("$openTileId tapped");
  }

  final List<String> alarmTimes = [
    "06:33",
    "04:53",
    "07:23",
    "08:34",
    "04:31",
    "01:23",
    "06:32",
    "06:33",
    "08:34",
    "04:31",
    "04:53",
    "07:23",
    "08:34",
    "04:31",
    "01:23",
    "06:32",
    "01:23",
    "06:32",
    "06:33",
    "08:34",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MI Alarm Clock")),
      body: Stack(
        children: [
          ListView(
            controller: _scrollController,
            children: [
              for (int i = 0; i < alarmTimes.length; i++)
                AlarmItem(
                    context: context,
                    alarmTime: alarmTimes[i],
                    id: i + 1,
                    onTap: (id) => onTileTap(id))
            ],
          ),
          if (openTileId != null)
            Positioned(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    openTileId = null;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: double.infinity,
                  color: Colors.grey[400]!.withOpacity(0.3),
                ),
              ),
            ),
          if (openTileId != null)
            Positioned(
              top: (openTileId! - 1) * 70 - _scrollController.position.pixels,
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width,
                // color: Colors.grey[300],
                child: AnimatedContainer(
                  color: Colors.white,
                  duration: const Duration(milliseconds: 5000),
                  child: AlarmItem(
                    context: context,
                    id: 0,
                    alarmTime: alarmTimes[openTileId! - 1],
                    onTap: (_) {},
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}

class AlarmItem extends StatelessWidget {
  const AlarmItem({
    Key? key,
    required this.context,
    required this.alarmTime,
    required this.id,
    required this.onTap,
  }) : super(key: key);

  final BuildContext context;
  final String alarmTime;
  final int id;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: ListTile(
        onTap: () {
          onTap(id);
        },
        title: RichText(
          text: TextSpan(
            text: alarmTime,
            style: const TextStyle(fontSize: 26, color: Colors.grey),
            children: const [
              WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: SizedBox(width: 5)),
              TextSpan(text: "pm", style: TextStyle(fontSize: 12))
            ],
          ),
        ),
        subtitle: const Text(
          "Once",
          style: TextStyle(color: Colors.grey),
        ),
        trailing: Switch(value: false, onChanged: (_) {}),
      ),
    );
  }
}
