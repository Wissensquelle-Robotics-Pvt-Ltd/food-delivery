import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';

class RestaurantDetailsWidget extends StatelessWidget {
  final String resName;
  final String resAddress;
  RestaurantDetailsWidget(this.resName, this.resAddress);
  @override
  Widget build(BuildContext context) {
    return new Container(
      // height: 110,
      // color: AppColor.red,
      padding: new EdgeInsets.all(8),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          setCommonText(resName, AppColor.black, 14.0, FontWeight.w500, 1),
          SizedBox(
            height: 5,
          ),
          setCommonText(resAddress, AppColor.grey, 12.0, FontWeight.w400, 2),
          new Divider(
              // color: AppColor.grey[400],
              ),
        ],
      ),
    );
  }
}
