import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopImage extends StatelessWidget {
  
  final double height;
  final EdgeInsetsGeometry margin;
  final String path;
  final BoxFit fit;
  final bool isSvg;
  const TopImage({Key? key, 
    this.height=200,
    required this.margin,
    required this.path,
    this.isSvg = true,
    this.fit = BoxFit.contain
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      child: ( isSvg )
      ? SvgPicture.asset(path,fit: fit,)
      : Image.asset(path)
    );
  }
}