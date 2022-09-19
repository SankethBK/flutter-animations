import 'package:flutter/material.dart';

import 'auth_change_page.dart';
import 'email_input.dart';
import 'form_dimensions.dart';
import 'glassmorphism_cover.dart';
import 'password_input.dart';
import 'submit_button.dart';

class SignUpForm extends StatefulWidget {
  final void Function() flipCard;

  const SignUpForm({
    Key? key,
    required this.flipCard,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool inItialized = false;

  @override
  Widget build(BuildContext context) {
    return GlassMorphismCover(
      borderRadius: BorderRadius.circular(16.0),
      child: FormDimensions(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AuthEmailInput(),
                  const SizedBox(
                    height: 20,
                  ),
                  AuthPasswordInput(),
                  const SizedBox(
                    height: 30,
                  ),
                  SubmitButton(
                    isLoading: false,
                    onSubmitted: () {},
                    buttonText: "Submit",
                  )
                ],
              ),
              Column(
                children: [
                  AuthChangePage(
                    infoText: "Already have an account?",
                    flipPageText: "Log in",
                    flipCard: widget.flipCard,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
