import 'package:flutter/material.dart';

class TextScreen extends StatelessWidget {
  
  final double height;
  final double width;
  final EdgeInsetsGeometry margin;
  final String h1Text;
  final String h2Text;

  const TextScreen({Key? key, 
    this.height = 90,
    required this.width,
    required this.margin,
    required this.h1Text,
    required this.h2Text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: height,
        width: width,
        margin: margin,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [ 
          Text(
            h1Text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w700
            ),
          ),
          Text(
            h2Text,
            style: const TextStyle(
              color: Colors.grey
            ),
          )
        ],
        ),
    );
  }
}