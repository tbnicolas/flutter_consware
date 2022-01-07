import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final IconData? icon;
  final String labelText;
  final Function(String value)? onChange;
  final Color color;
  final bool obscureText;
  final EdgeInsetsGeometry margin;
  final TextInputType? keyboardType;
  final int maxLines;
  final TextEditingController? controller;

  const Input({Key? key, 
     this.icon,
     required this.labelText,
     this.onChange,
     required this.color,
     required this.margin,
     this.obscureText = false,
     this.keyboardType,
     this.maxLines = 1,
     this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if ( controller != null ) {

      controller!.selection = TextSelection.fromPosition(TextPosition(offset: controller!.text.length));
    }
    return Container(
      margin: margin,
      child:  TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines,
        textInputAction: TextInputAction.done,
        controller: controller,
        style: const TextStyle(
          color: Colors.white
        ),
        onChanged: ( onChange != null ) 
        ? (String value) {
          onChange!(value);
        }
        : ( String value ) {},
        decoration:  InputDecoration(
          alignLabelWithHint: true,
          fillColor:  const Color(0xff392f4e),
          filled: true,
          labelText: labelText,
          labelStyle: const  TextStyle(
            color: Colors.white,
          ),
          isDense: true,
          
           enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide:  BorderSide(color: Color.fromRGBO(128, 128, 128, 0.4)),
          ),
          border: const  OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            borderSide:  BorderSide(color: Color.fromRGBO(128, 128, 128, 0.4)),
          ),
          prefixIcon:
           (icon != null )
            ?  Icon(
            icon,
            size: 12,
            color: Colors.white,
            )
            : null,
        ),
      )
    );
  }
}