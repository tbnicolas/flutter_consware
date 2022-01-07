import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  
  final Function() onTap;
  final double height;
  final EdgeInsetsGeometry margin;
  final String buttonText;
  const PrimaryButton({Key? key,  required this.onTap,  required this.height,  required this.margin, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: () {
        onTap();
      },
      child:  Container(
        alignment: Alignment.center,
        height: height,
        margin: margin,
        decoration:  BoxDecoration(
          color: const Color(0xff0ef4e4),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child:  Text(
          buttonText,
          style: const TextStyle(
            color: Color(0xff013f4c),
            fontSize: 17,
            fontWeight: FontWeight.w700
          ),
        ),
      ),
    );
  }
}