import 'package:flutter/material.dart';

class BannerSecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('Assets/Banner/banner2.png'))),
    );
  }
}
