import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  Loader({Key key}) : super(key: key);

  @override
  _LoaderState createState() => _LoaderState();
}

class _LoaderState extends State<Loader> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..reverse();

    Future.delayed(Duration(seconds: 0), () {
      _controller.repeat();
    });
    // Future.delayed(Duration(seconds: 5), () {
    //   // _controller.reset();
    // });
  }
  
  @override
  void dispose() { 
    _controller.reset();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCircularContainer(double radius, AnimationController _controller) {
    return AnimatedBuilder(
      animation: CurvedAnimation(parent: _controller, curve: Curves.fastLinearToSlowEaseIn),
      builder: (context, child) {
        return Container(
          width: ((_controller.value * radius) + 100) * 0.5,
          height: ((_controller.value * radius) + 100) * 0.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(300),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xb2a6b4c7).withOpacity(1 - _controller.value),
                blurRadius: 10,
                spreadRadius: 1,
                offset: Offset(5, 5),
              ),
              BoxShadow(
                color: Color(0xccffffff).withOpacity(1 - _controller.value),
                blurRadius: 10,
                spreadRadius: 2,
                offset: -Offset(5, 5),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              // colors: [Color(0xFFF3F3F3).withOpacity(1 - _controller.value), Color(0xFFE9EDF0).withOpacity(1 - _controller.value)],
              colors: [Color(0xFFFFFFFF).withOpacity(1 - _controller.value), Color(0xFFFFFFFF).withOpacity(1 - _controller.value)],
            ),
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mq = MediaQuery.of(context);
    Size size = mq.size;
    double width = size.width;
    return Container(
      child: Center(
        child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
           Align(
            child: Container(
              child: _buildCircularContainer(width - width * 0.1, _controller),
            ),
           ),
           Align(
            child: Container(
              child: _buildCircularContainer(width - width * 0.4, _controller),
            ),
           ),
           Align(
            child: Container(
              child: _buildCircularContainer(width - width * 0.7, _controller),
            ),
           ),
          Align(
            child: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                // border: Border.all(
                //   color: Colors.white,
                //   width: 1,
                // ),
                
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFA6B4C8).withOpacity(0.5),
                    offset: Offset(4.0, 4.0),
                    blurRadius: 10.0,
                    spreadRadius: 1.0
                  ),
                  BoxShadow(
                    color: const Color(0xFFFFFFFF).withOpacity(0.5),
                    offset: -Offset(4.0, 4.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0
                  ),
                ],
                // gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   colors: [Color(0xFFF3F3F3), Color(0xFFE9EDF0)],
                // ),
              ),
            )
          ),
        ],
      ),
      ),
    );
  }
}