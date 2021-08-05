import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/svg.dart';
import 'package:screen_util_test/styling/colors.dart';
import 'package:screen_util_test/utils/decoration/decorations.dart';
import 'package:screen_util_test/utils/routes.dart';


final outerShadow = BoxDecoration(
  shape: BoxShape.circle,
  boxShadow: [
    BoxShadow(
      color: const Color(0xFFA6B4C8),
      offset: Offset(4, 4),
      blurRadius: 10.0,
      spreadRadius: 1.0,
    ),
    BoxShadow(
      color: const Color(0xFFFFFFFF),
      offset: Offset(-4, -4),
      blurRadius: 5.0,
      spreadRadius: 1.0,
    ),
  ],
  gradient: LinearGradient(
    colors: [
      Colors.blueGrey[50],
      Colors.blueGrey[50],
      Colors.blueGrey[50],
      Colors.blueGrey[50]
    ]
  )
);

final innershadow = ConcaveDecoration(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(200.0)),
  ),
  colors: [
    Color(0xFFFFFFFF),
    Color(0xFFA6B4C8),
  ],
  depth: 4,
);
  
Widget svgNFCIcon() {
  return Container(
    child: SvgPicture.asset(
      'assets/images/iof_nfc_green.svg', height: 100, width: 100,
    ),
  );
}

class ScannerSelectionPage extends StatefulWidget {
  @override
  _ScannerSelectionPageState createState() => _ScannerSelectionPageState();
}

class _ScannerSelectionPageState extends State<ScannerSelectionPage> with WidgetsBindingObserver {
  bool nfcButtonPressed = false;
  bool qrButtonPressed = false;
  bool checkPermissionOnResume = false;
  bool floatingButtonPressed = false;
  final _scannerSelectionScaffoldKey = new GlobalKey<ScaffoldState>();

  String manualRoute;
  String manualRouteSemantics;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    nfcButtonPressed = false;
    qrButtonPressed = false;


  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  // void _showLoginForm() {
  //   MediaQueryData mq = MediaQuery.of(context);
  //   Size size = mq.size;
  //   EdgeInsets padding = mq.padding;
  //   double safeVertical = size.height - (padding.top + padding.bottom);
  //   Future<void> openBottomSheet = showModalBottomSheet<void>(
  //       context: context,
  //       isScrollControlled: true,
  //       builder: (BuildContext context) {
  //         return Container(
  //           height: safeVertical * 0.9,
  //           child: LoginBottomSheet(parentContext: context)
  //         );
  //       }
  //   );
  //   openBottomSheet.then(() => {});
  // }

  void onTapQRButton() async {
    // this._showLoginForm();
  }

  void onTapUpButton(TapUpDetails details) {
    setState(() {
      qrButtonPressed = false;      
    });
  }

  void onTapCancelButton() {
    setState(() {
      qrButtonPressed = false;
    });
  }

  void onTapDownQRButton(TapDownDetails details) {
    setState(() {
      qrButtonPressed = true;      
    });
  }

  void onTapUpNfcButton(TapUpDetails details) {
    setState(() {
      nfcButtonPressed = false;
    });
  }

  void onTapCancelNfcButton() {
    setState(() {
      nfcButtonPressed = false;
    });
  }

  void onTapDownNfcButton(TapDownDetails details) {
    setState(() {
      nfcButtonPressed = true;
    });
  }
      
  Widget svgLinkIcon() {
      return Container(
        height: 30,
        width: 30,
        child: SvgPicture.asset(
          'assets/images/iof_link.svg', height: 30, width: 30,
        ),
      );
    }

  Widget svgMenuIcon() {
    return Container(
      padding: EdgeInsets.only(left: 30),
      child: SvgPicture.asset(
        'assets/images/iof_menu.svg',
      ),
    );
  }

