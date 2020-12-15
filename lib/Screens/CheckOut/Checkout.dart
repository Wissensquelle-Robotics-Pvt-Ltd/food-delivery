import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/ProccedToCheckOutBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelRestaurantDetails.dart';
import 'package:product/ModelClass/ModelWalletAmount.dart';
import 'package:product/Screens/CheckoutSuccess/CheckoutSuccess.dart';
import 'package:product/generated/i18n.dart';
import 'package:braintree_payment/braintree_payment.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:stripe_payment/stripe_payment.dart';

void main() => runApp(new Checkout());

class Checkout extends StatefulWidget {
  final totalPrice;
  final discountedPrice;
  final charge;
  final totalSaving;
  final grandTotalAmount;
  final tipAmount;
  final String coockingInstructions;
  final List<Subcategories> cartItems;

  Checkout(
      {Key key,
      this.totalPrice,
      this.discountedPrice,
      this.charge,
      this.totalSaving,
      this.grandTotalAmount,
      this.tipAmount,
      this.coockingInstructions,
      this.cartItems})
      : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  List paymentTypeList = [
    {
      "type": S.current.default_credit_card,
      "description": S.current.click_to_pay_with_card,
      "isSelect": false,
      "image": "Assets/Payment/Card.png"
    },
    {
      "type": S.current.paypal_payment,
      "description": S.current.click_to_pay_with_paypal,
      "isSelect": false,
      "image": "Assets/Payment/paypal.png"
    },
    {
      "type": S.current.paymentWithRazorpay,
      "description": S.current.checkoutWithRazorpay,
      "isSelect": false,
      "image": "Assets/Checkout/razorpay.png"
    },
  ];

  List codTypeList = [
    {
      "type": S.current.cash_on_delivery,
      "description": S.current.click_to_pay_your_location,
      "isSelect": false,
      "image": "Assets/Payment/Cod.png"
    },
    {
      "type": S.current.pay_on_pickup,
      "description": S.current.click_to_pay_at_restaurant,
      "isSelect": false,
      "image": "Assets/Payment/coffee.png"
    }
  ];

  int payMentType = 0;

  bool isCheckOut = false;
  bool isPaymentDone = false;
  bool isWallateUse = false;
  var walletAmount = "0.0";
  var param = {};
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String error;
  Razorpay _razorpay;

