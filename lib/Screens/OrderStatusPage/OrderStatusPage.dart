import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/OrderStatusBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelOrderStatus.dart';
import 'package:product/Screens/OrderTrackingPage/OrderTrackingPage.dart';
import 'package:product/Screens/SubmitReviewScreen/SubmitReviewScreen.dart';
import 'package:product/generated/i18n.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class OrderStatusPage extends StatefulWidget {
  getOrderStatus() => createState().getOrderStatus();

  final String orderStatus;
  final String resName;
  final String resAddress;
  final String resImage;
  final String orderId;
  final String resID;
  final String driverId;
  final String isReview;
  final String review;
  final String latitude;
  final String longitude;

  OrderStatusPage(
      {this.orderStatus,
      this.resName,
      this.resAddress,
      this.resImage,
      this.resID,
      this.orderId,
      this.driverId,
      this.isReview,
      this.review,
      this.latitude,
      this.longitude});

  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  var orderStatus = "";

  @override
  void initState() {
    super.initState();
    orderStatusBloc.fetchOrderStatus(SharedManager.shared.orderId);
  }

  //This is callback function
  getOrderStatus() =>
      orderStatusBloc.fetchOrderStatus(SharedManager.shared.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: setCommonText('${S.current.trackOrder}', AppColor.themeColor,
            20.0, FontWeight.w600, 1),
        backgroundColor: AppColor.white,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.themeColor,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: false,
        actions: <Widget>[
          FlatButton(
              onPressed: () {},
              child: setCommonText('${S.current.driverDetails}', AppColor.white,
                  16.0, FontWeight.w500, 1))
        ],
      ),
      body: StreamBuilder(
          stream: orderStatusBloc.orderStatus,
          builder: (context, AsyncSnapshot<ResOrderStatus> snapshot) {
            if (snapshot.hasData) {
              this.orderStatus = snapshot.data.result.orderStatus;
              SharedManager.shared.driverImage =
                  snapshot.data.result.driverDetails.image;
              SharedManager.shared.driverName =
                  snapshot.data.result.driverDetails.name;
              SharedManager.shared.driverPhone =
                  snapshot.data.result.driverDetails.phone;
              SharedManager.shared.driverReview =
                  snapshot.data.result.driverDetails.review;
              return Container(
                  padding: EdgeInsets.all(15),
                  color: AppColor.white,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Material(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColor.white,
                        elevation: 3.5,
                        shadowColor: AppColor.black,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    setCommonText(
                                        '#${this.widget.orderId}',
                                        AppColor.black54,
                                        14.0,
                                        FontWeight.bold,
                                        1),
                                    InkWell(
                                      onTap: () {
                                        (this.orderStatus == '5')
                                            ? SharedManager.shared.showAlertDialog(
                                                "${S.current.orderDeliveredTrackingNotWorking}",
                                                context)
                                            : (this.orderStatus == '6')
                                                ? Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrderTrackingPage(
                                                              latitude: this
                                                                  .widget
                                                                  .latitude,
                                                              longitude: this
                                                                  .widget
                                                                  .longitude,
                                                              driverId: this
                                                                  .widget
                                                                  .driverId,
                                                            ),
                                                        fullscreenDialog: true))
                                                : SharedManager.shared
                                                    .showAlertDialog(
                                                        "${S.current.driverDoesNotPickedUpOrder}",
                                                        context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          setCommonText(
                                              '${S.current.trackDriver}',
                                              (this.orderStatus == '6')
                                                  ? AppColor.red
                                                  : AppColor.grey[500],
                                              14.0,
                                              FontWeight.bold,
                                              1),
                                          Icon(
                                            Icons.place,
                                            color: (this.orderStatus == '6')
                                                ? AppColor.red
                                                : AppColor.grey[500],
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 5),
                              Divider(
                                color: AppColor.black38,
                              ),
                              Container(
                                height: 130,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 7,
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    setCommonText(
                                                        '${this.widget.resName}',
                                                        AppColor.black54,
                                                        14.0,
                                                        FontWeight.w800,
                                                        1),
                                                    setCommonText(
                                                        '${this.widget.resAddress}',
                                                        AppColor.black87,
                                                        12.0,
                                                        FontWeight.w400,
                                                        3),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                  child: Center(
                                                child: Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              this
                                                                  .widget
                                                                  .resImage))),
                                                ),
                                              )),
                                              flex: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                        child: (this.widget.isReview != '0')
                                            ? Container(
                                                child: Column(
                                                  children: <Widget>[
                                                    setCommonText(
                                                        '${S.current.youReviwed}',
                                                        AppColor.black87,
                                                        15.0,
                                                        FontWeight.w600,
                                                        1),
                                                    SmoothStarRating(
                                                        allowHalfRating: true,
                                                        onRated: (v) {
                                                          print(v);
                                                        },
                                                        starCount: 5,
                                                        rating: double.parse(
                                                            this.widget.review),
                                                        size: 20.0,
                                                        isReadOnly: true,
                                                        filledIconData:
                                                            Icons.star,
                                                        halfFilledIconData:
                                                            Icons.star_half,
                                                        color: Colors.orange,
                                                        borderColor:
                                                            Colors.orange,
                                                        spacing: 0.0),
                                                  ],
                                                ),
                                              )
                                            : Container(
                                                child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  InkWell(
                                                    onTap: () {
                                                      (this.orderStatus == '5')
                                                          ? Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          SubmitReviewScreen(
                                                                            resAddress:
                                                                                this.widget.resAddress,
                                                                            resImage:
                                                                                this.widget.resImage,
                                                                            resName:
                                                                                this.widget.resName,
                                                                            resId:
                                                                                this.widget.resID,
                                                                            driverId:
                                                                                this.widget.driverId,
                                                                            orderID:
                                                                                this.widget.orderId,
                                                                          ),
                                                                  fullscreenDialog:
                                                                      true))
                                                          : SharedManager.shared
                                                              .showAlertDialog(
                                                                  '${S.current.notAbleToReview}',
                                                                  context);
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 120,
                                                      color: (this.orderStatus ==
                                                              '5')
                                                          ? AppColor.themeColor
                                                          : AppColor.grey[400],
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          setCommonText(
                                                              '${S.current.addReview}',
                                                              AppColor.white,
                                                              14.0,
                                                              FontWeight.w500,
                                                              1),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  this.orderStatus != '5'
                                                      ? Column(
                                                          children: [
                                                            setCommonText(
                                                                '${S.current.avgDelivery}',
                                                                AppColor
                                                                    .black54,
                                                                12.0,
                                                                FontWeight.w500,
                                                                1),
                                                            setCommonText(
                                                                '25 minutes',
                                                                AppColor
                                                                    .black87,
                                                                13.0,
                                                                FontWeight.w500,
                                                                1)
                                                          ],
                                                        )
                                                      : Text('')
                                                ],
                                              ))),
                                  ],
                                ),
                              ),
                              Divider(
                                color: AppColor.black38,
                              ),
                              Expanded(
                                  flex: 10,
                                  child: Container(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            setCommonText(
                                                '${S.current.trackOrder}',
                                                AppColor.black87,
                                                14.0,
                                                FontWeight.w500,
                                                1),
                                            Icon(
                                              Icons.keyboard_arrow_up,
                                              color: AppColor.orange,
                                            )
                                          ],
                                        ),
                                        Expanded(
                                            child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    // color: AppColor.amber,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              // color: Colors.white,
                                                              child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Container()),
                                                                  Expanded(
                                                                      flex: 2,
                                                                      child: Container(
                                                                          child: _setCustomTrackOrderBubbleView(
                                                                              '1',
                                                                              this.orderStatus))),
                                                                  Expanded(
                                                                      flex: 2,
                                                                      child: Container(
                                                                          child: _setCustomTrackOrderBubbleView(
                                                                              '2',
                                                                              this.orderStatus))),
                                                                  Expanded(
                                                                      flex: 2,
                                                                      child: Container(
                                                                          child: _setCustomTrackOrderBubbleView(
                                                                              '4',
                                                                              this.orderStatus))),
                                                                  Expanded(
                                                                      flex: 2,
                                                                      child: Container(
                                                                          child: _setCustomTrackOrderBubbleView(
                                                                              '6',
                                                                              this.orderStatus))),
                                                                  Expanded(
                                                                      flex: 1,
                                                                      child: Container(
                                                                          child: Column(
                                                                        children: <
                                                                            Widget>[
                                                                          Container(
                                                                              height: 16,
                                                                              width: 16,
                                                                              decoration: BoxDecoration(color: (this.orderStatus == '5') ? AppColor.orange : AppColor.grey[300], borderRadius: BorderRadius.circular(8))),
                                                                        ],
                                                                      ))),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  )
                                                                ],
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 5,
                                                  child: Container(
                                                    child: Column(
                                                      children: <Widget>[
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                child: _setOrderTrackDetailsView(
                                                                    '${S.current.order_Placed}',
                                                                    '${S.current.receivedNewOrder}',
                                                                    Icons
                                                                        .event_note,
                                                                    '1',
                                                                    this
                                                                        .widget
                                                                        .orderStatus))),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                child: _setOrderTrackDetailsView(
                                                                    '${S.current.orderConfirm}',
                                                                    '${S.current.restaurantConfirmOrder}',
                                                                    Icons
                                                                        .room_service,
                                                                    '2',
                                                                    this.orderStatus))),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                child: _setOrderTrackDetailsView(
                                                                    '${S.current.orderPreparing}',
                                                                    '${S.current.restaurantPreparing}',
                                                                    Icons
                                                                        .person,
                                                                    '4',
                                                                    this.orderStatus))),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                child: _setOrderTrackDetailsView(
                                                                    '${S.current.pickedUpDriver}',
                                                                    '${S.current.readyToPickedup}',
                                                                    Icons
                                                                        .local_shipping,
                                                                    '6',
                                                                    this.orderStatus))),
                                                        Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                child: _setOrderTrackDetailsView(
                                                                    '${S.current.orderDelivered}',
                                                                    '${S.current.orderhasbeenDelivered}',
                                                                    Icons.check,
                                                                    '5',
                                                                    this.orderStatus))),
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ))
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        )),
                  ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

