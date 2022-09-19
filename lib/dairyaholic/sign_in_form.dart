import 'package:flutter/material.dart';

import 'auth_change_page.dart';
import 'email_input.dart';
import 'form_dimensions.dart';
import 'glassmorphism_cover.dart';
import 'password_input.dart';
import 'submit_button.dart';

class SignInForm extends StatefulWidget {
  final void Function() flipCard;

  const SignInForm({
    Key? key,
    required this.flipCard,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
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
                "Log In",
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
                    infoText: "Don't have an account?",
                    flipPageText: "Sign up",
                    flipCard: widget.flipCard,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
