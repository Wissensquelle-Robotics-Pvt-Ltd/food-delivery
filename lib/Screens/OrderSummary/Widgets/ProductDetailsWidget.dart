import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelOrderDetails.dart';
import 'package:product/generated/i18n.dart';

class OrderDetailsWidget extends StatelessWidget {
  final List<Products> itemList;
  OrderDetailsWidget(this.itemList);
  @override
  Widget build(BuildContext context) {
    return new Container(
      // color: AppColor.red,
      // height: (itemList.length * 95.0) + 20,
      padding: new EdgeInsets.only(left: 10, right: 10),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            // height: 45,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText(S.current.your_orders, AppColor.themeColor, 14.0,
                    FontWeight.w500, 1),
                Divider(
                  color: AppColor.grey[400],
                ),
              ],
            ),
          ),
          new Container(
            height: (itemList.length * 80.0),
            // color: AppColor.purple,
            child: new ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return new Container(
                  // height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          new Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: itemList[index].type == "1"
                                        ? AssetImage(
                                            'Assets/RestaurantDetails/veg.png')
                                        : AssetImage(
                                            'Assets/RestaurantDetails/nonVeg.png'))),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          setCommonText(itemList[index].productName,
                              AppColor.black, 13.0, FontWeight.w500, 2),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      setCommonText(itemList[index].description,
                          AppColor.grey[500], 12.0, FontWeight.w400, 2),
                      SizedBox(
                        height: 5,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              setCommonText(itemList[index].productQuantity,
                                  AppColor.black, 12.0, FontWeight.w500, 1),
                              SizedBox(
                                width: 3,
                              ),
                              setCommonText('x', AppColor.black, 13.0,
                                  FontWeight.w500, 1),
                              SizedBox(
                                width: 3,
                              ),
                              setCommonText(
                                  '${Currency.curr}${(double.parse(itemList[index].price) - (double.parse(itemList[index].discount)))}',
                                  AppColor.black,
                                  12.0,
                                  FontWeight.w500,
                                  1),
                            ],
                          ),
                          setCommonText(
                              '${Currency.curr}${(double.parse(itemList[index].productQuantity) * (double.parse(itemList[index].price) - (double.parse(itemList[index].discount))))}',
                              AppColor.black,
                              12.0,
                              FontWeight.w500,
                              1),
                        ],
                      ),
                      Divider(
                        color: AppColor.grey,
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
