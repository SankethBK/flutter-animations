import 'package:flutter/material.dart';
import 'package:flutter_animations/gmail_compose_button/main.dart';
import 'package:flutter_animations/mi_alarm_clock/main.dart';
import 'package:flutter_animations/whatsapp_fab/main.dart';
import 'package:flutter_animations/whatsapp_profile_page/main.dart';
import 'package:flutter_animations/whatsapp_toolbar/static_layout.dart';

import 'whatsapp_toolbar/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Home());
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const GmailComposeButton()));
                },
                child: const Text("Gmail compose button"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const WhatsAppAppbar(),
                    ),
                  );
                },
                child: const Text("Whatsapp Appbar"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const WhatsAppFab(),
                    ),
                  );
                },
                child: const Text("Whatsapp Fab"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const WhatsappProfilePage(),
                    ),
                  );
                },
                child: const Text("Whatsapp Profile Page"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const MIAlarmCustomModalAnatiomPage(),
                    ),
                  );
                },
                child: const Text("MI Alarm clock"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
