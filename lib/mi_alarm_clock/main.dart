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
          AlarmItem(context, "06:33"),
          AlarmItem(context, "04:53"),
          AlarmItem(context, "07:23"),
          AlarmItem(context, "08:34"),
          AlarmItem(context, "04:31"),
          AlarmItem(context, "01:23"),
          AlarmItem(context, "06:32"),
          AlarmItem(context, "06:33"),
          AlarmItem(context, "08:23"),
          AlarmItem(context, "04:32"),
          AlarmItem(context, "03:23"),
          AlarmItem(context, "06:33"),
        ],
      ),
    );
  }

  Widget AlarmItem(BuildContext context, String alarmTime) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(AlarmModalRoute());
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
    );
  }
}

class AlarmModalRoute extends ModalRoute {
  @override
  Color? get barrierColor => Colors.red;

  @override
  bool get barrierDismissible => true;

  @override
  String? get barrierLabel => "Alarm Modal";

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    throw FadeTransition(
      opacity: animation,
      child: Hero(
        tag: "e",
        child: Container(
          color: Colors.pinkAccent,
          height: 200,
          width: 300,
        ),
      ),
    );
  }

  @override
  bool get maintainState => false;

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => const Duration(seconds: 4);
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
