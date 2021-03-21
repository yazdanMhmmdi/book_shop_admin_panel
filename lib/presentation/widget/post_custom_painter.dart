import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostCustomPainter extends CustomPainter{
  
  @override
  void paint(Canvas canvas, Size size) {
    
    

  Paint paint_0 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
     
         
    Path path_0 = Path();
    path_0.moveTo(0,size.height);
    path_0.quadraticBezierTo(size.width*0.0632000,size.height*1.0105455,size.width*0.0666667,size.height*0.9090909);
    path_0.quadraticBezierTo(size.width*0.0666667,size.height*0.7045455,size.width*0.0666667,size.height*0.0909091);
    path_0.quadraticBezierTo(size.width*0.0678667,size.height*-0.0006364,size.width*0.1333333,0);
    path_0.cubicTo(size.width*0.3166667,0,size.width*0.6833333,0,size.width*0.8666667,0);
    path_0.quadraticBezierTo(size.width*0.9282667,size.height*0.0015455,size.width*0.9333333,size.height*0.0909091);
    path_0.quadraticBezierTo(size.width*0.9333333,size.height*0.7045455,size.width*0.9333333,size.height*0.9090909);
    path_0.quadraticBezierTo(size.width*0.9326000,size.height*1.0032727,size.width,size.height);
    path_0.lineTo(0,size.height);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}
