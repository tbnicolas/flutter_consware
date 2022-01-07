import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class  BottomText extends StatelessWidget {
  
  final String? greyText;
  final String? tapText;
  final EdgeInsetsGeometry? margin;
   final Function() onTap;

   const BottomText({Key? key, 
    this.greyText,
    this.tapText,
    this.margin,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: RichText(
        text: TextSpan(
          text: greyText,
          style: const TextStyle(
            color: Color(0xff4e485f)
          ),
          children: <TextSpan>[
            TextSpan(
              text: tapText,
              style: const TextStyle(
                color: Color(0xff0ef4e4),
              ),
              recognizer: TapGestureRecognizer()
              ..onTap = () {
                onTap();
              }
            )
          ]
        )
      ),
    );
  }
}