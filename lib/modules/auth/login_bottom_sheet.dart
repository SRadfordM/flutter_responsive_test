import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screen_util_test/styling/colors.dart';

import 'forgot_password.dart';
import 'login_form.dart';

class LoginBottomSheet extends StatefulWidget {

  final BuildContext parentContext;

  LoginBottomSheet({@required this.parentContext});

  @override
  _LoginBottomSheetState createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  Widget registrationLink() {
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: Text(
          'Don\'t have an account yet? Sign Up',
          style: TextStyle(
              color: Colors.blue,
              fontSize: 18.0,
              fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    Size size = mq.size;
    EdgeInsets padding = mq.padding;
    double safeVertical = size.height - (padding.top + padding.bottom);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
          color: grayedBackground,
          child: Container(
            decoration: BoxDecoration(
            color: Theme.of(widget.parentContext).canvasColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(22.0),
              topRight: const Radius.circular(22.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF3F3F3), Color(0xFFE9EDF0)],
              stops: [0.30, 0.61],
              // transform: GradientRotation(2.05949),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 20.0),
                Text(
                  "Sign In",
                  style: TextStyle(
                      color: stmBlack,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w300
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset('assets/images/IoF.svg',)
                    ],
                  ),
                ),
                SizedBox(height: 35.0),
                LoginForm(isBottomSheet: true),
                SizedBox(height: 30.0),
                Center(child: registrationLink()),
                SizedBox(height: 30.0),
                Center(child: ForgotPassword())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
