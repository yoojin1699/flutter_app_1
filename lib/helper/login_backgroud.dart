import 'package:flutter/material.dart';
// 이거 필요 없는 듯...지워도 될거 같음. 
class LoginBackground extends CustomPainter {
  LoginBackground({@required this.isJoin});

  final bool isJoin;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = isJoin ? Colors.red : Colors.green;
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.2), size.height * 0.5, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
