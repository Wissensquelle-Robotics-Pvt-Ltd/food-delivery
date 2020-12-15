import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/OrderListBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelOrderList.dart';
import 'package:product/Screens/OrderSummary/OrderSummary.dart';
import 'package:product/generated/i18n.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OrderListCard extends StatelessWidget {
  final Orders order;
  OrderListCard(this.order);
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () async {
        SharedManager.shared.orderId = order.orderId;
        await Navigator.of(context, rootNavigator: true)
            .push(MaterialPageRoute(
                builder: (context) => OrderSummary(
                      orderId: order.orderId,
                      orderStatus: order.orderStatus,
                      review: order.review,
                    )))
            .then((value) {
          orderListBloc.fetchOrderList(
              SharedManager.shared.userID, '0', APIS.orderList);
        });
      },
      child: new Container(
          color: AppColor.white,
          padding: new EdgeInsets.all(10),
          height: 255,
          child: Material(
            color: AppColor.white,
            elevation: 3.0,
            borderRadius: new BorderRadius.circular(5),
            child: new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new Column(
                children: <Widget>[
                  Container(
                    height: 70,
                    child: new Column(
                      children: <Widget>[
                        new Expanded(
                          child: new Container(
                            // color: AppColor.yellow,
                            child: new Row(
                              children: <Widget>[
                                new Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(order.bannerImage),
                                        fit: BoxFit.cover),
                                    borderRadius: new BorderRadius.circular(5),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                new Expanded(
                                  child: new Container(
                                    // color: AppColor.purple,
                                    child: new Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        setCommonText(
                                            (order.name != null)
                                                ? order.name
                                                : S.current.no_name,
                                            AppColor.black,
                                            14.0,
                                            FontWeight.w500,
                                            1),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        setCommonText(
                                            (order.address != null)
                                                ? order.address
                                                : S.current.dummy_address,
                                            AppColor.grey,
                                            12.0,
                                            FontWeight.w400,
                                            2),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        new Divider(
                          color: AppColor.grey[400],
                        )
                      ],
                    ),
                  ),
                  new Expanded(
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      // color: AppColor.green,
                      padding: new EdgeInsets.all(5),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  setCommonText(
                                      S.current.order_on,
                                      AppColor.grey[800],
                                      13.0,
                                      FontWeight.w500,
                                      1),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  setCommonText(
                                      order.created,
                                      AppColor.grey[600],
                                      12.0,
                                      FontWeight.w400,
                                      1),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  setCommonText(
                                      S.current.order_ID,
                                      AppColor.grey[800],
                                      13.0,
                                      FontWeight.w500,
                                      1),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  setCommonText(
                                      "#${order.orderId}",
                                      AppColor.grey[500],
                                      12.0,
                                      FontWeight.w600,
                                      1),
                                ],
                              )
                            ],
                          ),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  setCommonText(
                                      S.current.total_amounts,
                                      AppColor.grey[800],
                                      13.0,
                                      FontWeight.w500,
                                      1),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  setCommonText(
                                      '${Currency.curr}${order.totalPrice}',
                                      AppColor.grey[600],
                                      12.0,
                                      FontWeight.w400,
                                      1),
                                ],
                              ),
                              new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  setCommonText(
                                      (order.review == "")
                                          ? '${S.current.rating}'
                                          : '${S.current.yourated}',
                                      AppColor.grey[800],
                                      13.0,
                                      FontWeight.w500,
                                      1),
                                  SmoothStarRating(
                                      allowHalfRating: true,
                                      onRated: (v) {
                                        print(v);
                                      },
                                      starCount: 5,
                                      rating: (order.review == "")
                                          ? 0.0
                                          : double.parse(order.review),
                                      size: 16.0,
                                      isReadOnly: true,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.star_half,
                                      color: Colors.orange,
                                      borderColor: Colors.orange,
                                      spacing: 0.0),
                                ],
                              )
                            ],
                          ),
                          Divider(
                            color: AppColor.grey[400],
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: new EdgeInsets.all(5),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _setUpOrderStatus(order.orderStatus),
                        setCommonText(S.current.order_summary, AppColor.red,
                            14.0, FontWeight.w400, 1),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  _setUpOrderStatus(String status) {
    switch (status) {
      case "1":
        return setCommonText(
            '${S.current.pending}', AppColor.black87, 14.0, FontWeight.w500, 1);
      case "2":
        return setCommonText(
            S.current.accept_order, AppColor.black87, 14.0, FontWeight.w500, 1);
      case "3":
        return setCommonText('${S.current.deliveredByRestaurant}', AppColor.red,
            16.0, FontWeight.w500, 1);
      case "4":
        return setCommonText(S.current.preparing_order, AppColor.orange, 14.0,
            FontWeight.w500, 1);
      case "5":
        return setCommonText(S.current.delivered_order, AppColor.themeColor,
            16.0, FontWeight.w500, 1);
      case "6":
        return setCommonText('${S.current.orderPickedUp}', AppColor.black, 14.0,
            FontWeight.w500, 1);
      case "9":
        return setCommonText(
            S.current.canceled_order, AppColor.red, 14.0, FontWeight.w500, 1);
      default:
        return setCommonText('', AppColor.themeColor, 14.0, FontWeight.w400, 1);
    }
  }
}
