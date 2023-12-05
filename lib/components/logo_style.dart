import 'package:flutter/material.dart';

class LogoStyle extends StatelessWidget {
  final String logopath;
  const LogoStyle({Key? key,required this.logopath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(logopath,height: 130,width: 130,),
    );
  }
}
