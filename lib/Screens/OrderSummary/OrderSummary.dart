import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/OrderDetailsBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelOrderDetails.dart';
import 'package:product/ModelClass/ModelRestaurantDetails.dart';
import 'package:product/Screens/Cart/Cart.dart';
import 'package:product/Screens/OrderStatusPage/OrderStatusPage.dart';
import 'package:product/Screens/TabBarScreens/TabScreen/TabBar.dart';
import 'package:product/generated/i18n.dart';

import 'Widgets/ItemListWidget.dart';
import 'Widgets/OrderDetails.dart';
import 'Widgets/ProductDetailsWidget.dart';
import 'Widgets/RestaurantDetaisWidget.dart';

void main() => runApp(new OrderSummary());

class OrderSummary extends StatefulWidget {
  final orderId;
  final String orderStatus;
  final String review;

  OrderSummary({Key key, this.orderId, this.orderStatus, this.review})
      : super(key: key);
  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  var totalPrice = 0.0;
  var discountedPrice = 0.0;
  Details result;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> cancelOrder(String orderId) async {
    Requestmanager manager = Requestmanager();
    bool status = false;
    await manager.requestForCancelOrder(orderId).then((value) {
      status = value;
    });
    _scaffoldKey.currentState.hideCurrentSnackBar();
    return status;
  }

  bool _setUpOrderStatus(String status) {
    switch (status) {
      case "1":
        return false;
      case "2":
        return false;
      case "3":
        return false;
      case "4":
        return true;
      case "5":
        return true;
      case "9":
        return false;
      default:
        return false;
    }
  }

