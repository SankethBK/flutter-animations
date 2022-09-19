import 'package:flutter/material.dart';
import 'package:flutter_animations/dairyaholic/sign_in_form.dart';

import 'flip_card_animation.dart';
import 'sign_up_form.dart';

class DairyaholicAuthPage extends StatefulWidget {
  DairyaholicAuthPage({Key? key}) : super(key: key) {}
  static String get route => '/auth';

  @override
  State<DairyaholicAuthPage> createState() => _DairyaholicAuthPageState();
}

class _DairyaholicAuthPageState extends State<DairyaholicAuthPage> {
  late Image neonImage;

  @override
  void initState() {
    super.initState();
    neonImage = Image.asset("assets/images/background.png");
  }

  @override
  void didChangeDependencies() {
    precacheImage(neonImage.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/background.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlipCardAnimation(
                  frontWidget: (void Function() flipCard) {
                    return SignUpForm(flipCard: flipCard);
                  },
                  rearWidget: (void Function() flipCard) {
                    return SignInForm(
                      flipCard: flipCard,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// shdjdjeui
