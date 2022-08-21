import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class MIAlarmCustomModalAnatiomPage extends StatelessWidget {
  const MIAlarmCustomModalAnatiomPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("MI Alarm Clock")),
      body: ListView(
        children: [
          AlarmItem(context: context, alarmTime: "06:33"),
          AlarmItem(context: context, alarmTime: "04:53"),
          AlarmItem(context: context, alarmTime: "07:23"),
          AlarmItem(context: context, alarmTime: "08:34"),
          AlarmItem(context: context, alarmTime: "04:31"),
          AlarmItem(context: context, alarmTime: "01:23"),
          AlarmItem(context: context, alarmTime: "06:32"),
          AlarmItem(context: context, alarmTime: "06:33"),
          AlarmItem(context: context, alarmTime: "08:23"),
          AlarmItem(context: context, alarmTime: "04:32"),
          AlarmItem(context: context, alarmTime: "03:23"),
          AlarmItem(context: context, alarmTime: "06:33"),
        ],
      ),
    );
  }
}

class AlarmItem extends StatefulWidget {
  const AlarmItem({
    Key? key,
    required this.context,
    required this.alarmTime,
  }) : super(key: key);

  final BuildContext context;
  final String alarmTime;

  @override
  State<AlarmItem> createState() => _AlarmItemState();
}

class _AlarmItemState extends State<AlarmItem> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    print("rebuilding listitem ${widget.alarmTime}");
    return SizedBox(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          AnimatedPositioned(
            // top: !isOpen ? 0 : -50,
            bottom: !isOpen ? 0 : -50,
            duration: const Duration(milliseconds: 1000),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 1000),
              width: !isOpen
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width * 0.8,
              color: !isOpen ? Colors.white : Colors.grey[100],
              child: ListTile(
                onTap: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                title: RichText(
                  text: TextSpan(
                    text: widget.alarmTime,
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
            ),
          ),
        ],
      ),
    );
  }
}
