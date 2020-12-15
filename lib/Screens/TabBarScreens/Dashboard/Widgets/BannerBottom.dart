import 'package:flutter/material.dart';

class BannerBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('Assets/Banner/banner3.jpg'))),
    );
  }
}
