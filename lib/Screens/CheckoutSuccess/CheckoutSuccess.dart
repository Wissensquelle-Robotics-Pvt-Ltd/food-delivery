import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/SharedManaged.dart';

class CheckoutSuccess extends StatefulWidget {
  @override
  _CheckoutSuccessState createState() => _CheckoutSuccessState();
}

class _CheckoutSuccessState extends State<CheckoutSuccess> {
  @override
  void initState() {
    // TODO: implement initState

    SharedManager.shared.cartItems = [];
    SharedManager.shared.isFromTab = true;
    //Clear all coupon code, discount price and whole things here.
    SharedManager.shared.isCouponApplied = false;
    SharedManager.shared.discountType = "";
    SharedManager.shared.discount = "";
    SharedManager.shared.discountPice = "";
    SharedManager.shared.tempTotalPrice = 0.0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: setSuccessView(context),
      ),
    );
  }
}
