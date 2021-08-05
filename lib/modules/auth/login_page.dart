import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screen_util_test/styling/colors.dart';

import 'forgot_password.dart';
import 'login_form.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override void initState() {
    super.initState();
  }

  Widget registrationLink() {
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: Text(
          "Click here to sign up.",
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

    return WillPopScope(
      onWillPop: () async {
        print("Login will pop scope");
        return true;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: safeVertical,
          width: size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFF3F3F3), Color(0xFFE9EDF0)],
              stops: [0.30, 0.61],
              // transform: GradientRotation(2.05949),
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: IconThemeData(
                color: stmBlack,
              ),
              textTheme: TextTheme(
                headline6: TextStyle(
                  color: stmBlack,
                  fontSize: 20.0,
                ),
              ),
              elevation: 0,
              title: Text("Sign In"),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(height: 45.0),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SvgPicture.asset('assets/images/IoF.svg',)
                        ],
                      ),
                    ),
                    SizedBox(height: 45.0),
                    LoginForm(isBottomSheet: false),
                    SizedBox(height: 50.0),
                    Center(child: registrationLink()),
                    SizedBox(height: 30.0),
                    Center(child: ForgotPassword())
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
