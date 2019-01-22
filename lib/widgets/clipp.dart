import 'package:flutter/material.dart';


class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    final Path path = new Path();
    path.lineTo(0.0, 200.0);
//    path.lineTo(size.width, 200.0);

//    var firstEndPoint = Offset(size.width * 0.5, 200.0 - 35.0);
//    var fisrControlPoint = Offset(size.width * 0.25, 200.0 - 50.0);
//    path.quadraticBezierTo(fisrControlPoint.dx, fisrControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);
//
//    var secondEndPoint = Offset(size.width, 200.0 - 80.0);
//    var secondControlPoint = Offset(size.width * 0.75, 200.0 - 10);
//    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy, secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 100.0);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }


}

/*
var firstEndPoint = Offset(size.width * 0.5, 200.0 - 35.0);
    var fisrControlPoint = Offset(size.width * 0.25, 200.0 - 50.0);
    path.quadraticBezierTo(fisrControlPoint.dx, fisrControlPoint.dy, firstEndPoint.dx, firstEndPoint.dy);

    var secondEndPoint = Offset(size.width, 200.0 - 80.0);
    var secondControlPoint = Offset(size.width * 0.75, 200.0 - 10);
 */