  _setDeliveryAddressList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Container(
          padding: new EdgeInsets.all(10),
          // height: 120,
          // color: AppColor.red,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              setCommonText(S.current.delivery_addresses, AppColor.black87,
                  14.0, FontWeight.w600, 1),
              SizedBox(
                height: 5,
              ),
              setCommonText(SharedManager.shared.address, AppColor.black87,
                  13.0, FontWeight.w400, 2),
            ],
          ),
        ),
        new Container(
          height: 8,
          color: AppColor.grey[100],
        ),
      ],
    );
  }

  _setPaymentMethods() {
    return new Container(
      height: (this.paymentTypeList.length * 80.0) + 72,
      // color: AppColor.red,
      child: new Column(
        children: <Widget>[
          new Expanded(
            child: new Container(
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(left: 15, right: 15),
                    // height: 60,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.credit_card),
                        SizedBox(width: 10),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            setCommonText(S.current.payment_options,
                                AppColor.themeColor, 14.0, FontWeight.w500, 1),
                            SizedBox(height: 3),
                            setCommonText(
                                S.current.select_your_preferred_payment_mode,
                                AppColor.grey[600],
                                12.0,
                                FontWeight.w400,
                                2),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5),
                  new Container(
                    height: (this.paymentTypeList.length * 80.0),
                    // color: AppColor.purple,
                    padding: new EdgeInsets.only(left: 15, right: 15),
                    child: new ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: this.paymentTypeList.length,
                      itemBuilder: (context, index) {
                        return new GestureDetector(
                          onTap: () {
                            setState(() {
                              _clearSelectedPayment();
                              this.payMentType = index + 1;
                              this.paymentTypeList[index]['isSelect'] = true;
                            });
                          },
                          child: new Container(
                            height: 70,
                            padding: new EdgeInsets.only(top: 5, bottom: 5),
                            child: new Material(
                                borderRadius: new BorderRadius.circular(5),
                                elevation: 2.0,
                                color: AppColor.grey[100],
                                child: new Padding(
                                  padding:
                                      new EdgeInsets.only(left: 10, right: 10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        this.paymentTypeList[
                                                            index]['image']))),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          new Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              setCommonText(
                                                  this.paymentTypeList[index]
                                                      ['type'],
                                                  AppColor.black87,
                                                  14.0,
                                                  FontWeight.w500,
                                                  1),
                                              SizedBox(height: 3),
                                              setCommonText(
                                                  this.paymentTypeList[index]
                                                      ['description'],
                                                  AppColor.black87,
                                                  12.0,
                                                  FontWeight.w400,
                                                  1)
                                            ],
                                          )
                                        ],
                                      ),
                                      this.paymentTypeList[index]['isSelect']
                                          ? new Positioned(
                                              right: 5,
                                              child: Icon(Icons.check))
                                          : new Container(),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          new Container(
            height: 10,
            color: AppColor.grey[100],
          )
        ],
      ),
    );
  }

  _setCODMethods() {
    return new Container(
      height: (this.codTypeList.length * 80.0) + 70.0,
      // color: AppColor.red,
      child: new Column(
        children: <Widget>[
          new Expanded(
            child: new Container(
              child: new Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.only(left: 15, right: 15),
                    // height: 60,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.home),
                        SizedBox(width: 15),
                        new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            setCommonText(S.current.cash_on_delivery,
                                AppColor.themeColor, 14.0, FontWeight.w500, 1),
                            SizedBox(height: 3),
                            setCommonText(S.current.select_preferred_cardMode,
                                AppColor.grey[600], 12.0, FontWeight.w400, 2),
                          ],
                        )
                      ],
                    ),
                  ),
                  new Container(
                    height: (this.codTypeList.length * 80.0),
                    // color: AppColor.purple,
                    padding: new EdgeInsets.only(left: 15, right: 15),
                    child: new ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: this.codTypeList.length,
                      itemBuilder: (context, index) {
                        return new GestureDetector(
                          onTap: () {
                            setState(() {
                              _clearSelectedPayment();
                              this.payMentType = index + 10;
                              this.codTypeList[index]['isSelect'] = true;
                            });
                          },
                          child: new Container(
                            height: 80,
                            padding: new EdgeInsets.only(top: 5, bottom: 5),
                            child: new Material(
                                borderRadius: new BorderRadius.circular(5),
                                elevation: 2.0,
                                color: AppColor.grey[100],
                                child: new Padding(
                                  padding:
                                      new EdgeInsets.only(left: 10, right: 10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      new Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          new Container(
                                            height: 25,
                                            width: 25,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        this.codTypeList[index]
                                                            ['image']))),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          new Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              setCommonText(
                                                  this.codTypeList[index]
                                                      ['type'],
                                                  AppColor.black87,
                                                  14.0,
                                                  FontWeight.w500,
                                                  1),
                                              SizedBox(height: 3),
                                              setCommonText(
                                                  this.codTypeList[index]
                                                      ['description'],
                                                  AppColor.black87,
                                                  12.0,
                                                  (index == 2)
                                                      ? FontWeight.bold
                                                      : FontWeight.w400,
                                                  1)
                                            ],
                                          )
                                        ],
                                      ),
                                      this.codTypeList[index]['isSelect']
                                          ? new Positioned(
                                              right: 5,
                                              child: Icon(Icons.check))
                                          : new Container(),
                                    ],
                                  ),
                                )),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          new Container(
            height: 10,
            color: AppColor.grey[100],
          )
        ],
      ),
    );
  }

  _setWalletWidget() {
    return Container(
      height: 70,
      color: AppColor.white,
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          children: <Widget>[
            Checkbox(
                value: this.isWallateUse,
                onChanged: (val) {
                  if (SharedManager.shared.isCouponApplied) {
                    SharedManager.shared.showAlertDialog(
                        '${S.current.walletNotApplicableonCoupon}', context);
                  } else {
                    setState(() {
                      this.isWallateUse = val;
                    });
                  }
                }),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  setCommonText('${S.current.walletAmount}', AppColor.black54,
                      15.0, FontWeight.w500, 1),
                  setCommonText('${Currency.curr}${this.walletAmount}',
                      AppColor.black, 13.0, FontWeight.w500, 1)
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  setCommonText('${S.current.paybleAmount}', AppColor.black54,
                      15.0, FontWeight.w500, 1),
                  setCommonText('${Currency.curr}${_setWalletAmount()}',
                      AppColor.black, 13.0, FontWeight.w500, 1)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getWalletAmount() async {
    ResWalletAmount amount = ResWalletAmount();
    Requestmanager manager = Requestmanager();
    amount = await manager.fetchWalletAmount(
        '${APIS.walletAmount}' + SharedManager.shared.userID);
    print('Wallet Amount:--->${amount.amount.walletAmount}');
    setState(() {
      // this.codTypeList[2]['description'] =
      //     '${Currency.curr}${amount.amount.walletAmount}';
      this.walletAmount = amount.amount.walletAmount;
      // _setWalletAmount();
    });
  }

  String _setWalletAmount() {
    if (this.isWallateUse) {
      if (double.parse(this.walletAmount) >=
          double.parse(this.widget.grandTotalAmount)) {
        this.payMentType = 20;
      } else {
        this.payMentType = this.payMentType;
      }
    } else {
      this.payMentType = this.payMentType;
    }
    return this.isWallateUse
        ? (double.parse(this.walletAmount) >=
                double.parse(this.widget.grandTotalAmount))
            ? "0.0"
            : (double.parse(this.widget.grandTotalAmount) -
                    double.parse(this.walletAmount))
                .toString()
        : this.widget.grandTotalAmount;
  }

  _clearSelectedPayment() {
    for (var i = 0; i < this.paymentTypeList.length; i++) {
      this.paymentTypeList[i]['isSelect'] = false;
    }
    for (var i = 0; i < this.codTypeList.length; i++) {
      this.codTypeList[i]['isSelect'] = false;
    }
  }

  _setPromoCodeGrandTotalWidgets() {
    return new Container(
      height: 160,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Expanded(
            flex: 3,
            child: new Container(
                padding: new EdgeInsets.only(left: 15, right: 15),
                color: AppColor.white,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            setCommonText(S.current.item_total, AppColor.grey,
                                14.0, FontWeight.w500, 1),
                          ],
                        ),
                        new Row(
                          children: <Widget>[
                            new Stack(
                              alignment: Alignment.center,
                              children: <Widget>[
                                setCommonText(
                                    '${Currency.curr}${this.widget.totalPrice}',
                                    AppColor.grey,
                                    12.0,
                                    FontWeight.w500,
                                    1),
                                new Container(
                                    width: 50, height: 2, color: AppColor.grey),
                              ],
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            setCommonText(
                                '${Currency.curr}${this.widget.discountedPrice}',
                                AppColor.grey,
                                12.0,
                                FontWeight.w500,
                                1),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        setCommonText(S.current.charges, AppColor.grey, 14.0,
                            FontWeight.w500, 1),
                        SizedBox(
                          width: 6,
                        ),
                        setCommonText('${Currency.curr}${this.widget.charge}.0',
                            AppColor.red, 12.0, FontWeight.w500, 1),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        setCommonText(S.current.total_amount,
                            AppColor.themeColor, 14.0, FontWeight.w500, 1),
                        SizedBox(
                          width: 6,
                        ),
                        setCommonText(
                            '${Currency.curr}${this.widget.totalSaving}',
                            AppColor.themeColor,
                            12.0,
                            FontWeight.w500,
                            1),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Divider(
                      color: AppColor.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        setCommonText(S.current.grand_total, AppColor.black,
                            15.0, FontWeight.w500, 1),
                        SizedBox(
                          width: 6,
                        ),
                        setCommonText(
                            '${Currency.curr}${this.widget.grandTotalAmount}',
                            AppColor.black,
                            13.0,
                            FontWeight.w500,
                            1),
                      ],
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }

//TODO: Payment Methods

//Razor Pay Method
  _setUpRaZorPay() async {
    var options = {
      'key': Keys.razorPayId,
      'amount': (double.parse(_setWalletAmount()) * 100),
      'name': '${S.current.food_zone}',
      'description': '${SharedManager.shared.resName}',
      'prefill': {
        'contact': '${SharedManager.shared.userPhone()}',
        'email': '${SharedManager.shared.userEmail()}'
      },
      'external': {
        'wallets': ['paytm', 'phonepay']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void setError(dynamic error) {
    _scaffoldKey.currentState
        .showSnackBar(SnackBar(content: Text(error.toString())));
    setState(() {
      error = error.toString();
    });
  }

//RazorPay Delegates
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // SharedManager.shared.showAlertDialog('Payment success', context);
    _proccedToCheckOut('4', response.paymentId);
    // Fluttertoast.showToast(
    //     msg: "SUCCESS: " + response.paymentId, backgroundColor: Colors.black87);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    SharedManager.shared.showAlertDialog('Payment failed', context);
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message,
    //     backgroundColor: Colors.black87);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    SharedManager.shared.showAlertDialog('Payment from wallete', context);
    _proccedToCheckOut('4', response.walletName);
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName,
    //     backgroundColor: Colors.black87);
  }

  _paymentWithStripe() async {
    StripePayment.setOptions(
        StripeOptions(publishableKey: '${Keys.publishKey}'));
    StripePayment.paymentRequestWithCardForm(CardFormPaymentRequest())
        .catchError((e) {
      print('ERROR ${e.toString()}');
    }).then((paymentMethod) async {
      //DO SOMETHING WITH YOUR PAYMENT METHOD
      print("Stripe Token is:-${paymentMethod.card}");
      await _paymentWithType("2", paymentMethod.id);
    });
  }

  _paymentWithWallet() {
    _proccedToCheckOut('5', '');
  }

  _getTokenForPaypalPayment() async {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text("${S.current.loading}")));

    final param = {"user_id": SharedManager.shared.userID};
    final reqManager = Requestmanager();
    final result = await reqManager.getPayPalToken(param);
    print("Result payment token message:${result.message}");
    print("Result payment token:$result");
    if (result.code == 1) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      print("Current Token:${result.result}");
      payNow(result.result);
    } else {
      _scaffoldKey.currentState.hideCurrentSnackBar();
    }
  }

  payNow(String token) async {
    BraintreePayment braintreePayment = new BraintreePayment();
    var data = await braintreePayment.showDropIn(
        nonce: token,
        // nonce: 'sandbox_8hxpnkht_kzdtzv2btm4p7s5j',
        amount: "200.0",
        enableGooglePay: false,
        googleMerchantId: Keys.paypalMerchantID,
        inSandbox: true,
        nameRequired: false);
    print("Response of the payment $data");

    if (Platform.isAndroid) {
      final cleanMap = jsonDecode(jsonEncode(data));
      _paymentWithType("3", cleanMap['paymentNonce']);
    } else {
      // final cleanMap = jsonDecode(jsonEncode(data));
      _paymentWithType("3", data.toString());
    }
  }

  _paymentWithPaypal() {
    _getTokenForPaypalPayment();
  }

  _paymentWithType(String type, String token) async {
    await _proccedToCheckOut(type, token);
  }

  _setCheckOutButtonWidgets() {
    return new Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      // color: AppColor.red,
      padding: new EdgeInsets.only(left: 25, right: 25, top: 8, bottom: 8),
      child: GestureDetector(
        onTap: () {
          if (this.payMentType == 0) {
            SharedManager.shared.showAlertDialog(
                "${S.current.selectPaymentMethodFirst}", context);
          } else if (this.payMentType == 1) {
            //Payment with Stripe
            _paymentWithStripe();
          } else if (this.payMentType == 2) {
            //Payment with PayPal
            _paymentWithPaypal();
          } else if (this.payMentType == 3) {
            //Payment with RazorPay
            _setUpRaZorPay();
          } else if (this.payMentType == 20) {
            //Payment with Wallet
            _paymentWithWallet();
          } else if (this.payMentType == 10) {
            _paymentWithType("1", "");
          } else {
            //Pay on Pickup
            _paymentWithType("1", "");
          }
        },
        child: new Material(
          elevation: 2.0,
          borderRadius: BorderRadius.circular(26),
          color: AppColor.themeColor,
          child: new Center(
            child: setCommonText(
                S.current.checkout, AppColor.white, 16.0, FontWeight.w500, 1),
          ),
        ),
      ),
    );
  }

  _proccedToCheckOut(String paymentType, String token) async {
    //1=> COD, 2=>Stripe, 3=>Paypal

// SharedManager.shared.showAlertDialog("token is:$token", context);
    var productDetails = [];

    for (var i = 0; i < this.widget.cartItems.length; i++) {
      final item = this.widget.cartItems[i];
      final detail = {
        "product_id": "${item.id}",
        "product_price": "${item.price}",
        "extra_note": "${this.widget.coockingInstructions}",
        "product_quantity": "${item.count}"
      };
      productDetails.add(detail);
    }

//calculation part is remaining.
//grandTotal - discount - wallet == total_price
//if use whole amount from the wallet total_price would be 0

    this.param = {
      "address_id": "${SharedManager.shared.addressId}",
      "user_id": "${SharedManager.shared.userID}",
      "restaurent_id": "${SharedManager.shared.restaurantID}",
      "total_price": this.isWallateUse
          ? "${double.parse(this.walletAmount) >= double.parse(this.widget.grandTotalAmount) ? 0.0 : (double.parse(this.widget.grandTotalAmount) - double.parse(this.walletAmount))}"
          : "${this.widget.grandTotalAmount}",
      "tip_price": "${this.widget.tipAmount}",
      "payment_type": paymentType,
      "ProductDetails": productDetails,
      "token_id": token,
      "wallet_price": this.isWallateUse
          ? "${double.parse(this.walletAmount) >= double.parse(this.widget.grandTotalAmount) ? double.parse(this.widget.grandTotalAmount) : double.parse(this.walletAmount)}"
          : '0',
      "promo_code": "${SharedManager.shared.couponCode}",
      "discount_price": '${SharedManager.shared.discountPice}',
    };

    print('Parameters:$param');

    // setState(() {
    //   this.isCheckOut = true;
    //   this.isPaymentDone = true;
    // });

    Requestmanager manager = Requestmanager();
    showSnackbar(S.current.loading, _scaffoldKey);
    await manager.proccedToCheckOut(APIS.makeOrder, param).then((value) {
      _scaffoldKey.currentState.hideCurrentSnackBar();
      if (value.code == 1) {
        Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => CheckoutSuccess()),
            ModalRoute.withName(AppRoute.checkOut));
      } else {
        SharedManager.shared
            .showAlertDialog('Please try after sometimes', context);
      }
    });
  }

  ModalRoute<dynamic> _route;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _route?.removeScopedWillPopCallback(_onWillPop);
    _route = ModalRoute.of(context);
    _route?.addScopedWillPopCallback(_onWillPop);
  }

  @override
  void dispose() {
    _route?.removeScopedWillPopCallback(_onWillPop);
    checkOutBloc.dispose();
    _razorpay.clear();
    super.dispose();
  }

  Future<bool> _onWillPop() => Future.value(false);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    //   StripePayment.setOptions(
    // StripeOptions(publishableKey: "pk_test_aSaULNS8cJU6Tvo20VAXy6rp", merchantId: "Test", androidPayMode: 'test'));
    // StripePayment.setOptions(StripeOptions(
    //     publishableKey: Keys.publishKey,
    //     merchantId: "Test",
    //     androidPayMode: 'test'));

    print("Cart List Items:${this.widget.cartItems[0].count}");
    print("Restaurant ID:${SharedManager.shared.restaurantID}");
    print("Address ID:${SharedManager.shared.addressId}");
    print("User ID:${SharedManager.shared.userID}");
    _getWalletAmount();

    //Razorpay setup
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    this.isCheckOut
        ? checkOutBloc.proccedToCheckOut(APIS.makeOrder, this.param)
        : new Text('');
    return new Scaffold(
      key: _scaffoldKey,
      appBar: this.isPaymentDone
          ? new EmptyAppBar()
          : new AppBar(
              leading: new IconButton(
                icon: Icon(Icons.arrow_back, color: AppColor.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: AppColor.white,
              ),
              backgroundColor: AppColor.themeColor,
              elevation: 1.0,
              brightness: Brightness.light,
              title: setCommonText(
                  S.current.checkout, AppColor.white, 22.0, FontWeight.w500, 1),
            ),
      body: Container(
        color: AppColor.white,
        child: new ListView(
          children: <Widget>[
            _setDeliveryAddressList(),
            _setPaymentMethods(),
            _setCODMethods(),
            _setWalletWidget(),
            new Container(
              height: 10,
              color: AppColor.grey[100],
            ),
            _setPromoCodeGrandTotalWidgets(),
            _setCheckOutButtonWidgets()
          ],
        ),
      ),
    );
  }
}