  _setUpCartItemData(List<Products> itemList, String resName, String resAddress,
      String resImage) {
    List<Subcategories> itemListData = [];

    for (var item in itemList) {
      var category = Subcategories();

      category.count = int.parse(item.productQuantity);
      category.description = item.description;
      category.discount = item.discount;
      category.discountType = "";
      category.id = item.productId;
      category.image = item.image;
      category.isAdded = false;
      category.name = item.productName;
      category.price = item.price;
      category.type = item.type;

      itemListData.add(category);
    }

    SharedManager.shared.cartItems = itemListData;
    SharedManager.shared.resAddress = resAddress;
    SharedManager.shared.resImage = resImage;
    SharedManager.shared.resName = resName;
    SharedManager.shared.isFromTab = false;
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => CartApp()));
  }

  @override
  Widget build(BuildContext context) {
    orderDetailsBloc.fetchOrderDetails(this.widget.orderId);
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: setCommonText(
            S.current.order_summary, AppColor.white, 20.0, FontWeight.w600, 1),
        backgroundColor: AppColor.themeColor,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.white,
          ),
          onPressed: () {
            Navigator.of(context).pop(true);
          },
        ),
        actions: <Widget>[
          (this.widget.orderStatus != "9" && this.widget.orderStatus != "3")
              ? IconButton(
                  icon: Icon(
                    Icons.navigation,
                    color: AppColor.white,
                  ),
                  onPressed: () {
                    // _modalBottomSheetMenu();
                    //OrderStatusPage
                    //OrderTrackingPage
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderStatusPage(
                              orderStatus: this.widget.orderStatus,
                              resImage: this.result.bannerImage,
                              resName: this.result.name,
                              resAddress: this.result.address,
                              orderId: this.widget.orderId,
                              resID: result.restaurantId,
                              driverId: result.driverId,
                              isReview: result.isReview,
                              review: this.widget.review,
                              latitude: this.result.latitude,
                              longitude: this.result.longitude,
                            ),
                        fullscreenDialog: true));
                  })
              : Text('')
        ],
      ),
      body: StreamBuilder(
          stream: orderDetailsBloc.orderDetails,
          builder: (context, AsyncSnapshot<ResOrderDetails> snapshot) {
            if (snapshot.hasData) {
              result = snapshot.data.orderDetails;
              return new Container(
                color: AppColor.white,
                child: Column(
                  children: <Widget>[
                    new Expanded(
                      child: new ListView(
                        children: <Widget>[
                          RestaurantDetailsWidget(result.name, result.address),
                          OrderDetailsWidget(result.products),
                          ItemListWidget(result.products, result.totalPrice,
                              result.tipPrice),
                          OrderDetails(
                              result.orderId,
                              result.paymentType,
                              result.date,
                              result.phone,
                              result.deliveryAddress),
                        ],
                      ),
                    ),
                    (this.widget.orderStatus != "9" &&
                            this.widget.orderStatus != "3")
                        ? (_setUpOrderStatus(result.orderStatus))
                            ? new GestureDetector(
                                onTap: () {
                                  _setUpCartItemData(
                                      result.products,
                                      result.name,
                                      result.address,
                                      result.bannerImage);
                                },
                                child: new Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  padding: new EdgeInsets.only(
                                      top: 5, bottom: 15, left: 35, right: 35),
                                  child: new Material(
                                    color: AppColor.themeColor,
                                    borderRadius: new BorderRadius.circular(50),
                                    child: new Container(
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          setCommonText(
                                              S.current.repeat_order,
                                              AppColor.white,
                                              16.0,
                                              FontWeight.w500,
                                              1),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          setCommonText(
                                              S.current
                                                  .order_will_shown_in_cart,
                                              AppColor.white,
                                              14.0,
                                              FontWeight.w400,
                                              1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : new Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                color: AppColor.white.withAlpha(0),
                                padding: new EdgeInsets.only(
                                    top: 0, bottom: 10, left: 35, right: 35),
                                child: new GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        // return object of type Dialog
                                        return AlertDialog(
                                          title: setCommonText(
                                              '${S.current.confirmations}',
                                              AppColor.black,
                                              20.0,
                                              FontWeight.w500,
                                              2),
                                          content: SingleChildScrollView(
                                            child: Container(
                                              // height: 140,
                                              // color: AppColor.amber,
                                              child: Column(
                                                children: <Widget>[
                                                  setCommonText(
                                                      '${S.current.areYouSureWantToCancelOrder}',
                                                      AppColor.black87,
                                                      16.0,
                                                      FontWeight.w500,
                                                      2),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      setCommonText(
                                                          '${S.current.order_Id}',
                                                          AppColor.black87,
                                                          14.0,
                                                          FontWeight.w500,
                                                          2),
                                                      setCommonText(
                                                          '#${this.widget.orderId}',
                                                          AppColor.red,
                                                          14.0,
                                                          FontWeight.w500,
                                                          2),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  setCommonText(
                                                      '${S.current.makeSureCancelOrderAlert}',
                                                      AppColor.black54,
                                                      14.0,
                                                      FontWeight.w500,
                                                      10)
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            // usually buttons at the bottom of the dialog
                                            new FlatButton(
                                              child: setCommonText(
                                                  '${S.current.cancel}',
                                                  AppColor.themeColor,
                                                  15.0,
                                                  FontWeight.w500,
                                                  2),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            new FlatButton(
                                              child: setCommonText(
                                                  '${S.current.ok}',
                                                  AppColor.themeColor,
                                                  15.0,
                                                  FontWeight.w500,
                                                  2),
                                              onPressed: () async {
                                                showSnackbar(
                                                    '${S.current.loading}',
                                                    _scaffoldKey);
                                                await cancelOrder(
                                                        this.widget.orderId)
                                                    .then((value) {
                                                  SharedManager
                                                      .shared.currentIndex = 0;
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TabBarScreen()),
                                                          ModalRoute.withName(
                                                              AppRoute.tabbar));
                                                });
                                                // Navigator.of(context).pop(true);
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                    // Navigator.of(context).push(MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         SubmitReviewScreen()));
                                  },
                                  child: new Material(
                                    color: AppColor.red,
                                    borderRadius: new BorderRadius.circular(50),
                                    child: new Container(
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          setCommonText(
                                              S.current.cancel_order,
                                              AppColor.white,
                                              16.0,
                                              FontWeight.w500,
                                              1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                        : new Container(
                            height: 75,
                            width: MediaQuery.of(context).size.width,
                            padding: new EdgeInsets.only(
                                top: 5, bottom: 15, left: 35, right: 35),
                            child: new Material(
                              color: AppColor.red,
                              borderRadius: new BorderRadius.circular(50),
                              child: new Container(
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    setCommonText(
                                        '${S.current.orderCancelled}',
                                        AppColor.white,
                                        18.0,
                                        FontWeight.w500,
                                        1),
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              );
            } else {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

//1 received
//2 accept
//3 declined
//4 preparing
//5 delivered