_setCustomTrackOrderBubbleView(String count, String status) {
  return Column(
    children: <Widget>[
      Container(
          height: 16,
          width: 16,
          decoration: BoxDecoration(
              color: (status == '5')
                  ? AppColor.orange
                  : (int.parse(count) < int.parse(status))
                      ? AppColor.orange
                      : (int.parse(count) == int.parse(status))
                          ? AppColor.themeColor
                          : AppColor.grey[300],
              borderRadius: BorderRadius.circular(8))),
      Expanded(
          child: Container(
        width: 3,
        color: (status == '5')
            ? AppColor.orange
            : (int.parse(count) < int.parse(status))
                ? AppColor.orange
                : (int.parse(count) == int.parse(status))
                    ? AppColor.grey[300]
                    : AppColor.grey[300],
      ))
    ],
  );
}

_setOrderTrackDetailsView(
    String title, String value, IconData icon, String count, String status) {
  return Row(
    children: <Widget>[
      Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: (status == '6')
                ? (count == '5')
                    ? AppColor.grey[300]
                    : (int.parse(count) < int.parse(status))
                        ? AppColor.orange
                        : (int.parse(count) == int.parse(status))
                            ? AppColor.themeColor
                            : AppColor.grey[300]
                : (status == '5')
                    ? AppColor.orange
                    : (int.parse(count) < int.parse(status))
                        ? AppColor.orange
                        : (int.parse(count) == int.parse(status))
                            ? AppColor.themeColor
                            : AppColor.grey[300],
            borderRadius: BorderRadius.circular(20)),
        child: Center(
          child: Icon(
            icon,
            color: AppColor.white,
            size: 20,
          ),
        ),
      ),
      SizedBox(
        width: 12,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            setCommonText(
                '$title',
                (status == '6')
                    ? (count == '5')
                        ? AppColor.grey[300]
                        : (int.parse(count) < int.parse(status))
                            ? AppColor.orange
                            : (int.parse(count) == int.parse(status))
                                ? AppColor.themeColor
                                : AppColor.grey[300]
                    : (status == '5')
                        ? AppColor.black87
                        : (int.parse(count) < int.parse(status))
                            ? AppColor.black87
                            : (int.parse(count) == int.parse(status))
                                ? AppColor.themeColor
                                : AppColor.grey[300],
                13.0,
                FontWeight.w500,
                1),
            setCommonText(
                '$value',
                (status == '6')
                    ? (count == '5')
                        ? AppColor.grey[300]
                        : (int.parse(count) < int.parse(status))
                            ? AppColor.orange
                            : (int.parse(count) == int.parse(status))
                                ? AppColor.themeColor
                                : AppColor.grey[300]
                    : (status == '5')
                        ? AppColor.black87
                        : (int.parse(count) < int.parse(status))
                            ? AppColor.black54
                            : (int.parse(count) == int.parse(status))
                                ? AppColor.themeColor
                                : AppColor.grey[300],
                12.0,
                FontWeight.w400,
                2),
          ],
        ),
      )
    ],
  );
}
