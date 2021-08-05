import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:screen_util_test/modules/auth/models/sign_in.dart';
import 'package:screen_util_test/modules/shared/server_error/server_error_arguments.dart';
import 'package:screen_util_test/modules/shared/widgets/iof_text_field.dart';
import 'package:screen_util_test/styling/colors.dart';
import 'package:screen_util_test/utils/routes.dart';


class LoginForm extends StatefulWidget {
  final bool isBottomSheet;

  LoginForm({@required this.isBottomSheet});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool hidePassword;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  String _emailError = '';
  String _emailErrorSemantic = '';
  final passwordController = TextEditingController();
  String _passwordError = '';
  String _passwordErrorSemantic = '';

  @override void initState() {
    super.initState();
    hidePassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            IoFTextField(
              textController: emailController,
              label: "User Name",
              hint: "Enter Email",
              error: _emailError,
              errorSemantic: _emailErrorSemantic,
            ),
            SizedBox(height: 25.0),
            IoFTextField(
              textController: passwordController,
              obscureText: hidePassword,
              label: "Password",
              hint: "Enter Password",
              error: _passwordError,
              errorSemantic: _passwordErrorSemantic,
              suffixIcon: IconButton(
                icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off, color: iconGrey,),
                color: iconGrey,
                highlightColor: iconGrey,
                focusColor: iconGrey,
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
              ),
            ),
            SizedBox(height: widget.isBottomSheet ? 40.0 : 70.0),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: schucoGreen,
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: stmShadowStart,
                          blurRadius: 20,
                          offset: Offset(10, 10),
                        ),
                        BoxShadow(
                          color: stmShadowEnd,
                          blurRadius: 20,
                          offset: Offset(-12, -12),
                        ),
                      ],
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [stmGradientStart, stmGradientEnd],
                      ),
                    ),
                    child: Center(
                      child: MaterialButton(
                        height: double.infinity,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0)
                        ),
                        onPressed: () async {
                          if (_validateForm()) {
                            await _signIn();
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            color: schucoGreen,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateForm() {
    String newEmailError = _validateEmail();
    String newPasswordError = _validatePassword();

    setState(() {
      _emailError = newEmailError;
      _passwordError = newPasswordError;
    });

    return newEmailError.isEmpty && newPasswordError.isEmpty;
  }

  String _validateEmail() {
    String trimmedEmail = emailController.text.isEmpty ? "" : emailController.text.trim();
    if (trimmedEmail.isEmpty) {
      return "Please enter a valid email";
    }else {
      return '';
    }
  }

  String _validatePassword() {
    String trimmedPassword = passwordController.text.isEmpty ? "" : passwordController.text.trim();
    if (trimmedPassword.isEmpty) {
      return "Please enter a password";
    } else if(trimmedPassword.length < 8) {
      return "Password must be at least 8 characters";
    } else {
      return '';
    }
  }
  
  Future<void> _signIn() async {
    SignInCredentials credentials = SignInCredentials(
        username: emailController.text.trim(),
        password: passwordController.text.trim(),
    );
    var json = jsonEncode(credentials.toJson());
    print("Signing in with credentials: ");
    print(json);

    int statusCode = 200;
    String apiEmailError = '';
    String apiEmailErrorSemantics = '';
    String apiPasswordError = '';
    String apiPasswordErrorSemantics = '';

    if(statusCode == 201 || statusCode == 200) {
        if (widget.isBottomSheet) {
          Navigator.pop(context);
        } else {
          Navigator.pushNamedAndRemoveUntil(context, iofLandingPage, (route) => false);
        }
    } else {
      var routeArguments = ServerErrorArguments(appInitialized: true);
      Navigator.pushNamed(context, IofRouter.serverError, arguments: routeArguments);
    }
    
    setState(() {
      _emailError = apiEmailError;
      _emailErrorSemantic = apiEmailErrorSemantics;
      _passwordError = apiPasswordError;
      _passwordErrorSemantic = apiPasswordErrorSemantics;
    });
  }


}