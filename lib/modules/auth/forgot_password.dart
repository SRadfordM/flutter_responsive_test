import 'package:flutter/material.dart';
import 'package:screen_util_test/utils/routes.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(IofRouter.forgotPassword);
      },
      child: Text(
        "Forgot Password?",
        style: TextStyle(
          fontSize: 18.0,
        ),
      ),
    );
  }
}