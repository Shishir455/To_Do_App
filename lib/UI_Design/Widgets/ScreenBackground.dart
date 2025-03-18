import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/assets_path.dart';

class ScreenBackground extends StatelessWidget {
  final Widget setimage;
  const ScreenBackground({
    required this.setimage,

    super.key,
  });



  @override
  Widget build(BuildContext context) {


    return Stack(
      children: [
        SvgPicture.asset(Assets_path.backgroundSvg,height: double.maxFinite,width: double.maxFinite,fit: BoxFit.cover,),
     setimage
      ],


    );
  }
}