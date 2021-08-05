import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:screen_util_test/modules/shared/server_error/server_error_arguments.dart';
import 'package:screen_util_test/styling/colors.dart';
import 'package:screen_util_test/utils/routes.dart';


class ServerErrorPage extends StatefulWidget {
  @override
  _ServerErrorPageState createState() => _ServerErrorPageState();
}

class _ServerErrorPageState extends State<ServerErrorPage> {
  bool navigatingViaPhoneBack = true;
  ServerErrorArguments arguments;

  @override
  void dispose() {
    if(arguments == null) {
      print(ModalRoute.of(context).settings.arguments as ServerErrorArguments == null ? 'args are null' : 'got some args');
      var routeArgs = ModalRoute.of(context).settings.arguments as ServerErrorArguments;
      arguments = routeArgs == null ? new ServerErrorArguments(appInitialized: false) : routeArgs;
      print(arguments == null ? 'args is null' : '${arguments.routeToPush} -- ${arguments.appInitialized}');
    }

    print("in dispose: init'd? ${arguments?.appInitialized} - route? ${arguments.routeToPush}");
    if(navigatingViaPhoneBack == true && arguments?.appInitialized == true && arguments?.routeToPush?.isNotEmpty == true) {
      Navigator.pushNamed(context, arguments.routeToPush);
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(arguments == null) {
      setState(() {
        print(ModalRoute.of(context).settings.arguments as ServerErrorArguments == null ? 'args are null' : 'got some args');
        var routeArgs = ModalRoute.of(context).settings.arguments as ServerErrorArguments;
        arguments = routeArgs == null ? new ServerErrorArguments(appInitialized: false) : routeArgs;
        print(arguments == null ? 'args is null' : '${arguments.routeToPush} -- ${arguments.appInitialized}');
      });
    }


    MediaQueryData mq = MediaQuery.of(context);
    Size size = mq.size;
    EdgeInsets padding = mq.padding;
    double safeVertical = size.height - (padding.top + padding.bottom);
    double safeHorizontal = size.width - (padding.left + padding.right);

    return WillPopScope(
      onWillPop: () async {
        if(arguments == null) {
          print(ModalRoute.of(context).settings.arguments as ServerErrorArguments == null ? 'args are null' : 'got some args');
          var routeArgs = ModalRoute.of(context).settings.arguments as ServerErrorArguments;
          arguments = routeArgs == null ? new ServerErrorArguments(appInitialized: false) : routeArgs;
          print(arguments == null ? 'args is null' : '${arguments.routeToPush} -- ${arguments.appInitialized}');
        }

        print("in will pop: init'd? ${arguments?.appInitialized} - route? ${arguments.routeToPush}");
        if(navigatingViaPhoneBack == true && arguments?.appInitialized == false) {
          Navigator.pushNamed(context, iofLandingPage);
        }

        return true;
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
                        SvgPicture.asset(
                          'assets/images/manual_success_graphic.svg',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 90.0),
                  Text(
                    "Server Error",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      color: stmBlack,
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: safeHorizontal * 0.10),
                    child: Text(
                      "Some error occurred",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          color: black60,
                          height: 1.8
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 80.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: safeHorizontal * .12),
                    child: Column(
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
                                setState(() {
                                  navigatingViaPhoneBack = false;
                                });
                                if(arguments.appInitialized == false) {
                                  Navigator.pushReplacementNamed(context, iofLandingPage);
                                } else if(arguments.routeToPush.isEmpty) {
                                  Navigator.of(context).pop();
                                } else {
                                  Navigator.pushReplacementNamed(context, arguments.routeToPush);
                                }
                              },
                              child: Text(
                                "Try Again",
                                style: TextStyle(
                                  color: schucoGreen,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 50.0),
                        Container(
                          height: 80.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
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
                                setState(() {
                                  navigatingViaPhoneBack = false;
                                });
                                Navigator.pushNamedAndRemoveUntil(context, iofLandingPage, (route) => false);
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(
                                  color: black60,
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.w400,
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
}
