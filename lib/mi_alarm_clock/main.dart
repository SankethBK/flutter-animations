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
          AlarmItem("06:33"),
          AlarmItem("04:53"),
          AlarmItem("07:23"),
          AlarmItem("08:34"),
          AlarmItem("04:31"),
          AlarmItem("01:23"),
          AlarmItem("06:32"),
          AlarmItem("06:33"),
          AlarmItem("08:23"),
          AlarmItem("04:32"),
          AlarmItem("03:23"),
          AlarmItem("06:33"),
        ],
      ),
    );
  }

  Widget AlarmItem(String alarmTime) {
    return OpenContainer(
      transitionDuration: const Duration(milliseconds: 3000),
      openBuilder: (BuildContext context,
          void Function({Object? returnValue}) closeContainer) {
        return AlarmModal();
      },
      closedBuilder: (BuildContext context, void Function() openContainer) {
        return Hero(
          tag: "e",
          child: ListTile(
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
      },
    );
  }
}

class AlarmModal extends StatelessWidget {
  const AlarmModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: 200,
        width: 300,
        color: Colors.blueAccent,
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: "e",
            child: ListTile(
              title: RichText(
                text: TextSpan(
                  text: "06:00",
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
      ),
    );
  }
}