  Widget nfcButton() {
    return Semantics(
      child: Container(
          child: new GestureDetector(
            onTapUp: onTapUpNfcButton,
            onTapCancel: onTapCancelNfcButton,
            onTapDown: onTapDownNfcButton,
            onTap: () {
              _showNfcScanner();
            },
            child: nfcButtonPressed ? NFCButtonTapped() : NFCButtonRounded(),
          )
      ),
    );
  }

  Widget qrButton() {
    return Semantics(
      child: Container(
          child: new GestureDetector(
            onTapUp: onTapUpButton,
            onTapCancel: onTapCancelButton,
            onTapDown: onTapDownQRButton,
            onTap: () async {
              onTapQRButton();
            },
            child: qrButtonPressed ? ButtonTapped(imagePath: "assets/images/iof_outline_qr_tracking_green.svg") :
              ButtonRounded(imagePath: "assets/images/iof_outline_qr_tracking_green.svg"),
          )
      ),
    );
  }

  Widget tapToScanText() {
    return Container(
      margin: EdgeInsets.all(40),
      child: Text(
          "Tap to scan",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: const Color(0xFF656C79))
      ),
    );
  }
  
  Widget titleText() {
    return Text(
      "IoF",
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500,
        color: Color(0xFF647EA5)
      ),
    );
  }
  
  Widget leadingIcon() {
      return GestureDetector(
        onTap: () async {
          await Navigator.pushNamed(context, IofRouter.settingsMenu);
        },
        child: svgMenuIcon(),
      );
  }

  Widget floatingIcon() {
    return Container(
      margin: EdgeInsets.only(bottom: 80),
      child: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(),
          depth: -3,
          border: NeumorphicBorder(
            width: 6.0,
            color: Colors.white
          )
        ),
        child: FloatingActionButton(
            onPressed: () {
              setState(() {
                floatingButtonPressed = true;
              });

              _showWelcomeToIoFDialog(context);
            },
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.all(Radius.circular(50.0)),
                side: BorderSide(color: Colors.white)
            ),
            child: Text(floatingButtonPressed ? "X" : "!",
              style: TextStyle(
                color: schucoGreen,
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
        ),
      ),
    );
  }

  void _showWelcomeToIoFDialog(BuildContext context) {
    Widget dontShowButton = TextButton(
      child: Text(
        "Do not show again",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18
        ),
      ),
      onPressed: () async {
        setState(() {
          floatingButtonPressed = false;
        });
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      backgroundColor: stmGradientEnd,
      title: Text(
        "Welcome",
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 24
        ),
      ),
      content: Text(
        "This is the iof app",
        style: TextStyle(
          fontSize: 18,
          height: 1.5
        ),
      ),
      actions: [
        dontShowButton
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
        barrierDismissible: true
    ).then((value) => setState(() {
        floatingButtonPressed = false;
      })
    );
  }

  void _showNfcScanner() {

  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    Size size = mq.size;
    EdgeInsets padding = mq.padding;
    double safeVertical = size.height - (padding.top + padding.bottom);
    return Container(
      height: safeVertical,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFF3F3F3), Color(0xFFE9EDF0)],
          stops: [0.30, 0.61],
        ),
      ),
      child: Scaffold(
        key: _scannerSelectionScaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: leadingIcon(),
          centerTitle: true,
          title: titleText(),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                child: CustomPaint(
                  painter: BorderLinePainter(),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        nfcButton(),
                        tapToScanText(),
                        qrButton(),
                        Container(height: 150,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

}

// ignore: must_be_immutable
class ButtonTapped extends StatefulWidget {
  String imagePath;

  ButtonTapped({
    Key key,
    @required this.imagePath,
  }) : super(key: key);

  @override
  _ButtonTappedState createState() => _ButtonTappedState();
}

class _ButtonTappedState extends State<ButtonTapped> {
      
  Widget svgIcon() {
    return Container(
      child: SvgPicture.asset(
          widget.imagePath, height: 40, width: 40,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final innershadow = ConcaveDecoration(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(200.0)),
      ),
      colors: [
        Color(0xFFFFFFFF),
        Color(0xFFA6B4C8),
      ],
      depth: 2,
    );
    return Container(
       child: Container(
        height: 100,
        width: 100,
        decoration: innershadow,
        child: Center(child: svgIcon(),),
      ),
    );
  }
}

// ignore: must_be_immutable
class ButtonRounded extends StatefulWidget {
  String imagePath;

  ButtonRounded({
    Key key,
    @required this.imagePath,
  }) : super(key: key);

  @override
  _ButtonRoundedState createState() => _ButtonRoundedState();
}

class _ButtonRoundedState extends State<ButtonRounded> {      
  
  Widget svgIcon() {
    return Container(
      child: SvgPicture.asset(
        widget.imagePath, height: 40, width: 40,
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFA6B4C8),
              offset: Offset(4.0, 4.0),
              blurRadius: 10.0,
              spreadRadius: 1.0
            ),
            BoxShadow(
              color: const Color(0xFFFFFFFF),
              offset: -Offset(4.0, 4.0),
              blurRadius: 5.0,
              spreadRadius: 1.0
            ),
          ],
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey[50],
              Colors.blueGrey[50],
              Colors.blueGrey[50],
              Colors.blueGrey[50]
            ]
          ),
        ),
        child: Center(child: svgIcon(),),
      ),
    );
  }
}

class BorderLinePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Color.fromRGBO(217,229,240,0.48)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    Path path = Path();
    path.moveTo(0,size.height*0.20);

    path.lineTo(size.width*0.10,size.height*0.20);
    path.quadraticBezierTo(size.width*0.125,size.height*0.20, size.width*0.125, size.height*0.225);
    path.quadraticBezierTo(size.width*0.125,size.height*0.35, size.width*0.30, size.height*0.425);

    path.quadraticBezierTo(size.width*0.325,size.height*0.435, size.width*0.325, size.height*0.45);
    path.lineTo(size.width*0.325,size.height*0.675);

    path.arcToPoint(Offset(size.width*0.675,size.height*0.675), radius: Radius.circular(10.0), clockwise: false);

    path.lineTo(size.width*0.675,size.height*0.45);
    path.quadraticBezierTo(size.width*0.675,size.height*0.435, size.width*0.70, size.height*0.425);


    path.quadraticBezierTo(size.width*0.85,size.height*0.375, size.width*0.875, size.height*0.225);
    path.quadraticBezierTo(size.width*0.875,size.height*0.20, size.width*0.90, size.height*0.20);
    path.lineTo(size.width,size.height*0.20);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(BorderLinePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(BorderLinePainter oldDelegate) => false;
}


class NFCButtonRounded extends StatefulWidget {
  NFCButtonRounded({Key key}) : super(key: key);

  @override
  _NFCButtonRoundedState createState() => _NFCButtonRoundedState();
}

class _NFCButtonRoundedState extends State<NFCButtonRounded> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 250,
      decoration: outerShadow,
      child: Padding(
        padding: EdgeInsets.all(35.0),
        child: Container(
          decoration: outerShadow,
          child: Center(
            child: svgNFCIcon(),
          ),
        ),
      ),
    );
  }
}

class NFCButtonTapped extends StatefulWidget {
  NFCButtonTapped({Key key}) : super(key: key);

  @override
  _NFCButtonTappedState createState() => _NFCButtonTappedState();
}

class _NFCButtonTappedState extends State<NFCButtonTapped> {

  @override
  Widget build(BuildContext context) {
    return Semantics(
      child: Container(
        height: 250,
        width: 250,
        decoration: outerShadow,
        child: Padding(
          padding: EdgeInsets.all(35),
          child: Container(
            decoration: innershadow,
            child: Center(
              child: svgNFCIcon(),
            ),
          ),
        ),
      ),
    );
  }
}

