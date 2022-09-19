import 'package:flutter/material.dart';

class AuthPasswordInput extends StatefulWidget {
  final String hintText;
  const AuthPasswordInput({
    Key? key,
    this.hintText = "password",
  }) : super(key: key);

  @override
  State<AuthPasswordInput> createState() => _AuthPasswordInputState();
}

class _AuthPasswordInputState extends State<AuthPasswordInput> {
  bool _passwordVisibility = true;

  void _togglePasswordVisibility() => setState(() {
        _passwordVisibility = !_passwordVisibility;
      });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          autofocus: false,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Icon(
              Icons.lock,
              color: Colors.black.withOpacity(0.5),
            ),
            suffixIcon: InkWell(
                onTap: _togglePasswordVisibility,
                child: Icon(
                  !_passwordVisibility
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black.withOpacity(0.5),
                )),
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
              color: Colors.pink[300],
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
          ),
          keyboardType: TextInputType.emailAddress,
          obscureText: _passwordVisibility,
        ),
      ],
    );
  }
}
