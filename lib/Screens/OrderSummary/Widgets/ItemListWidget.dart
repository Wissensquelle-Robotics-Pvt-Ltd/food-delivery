import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelOrderDetails.dart';
import 'package:product/generated/i18n.dart';

class ItemListWidget extends StatelessWidget {
  final List<Products> itemList;
  final String totalPrice;
  final String tip;

  ItemListWidget(this.itemList, this.totalPrice, this.tip);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
            // height: 150,
            padding: new EdgeInsets.only(left: 15, right: 15),
            // color: AppColor.red,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        setCommonText(S.current.item_total, AppColor.black,
                            14.0, FontWeight.w500, 1),
                      ],
                    ),
                    new Row(
                      children: <Widget>[
                        new Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            setCommonText(
                                '${Currency.curr}${_calculateTotalPrice(itemList)}',
                                AppColor.grey,
                                14.0,
                                FontWeight.w500,
                                1),
                            new Container(
                                width: 40, height: 2, color: AppColor.grey),
                          ],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        setCommonText(
                            '${Currency.curr}${_calculateDiscountedPrice(itemList)}',
                            AppColor.black,
                            12.0,
                            FontWeight.w500,
                            1),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    setCommonText(S.current.charges, AppColor.black, 12.0,
                        FontWeight.w500, 1),
                    SizedBox(
                      width: 6,
                    ),
                    setCommonText('${Currency.curr}20', AppColor.red, 12.0,
                        FontWeight.w500, 1),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    setCommonText(S.current.tip, AppColor.black, 12.0,
                        FontWeight.w500, 1),
                    SizedBox(
                      width: 6,
                    ),
                    setCommonText('${Currency.curr}$tip', AppColor.themeColor,
                        12.0, FontWeight.w500, 1),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Divider(
                  color: AppColor.grey,
                ),
                SizedBox(
                  height: 15,
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    setCommonText(S.current.grand_total, AppColor.black, 14.0,
                        FontWeight.w500, 1),
                    SizedBox(
                      width: 6,
                    ),
                    setCommonText("${Currency.curr}$totalPrice", AppColor.black,
                        14.0, FontWeight.w500, 1),
                  ],
                ),
              ],
            )),
        new Divider(
          color: AppColor.grey,
        )
      ],
    );
  }

  double _calculateTotalPrice(List<Products> itemList) {
    var totalPrice = 0.0;
    for (var list in itemList) {
      totalPrice = totalPrice + (double.parse(list.price));
    }
    return totalPrice;
  }

  _calculateDiscountedPrice(List<Products> itemList) {
    var discountedPrice = 0.0;
    for (var list in itemList) {
      discountedPrice = discountedPrice +
          ((double.parse(list.price) - (double.parse(list.discount))));
    }
    return discountedPrice;
  }
}
