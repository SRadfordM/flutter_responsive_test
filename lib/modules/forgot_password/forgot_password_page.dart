import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screen_util_test/modules/shared/server_error/server_error_arguments.dart';
import 'package:screen_util_test/modules/shared/widgets/iof_text_field.dart';
import 'package:screen_util_test/styling/colors.dart';
import 'package:screen_util_test/utils/routes.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController;
  String _emailError = '';
  String _emailErrorSemantics = '';

  @override
  void initState() {
    super.initState();
    _emailController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    Size size = mq.size;
    EdgeInsets padding = mq.padding;
    double safeVertical = size.height - (padding.top + padding.bottom);
    double safeHorizontal = size.width - (padding.left + padding.right);

    return GestureDetector(
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
                fontSize: 24.0,
              ),
            ),
            elevation: 0,
            title: Text("Forgot Password"),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
              ),
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
                  SizedBox(height: 55.0),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          'assets/images/phone_graphic.svg',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 36.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: safeHorizontal * 0.12),
                    child: Text(
                      "Enter email for your account",
                      style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.w400,
                          color: black60,
                          height: 1.8
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 46.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          IoFTextField(
                            textController: _emailController,
                            label: "User Name",
                            hint: "Enter email",
                            error: _emailError,
                            errorSemantic: _emailErrorSemantics,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 70.0),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: safeHorizontal * 0.15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          height: 68.0,
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
                                  await _requestPasswordReset();
                                }
                              },
                              child: Text(
                                "Send",
                                style: TextStyle(
                                  color: schucoGreen,
                                  fontSize: 26.0,
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
          ),
        ),
      ),
    );
  }

  bool _validateForm() {
    String trimmedEmail = _emailController.text.trim();
    if(trimmedEmail.isEmpty) {
      setState(() {
        _emailError = "Please enter an email address";
      });
      return false;
    } else {
      setState(() {
        _emailError = '';
      });
      return true;
    }

  }

  Future<void> _requestPasswordReset() async {
    int statusCode = 200;
    if(statusCode == 200 || statusCode == 201) {
      setState(() {
        _emailError = '';
        _emailErrorSemantics = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Password reset sent successfully.",
            ),
            duration: Duration(seconds: 5),
          )
      );
      Navigator.of(context).pop();
    } else if(statusCode == 404){
      setState(() {
        _emailError = "Email address not associated with an account";
      });
    } else {
      setState(() {
        _emailError = '';
      });
      var routeArguments = ServerErrorArguments(appInitialized: true);
      Navigator.pushNamed(context, IofRouter.serverError, arguments: routeArguments);
    }
  }
}
