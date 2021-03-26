import 'package:flutter/material.dart';
import 'package:flutter_login/views/common/FadeAnimation.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        stops: [
          0.1,
          0.8,
        ],
        colors: [
          Color.fromRGBO(196, 135, 198, 1),
          Color.fromRGBO(162, 56, 254, 1),
        ],
      )),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          FadeAnimation(
              1.5,
              CustomPaint(
                  size: MediaQuery.of(context).size, painter: CurvePainter())),
          Positioned(
            top: 0,
            left: 0,
            child: FadeAnimation(
                1.9,
                Image.asset(
                  'assets/images/main_top.png',
                  width: size.width * 0.3,
                )),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_bottom.png',
              width: size.width * 0.2,
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [
          0.1,
          0.8,
        ],
        colors: [
          Color.fromRGBO(255, 255, 255, 1),
          Color.fromRGBO(254, 206, 244, 1),
        ],
      ).createShader(rect)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height * 0.5067)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.425,
          size.width * 0.65, size.height * 0.5567)
      ..quadraticBezierTo(size.width * 0.78, size.height * 0.6,
          size.width * 1.0, size.height * 0.5367)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
