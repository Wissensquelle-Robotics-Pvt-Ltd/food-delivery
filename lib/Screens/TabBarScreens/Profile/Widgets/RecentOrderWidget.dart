import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelProfileData.dart';
import 'package:product/Screens/OrderSummary/OrderSummary.dart';
import 'package:product/generated/i18n.dart';

class RecentOrderWidgets extends StatelessWidget {
  final List<RecentOrders> order;
  RecentOrderWidgets(this.order);
  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.all(15),
        height: (100.0 * order.length) + 100,
        color: AppColor.white,
        child: new Column(
          children: <Widget>[
            new Container(
              child: new Row(
                children: <Widget>[
                  new Icon(
                    Icons.local_mall,
                    color: AppColor.themeColor,
                    size: 20,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  setCommonText(S.current.recent_orders, AppColor.themeColor,
                      15.0, FontWeight.w400, 1),
                ],
              ),
            ),
            // SizedBox(height: 10),
            new Expanded(
              child: new Stack(
                children: <Widget>[
                  new Center(
                    child: new Text(
                      S.current.no_order_found,
                      style: new TextStyle(
                          color: AppColor.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  new Container(
                    color: AppColor.white,
                    child: new ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: (order.length > 5) ? 5 : order.length,
                      itemBuilder: (context, index) {
                        return new Padding(
                          padding: new EdgeInsets.only(top: 8, bottom: 8),
                          child: new Material(
                            borderRadius: new BorderRadius.circular(0),
                            child: new InkWell(
                              onTap: () {
                                SharedManager.shared.orderId =
                                    order[index].orderId;
                                Navigator.of(context, rootNavigator: true)
                                    .push(MaterialPageRoute(
                                        builder: (context) => OrderSummary(
                                              orderId: order[index].orderId,
                                              orderStatus:
                                                  order[index].orderStatus,
                                              review:
                                                  (order[index].review != null)
                                                      ? order[index].review
                                                      : '',
                                            )));
                              },
                              child: new Container(
                                color: AppColor.white,
                                child: Column(
                                  children: <Widget>[
                                    new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            flex: 2,
                                            child: new Container(
                                              padding: new EdgeInsets.all(10),
                                              child: new Container(
                                                height: 55,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          order[index]
                                                              .bannerImage),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                              ),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 4,
                                          child: new Container(
                                            color: AppColor.white,
                                            child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                setCommonText(
                                                    (order[index].name != null)
                                                        ? order[index].name
                                                        : S.current.no_name,
                                                    AppColor.black,
                                                    14.0,
                                                    FontWeight.w500,
                                                    1),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                setCommonText(
                                                    (order[index].address !=
                                                            null)
                                                        ? order[index].address
                                                        : S.current
                                                            .dummy_address,
                                                    AppColor.grey,
                                                    12.0,
                                                    FontWeight.w400,
                                                    2),
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    setCommonText(
                                                        (order[index].review !=
                                                                null)
                                                            ? order[index]
                                                                .review
                                                            : '0.0',
                                                        AppColor.orange,
                                                        12.0,
                                                        FontWeight.w600,
                                                        1),
                                                    Icon(
                                                      Icons.star,
                                                      color: AppColor.orange,
                                                      size: 14,
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: new Container(
                                            color: AppColor.white,
                                            child: new Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                setCommonText(
                                                    '#${order[index].orderId}',
                                                    AppColor.grey,
                                                    14.0,
                                                    FontWeight.w500,
                                                    1),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                setCommonText(
                                                    '${Currency.curr}${order[index].totalPrice}',
                                                    AppColor.black,
                                                    12.0,
                                                    FontWeight.w400,
                                                    1),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                setCommonText(
                                                    '${order[index].created}',
                                                    AppColor.grey[600],
                                                    10.0,
                                                    FontWeight.w400,
                                                    2),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Divider()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
