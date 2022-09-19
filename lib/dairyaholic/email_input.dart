import 'package:flutter/material.dart';

class AuthEmailInput extends StatelessWidget {
  const AuthEmailInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          autofocus: false,
          decoration: InputDecoration(
            hintText: "email",
            prefixIcon: Icon(
              Icons.email,
              color: Colors.black.withOpacity(0.5),
            ),
            fillColor: Colors.white.withOpacity(0.3),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.6),
                width: 0.7,
              ),
            ),
            errorStyle: TextStyle(
              color: Colors.pink[200],
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
                borderSide: BorderSide.none),
          ),
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}
