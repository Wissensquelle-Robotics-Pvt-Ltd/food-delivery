import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/RestaurantDetails.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelRestaurantDetails.dart';
import 'package:product/Screens/Cart/Cart.dart';
import 'package:product/Screens/ReviewListScreen/ReviewListScreen.dart';
import 'package:product/generated/i18n.dart';
import 'package:product/Screens/CheckOut/Checkout.dart';

import 'Widgets/ReviewWidgets/ReviewWidgets.dart';

void main() => runApp(new BannerDetailsScreen());

class BannerDetailsScreen extends StatefulWidget {
  final restaurantID;
  BannerDetailsScreen({Key key, this.restaurantID}) : super(key: key);
  @override
  _BannerDetailsScreenState createState() => _BannerDetailsScreenState();
}

class _BannerDetailsScreenState extends State<BannerDetailsScreen> {
  var itemCount = 0;
  var totlaPrice = 0.0;
  bool isFirst = false;
  var result = ResDetails();
  bool isGrid = false;
  // Declared Variable for Checkbox
  bool bake = false;
  bool sause = false;
  bool cheese = false;
  // Declare Variables of Grand Total and ItemTotal

  var totalPrice = 0.0;
  var paidPrice = 0.0;
  var riderTip = 0;
  var charge = 20;
  var discountedPrice = 0.0;
  var grandTotalAmount = 0.0;

  InterstitialAd myInterstitial;

  @override
  void initState() {
    // try {
    //   SharedManager.shared.myBanner.dispose();
    //   SharedManager.shared.myBanner = null;
    // } catch (ex) {
    //   print("banner dispose error");
    // }

    _setIntestatialAdds();

    super.initState();
    print("Restaurant id:${widget.restaurantID}");
    SharedManager.shared.restaurantID = this.widget.restaurantID;
  }

  @override
  void dispose() {
    try {
      this.myInterstitial.dispose();
      this.myInterstitial = null;
    } catch (ex) {
      print("banner dispose error");
    }
    super.dispose();
  }

  _setIntestatialAdds() {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['food', 'Zometo', 'Food Panda', 'Uber Eats'],
      contentUrl: 'google.com',
      childDirected: false, // or MobileAdGender.female, MobileAdGender.unknown
      testDevices: <String>[], // Android emulators are considered test devices
    );

    this.myInterstitial = InterstitialAd(
      adUnitId: Keys.interstatialID,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd event is $event");
      },
    );

    FirebaseAdMob.instance.initialize(appId: Keys.admobAppID);
    this.myInterstitial
      ..load()
      ..show(
        anchorType: AnchorType.bottom,
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
  }

  _setSocialWidgets(double width, String review, String resName) {
    return new Container(
      width: width,
      height: 80,
      color: AppColor.white,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.share, color: AppColor.black, size: 20),
              setCommonText(
                  S.current.share, AppColor.black, 14.0, FontWeight.w500, 1)
            ],
          ),
          SizedBox(
            width: 30,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.phone, color: AppColor.black, size: 20),
              setCommonText(
                  S.current.contact, AppColor.black, 14.0, FontWeight.w500, 1)
            ],
          ),
          SizedBox(
            width: 30,
          ),
          InkWell(
            onTap: () {
              if (review != '0.0') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ReviewListScreen(
                        restaurantId: this.widget.restaurantID,
                        restaurantName: resName),
                    fullscreenDialog: true));
              } else {
                SharedManager.shared.showAlertDialog(
                    '${S.current.reviewNotAvailable}', context);
              }
            },
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    setCommonText(
                        '$review', AppColor.black, 16.0, FontWeight.bold, 1),
                    Icon(
                      Icons.star,
                      color: AppColor.orange,
                      size: 18,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3,
                ),
                setCommonText("${S.current.reviews}", AppColor.black, 13.0,
                    FontWeight.w500, 1)
              ],
            ),
          )
        ],
      ),
    );
  }

  _setRestaurantDetails(List<Categories> categories) {
    return new Container(
        // color:AppColor.red,
        padding: new EdgeInsets.only(left: 15, right: 15, top: 5),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            setCommonText(S.current.res_recommenditions, AppColor.black, 16.0,
                FontWeight.w500, 1),
            SizedBox(
              height: 5,
            ),
            new Wrap(
                spacing: 5,
                runSpacing: 0,
                alignment: WrapAlignment.start,
                children: _setChipsWidgets(categories)),
            Divider(
              color: AppColor.grey,
            ),
          ],
        ));
  }

  List<Chip> _setChipsWidgets(List<Categories> categories) {
    List<Chip> chips = [];
    for (int i = 0; i < categories.length; i++) {
      final chip = new Chip(
        backgroundColor: AppColor.themeColor,
        label: setCommonText('${categories[i].categoryName}', AppColor.white,
            12.0, FontWeight.w500, 1),
      );
      chips.add(chip);
    }
    return chips;
  }

  _setAddressWidgets(
      String address, String discount, String openingTime, String closingTime) {
    return new Container(
      // height: 155,
      color: AppColor.white,
      padding: new EdgeInsets.only(top: 3, left: 15, right: 15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          setCommonText(
              S.current.res_address, AppColor.black, 16.0, FontWeight.w500, 1),
          SizedBox(height: 3),
          new Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: new Container(
                    // color: AppColor.white,
                    // height: 50,
                    child: setCommonText(
                        address, AppColor.black, 12.0, FontWeight.w400, 2)),
              ),
            ],
          ),
          new Divider(
            color: AppColor.grey,
          ),
          new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              setCommonText(S.current.delivery_in_minutes, AppColor.amber, 15.0,
                  FontWeight.w500, 2),
              SizedBox(
                height: 5,
              ),
              setCommonText('$discount% ${S.current.all_offer}', AppColor.teal,
                  13.0, FontWeight.w500, 1),
            ],
          ),
          Divider(
            color: AppColor.grey,
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText(S.current.opening_time, AppColor.amber, 14.0,
                      FontWeight.w600, 2),
                  SizedBox(
                    height: 5,
                  ),
                  setCommonText('$openingTime AM', AppColor.teal, 12.0,
                      FontWeight.w500, 1),
                ],
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText(S.current.closing_time, AppColor.amber, 14.0,
                      FontWeight.w600, 2),
                  SizedBox(
                    height: 5,
                  ),
                  setCommonText('$closingTime PM', AppColor.teal, 12.0,
                      FontWeight.w500, 1),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  setCommonText('${S.current.availability}', AppColor.black,
                      14.0, FontWeight.w600, 2),
                  SizedBox(
                    height: 5,
                  ),
                  (result.isAvailable == '1')
                      ? setCommonText('${S.current.open}', Colors.green, 12.0,
                          FontWeight.bold, 1)
                      : setCommonText('${S.current.closed}', AppColor.red, 12.0,
                          FontWeight.bold, 1),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: AppColor.grey,
          )
        ],
      ),
    );
  }

  List<Subcategories> subcatList = [];
  int _counter = 1;
  int _boundryValue = 0;
  bool changecolor = false;
  void _incrementCount() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter != 0) _counter--;
    });
  }

  _setDynamicCategory(int subCatCount, dynamic data, double width) {
    return Container(
      height: calculateTotalHeight(data),
      // color: AppColor.red,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: new ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: subcatList.length,
          // itemCount: 2,
          itemBuilder: (context, row) {
            return Container(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 1,
                          color: AppColor.grey[300],
                          offset: Offset(0, 0))
                    ]),
                child: new Row(
                  children: <Widget>[
                    new Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: new Container(
                            width: 85,
                            height: 85,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(subcatList[row].image),
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                      ],
                    ),
                    new Expanded(
                      flex: 2,
                      child: new Container(
                        // color: AppColor.red,
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Row(
                              children: <Widget>[
                                new Expanded(
                                    flex: 2,
                                    child: setCommonText(
                                        subcatList[row].name,
                                        AppColor.black,
                                        14.0,
                                        FontWeight.w500,
                                        1)),
                                // SizedBox(width: 5,),
                              ],
                            ),
                            setCommonText(subcatList[row].catigoryName,
                                AppColor.black54, 13.0, FontWeight.w500, 1),
                            SizedBox(
                              height: 2,
                            ),
                            setCommonText(subcatList[row].description,
                                AppColor.grey[600], 12.0, FontWeight.w400, 2),
                            SizedBox(
                              height: 5,
                            ),
                            new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    new Stack(
                                      alignment: Alignment.center,
                                      children: <Widget>[
                                        setCommonText(
                                            '${Currency.curr}${subcatList[row].price}',
                                            AppColor.grey[600],
                                            12.0,
                                            FontWeight.w600,
                                            1),
                                        new Container(
                                          height: 2,
                                          width: 40,
                                          color: AppColor.grey[700],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    setCommonText(
                                        '${Currency.curr}${double.parse(subcatList[row].price) - double.parse(subcatList[row].discount)}',
                                        AppColor.black,
                                        12.0,
                                        FontWeight.w700,
                                        1),
                                  ],
                                ),
                                subcatList[row]
                                        .isAdded // Added Quantity Counter Button
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xff62C45D),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Material(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  onTap: () {
                                                    setState(() {
                                                      subcatList[row].count =
                                                          subcatList[row]
                                                                  .count -
                                                              1;
                                                      if (subcatList[row]
                                                              .count <
                                                          1) {
                                                        subcatList[row]
                                                            .isAdded = false;

                                                        this.itemCount =
                                                            _setItemCount(
                                                                subcatList);
                                                      }
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      border: Border.all(
                                                          color: Colors.red),
                                                    ),
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15, right: 15),
                                                child: Text(
                                                  "${subcatList[row].count}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Material(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: InkWell(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  onTap: () {
                                                    setState(() {
                                                      subcatList[row].count =
                                                          subcatList[row]
                                                                  .count +
                                                              1;
                                                    });
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      border: Border.all(
                                                          color: Colors.red),
                                                    ),
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: new Container(
                                          height: 30,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: InkWell(
                                            onTap: () {
                                              if (subcatList[row].isAvailable ==
                                                  '1') {
                                                setState(() {
                                                  if (subcatList[row].isAdded) {
                                                    subcatList[row].isAdded =
                                                        false;
                                                  } else {
                                                    subcatList[row].isAdded =
                                                        true;
                                                  }
                                                  this.itemCount =
                                                      _setItemCount(subcatList);
                                                });
                                              } else {
                                                commonItemOutofStockAlert(
                                                    context);
                                              }
                                            },
                                            child: new Center(
                                              // child: subcatList[row].isAdded
                                              //     ? setCommonText(
                                              //         S.current.added,
                                              //         AppColor.red,
                                              //         12.0,
                                              //         FontWeight.w600,
                                              //         1)
                                              child: setCommonText(
                                                  S.current.add_plus,
                                                  AppColor.themeColor,
                                                  12.0,
                                                  FontWeight.w600,
                                                  1),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  double calculateTotalHeight(List<Categories> categories) {
    var height = 0.0;
    var count = 0.0;
    this.subcatList = [];
    for (var category in categories) {
      count = count + category.subcategories.length;
      for (var subCat in category.subcategories) {
        subCat.catigoryName = category.categoryName;
        this.subcatList.add(subCat);
      }
    }
    height = count * 115;
    print("Final Height is:$height");
    return height;
  }

  int _setItemCount(List<Subcategories> subcategoryList) {
    var count = 0;
    var price = 0.0;
    SharedManager.shared.cartItems = [];

    for (int j = 0; j < subcategoryList.length; j++) {
      if (subcategoryList[j].isAdded) {
        count = count + 1;
        price = price +
            (double.parse(subcategoryList[j].price) -
                double.parse(subcategoryList[j].discount));
        SharedManager.shared.cartItems.add(subcategoryList[j]);
      }
    }
    this.totlaPrice = price;
    return count;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    resDetailsBloc.fetchRestaurantDetails(widget.restaurantID, APIS.resDetails);

    _setHeroImage(String strUrl) {
      return new Hero(
        tag: 0,
        child: new Stack(
          children: <Widget>[
            new DecoratedBox(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(strUrl),
                  // image: new AssetImage('Assets/RestaurantDetails/RestaurantApp.jpg'),
                ),
                shape: BoxShape.rectangle,
              ),
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width - 150),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[
                        new Color(0x00000000),
                        new Color(0x00FFFFFF),
                      ],
                      stops: [
                        0.0,
                        1.0
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(0.0, 1.0)),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return new Scaffold(
      body: new StreamBuilder(
        stream: resDetailsBloc.restaurantDetails,
        builder: (context, AsyncSnapshot<ResRestaurantDetails> snapshot) {
          if (snapshot.hasData) {
            if (!isFirst) {
              this.isFirst = true;
              this.result = snapshot.data.result;
              SharedManager.shared.resLatitude = this.result.latitude;
              SharedManager.shared.resLongitude = this.result.longitude;
              SharedManager.shared.resAddress = this.result.address;
              SharedManager.shared.resImage = this.result.bannerImage;
              SharedManager.shared.resName = this.result.name;
            } else {
//
            }
            // var result = snapshot.data.result;
            print("Restaurant final result:$result");
            return CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                SliverAppBar(
                  centerTitle: true,
                  backgroundColor: AppColor.themeColor,
                  iconTheme: IconThemeData(color: AppColor.white),
                  expandedHeight: MediaQuery.of(context).size.width - 120,
                  elevation: 0.1,
                  pinned: true,
                  flexibleSpace: new FlexibleSpaceBar(
                    centerTitle: true,
                    title: setCommonText(
                        result.name, AppColor.white, 14.0, FontWeight.w500, 2),
                    background: new Stack(
                      children: <Widget>[
                        _setHeroImage(result.bannerImage),
                        Container(
                          color: AppColor.black.withOpacity(0.3),
                        )
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: new EdgeInsets.all(8),
                    child: new Container(
                      color: AppColor.white,
                      child: new Column(
                        children: <Widget>[
                          _setSocialWidgets(
                              width,
                              (result.avgReview != null)
                                  ? result.avgReview
                                  : '0.0',
                              result.name),
                          _setRestaurantDetails(result.categories),
                          _setAddressWidgets(result.address, result.discount,
                              result.openingTime, result.closingTime),
                          _setDynamicCategory(
                            result.categories.length,
                            result.categories,
                            width,
                          ),
                          ReviewWidgets(result.reviews,
                              this.widget.restaurantID, result.name),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.all(10.0),
          child: (this.itemCount > 0)
              ? new Container(
                  color: AppColor.white,
                  height: 50,
                  child: new Material(
                      color: AppColor.themeColor,
                      borderRadius: new BorderRadius.circular(30),
                      child: new Container(
                        padding: new EdgeInsets.only(left: 20, right: 15),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Text(
                                  "${this.itemCount} ${S.current.items}",
                                  style: new TextStyle(
                                      color: AppColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                new Text(
                                  "${S.current.totals} ${Currency.curr}${this.totlaPrice}",
                                  style: new TextStyle(
                                      color: AppColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                            new Row(
                              children: <Widget>[
                                new GestureDetector(
                                  onTap: () {
                                    if (result.isAvailable == '1') {
                                      List<Subcategories> listData = [];
                                      for (int i = 0;
                                          i < this.result.categories.length;
                                          i++) {
                                        List<Subcategories> subList = this
                                            .result
                                            .categories[i]
                                            .subcategories;
                                        for (int j = 0;
                                            j < subList.length;
                                            j++) {
                                          if (subList[j].isAdded) {
                                            listData.add(subList[j]);
                                          }
                                        }
                                      }
                                      SharedManager.shared.cartItems = listData;
                                      SharedManager.shared.resAddress =
                                          this.result.address;
                                      SharedManager.shared.resImage =
                                          this.result.bannerImage;
                                      SharedManager.shared.resName =
                                          this.result.name;
                                      SharedManager.shared.isFromTab = false;
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => CartApp()));
                                      _modalBottomSheetMenu(); // Added Bottom Model Sheet for Addones
                                    } else {
                                      commonRestaurantCloseAlert(context);
                                    }
                                  },
                                  child: new Text(
                                    S.current.view_cart,
                                    style: new TextStyle(
                                        fontSize: 16,
                                        color: AppColor.white,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                new Icon(Icons.arrow_forward,
                                    color: AppColor.white)
                              ],
                            )
                          ],
                        ),
                      )),
                )
              : null),
    );
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
              // using StateFullBuilder for managing state in showModelBottomSheet
              builder: (BuildContext context, StateSetter dialogsetState) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                        ))),
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Color(0xff5BBB55),
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Delivery at ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  )),
                              TextSpan(
                                  text: "Ahmednagar",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  )),
                            ])),
                            Expanded(child: Container()),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_circle_down,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                        ))),
                        child: Row(
                          children: [
                            Icon(
                              Icons.lock_clock,
                              color: Color(0xff5BBB55),
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text:
                                      "Delivery in 47 mins with live tracking ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ])),
                          ],
                        ),
                      ),
                      _setAddedProductList(
                          (SharedManager.shared.cartItems.length *
                              100.0)), // Added Product List Method
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: Row(
                          children: [
                            Text(
                              "\u20B9 50 for each ",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Cheese",
                                style: TextStyle(fontSize: 12),
                              ),
                              value: cheese,
                              onChanged: (newValue) {
                                dialogsetState(() {
                                  // dialogsetState is Comming from Statefulbuilder
                                  if (cheese == true) {
                                    totalPrice = totalPrice - 50;
                                  } else {
                                    totalPrice = totalPrice + 50;
                                  }
                                  cheese = newValue;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Baked",
                                style: TextStyle(fontSize: 12),
                              ),
                              value: bake,
                              onChanged: (newValue) {
                                dialogsetState(() {
                                  if (bake == true) {
                                    totalPrice = totalPrice - 50;
                                  } else {
                                    totalPrice = totalPrice + 50;
                                  }
                                  bake = newValue;
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                          ),
                          Expanded(
                            child: CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                "Extra sauce",
                                style: TextStyle(fontSize: 10),
                              ),
                              value: sause,
                              onChanged: (newValue) {
                                dialogsetState(() {
                                  sause = newValue;
                                  if (sause == true) {
                                    totalPrice = totalPrice + 50;
                                  }
                                  if (sause == false) {
                                    totalPrice = totalPrice - 50;
                                  }
                                });
                              },
                              controlAffinity: ListTileControlAffinity
                                  .leading, //  <-- leading Checkbox
                            ),
                          ),
                        ],
                      ),
                      _setCartTotalAndDescriptionWidgets(
                          70), // added cart total widget
                      _grandTotal(),
                      SizedBox(
                        height: 20,
                      ),

                      _setBottomPlaceOrderWidgets()
                    ],
                  ),
                ),
              ),
            );
          });
        });
  }

  _setBottomPlaceOrderWidgets() {
    return new Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColor.themeColor,
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Expanded(
            child: new Container(
              width: MediaQuery.of(context).size.width,
              padding: new EdgeInsets.only(left: 30, right: 30),
              child: new GestureDetector(
                onTap: () {
                  (SharedManager.shared.addressId != "")
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => Checkout(
                                charge: "${this.charge}",
                                discountedPrice: "${this.totalPrice}",
                                grandTotalAmount:
                                    "${this.totalPrice + 20 + this.riderTip}",
                                tipAmount: "${this.riderTip}",
                                totalPrice: "${this.paidPrice}",
                                totalSaving: "${this.totalPrice + 20}",
                                cartItems: SharedManager.shared.cartItems,
                              )))
                      : SharedManager.shared.showAlertDialog(
                          S.current.select_address_first, context);
                },
                child: new Material(
                  color: AppColor.themeColor,
                  borderRadius: new BorderRadius.circular(5),
                  child: new Center(
                      child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      setCommonText(S.current.place_order, Colors.white, 18.0,
                          FontWeight.w500, 1),
                      SizedBox(width: 5),
                      Icon(Icons.arrow_forward, color: Colors.white, size: 20)
                    ],
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _grandTotal() {
    return new Container(
        padding: new EdgeInsets.only(left: 15, right: 15),
        color: Colors.white,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    setCommonText(S.current.item_total, Colors.grey, 14.0,
                        FontWeight.w500, 1),
                  ],
                ),
                new Row(
                  children: <Widget>[
                    new Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        setCommonText('${Currency.curr}${this.paidPrice}',
                            Colors.grey, 13.0, FontWeight.w500, 1),
                        new Container(width: 40, height: 2, color: Colors.grey),
                      ],
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    setCommonText('${Currency.curr}${this.totalPrice}',
                        Colors.grey, 13.0, FontWeight.w500, 1),
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
                setCommonText(
                    S.current.charges, Colors.grey, 13.0, FontWeight.w500, 1),
                SizedBox(
                  width: 6,
                ),
                setCommonText('${Currency.curr}20.0', Colors.red, 13.0,
                    FontWeight.w500, 1),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                setCommonText(S.current.total_amount, AppColor.themeColor, 13.0,
                    FontWeight.w500, 1),
                SizedBox(
                  width: 6,
                ),
                setCommonText('${Currency.curr}${(this.totalPrice + 20)}',
                    AppColor.themeColor, 13.0, FontWeight.w500, 1),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 5,
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                setCommonText(S.current.grand_total, Colors.black, 14.0,
                    FontWeight.w500, 1),
                SizedBox(
                  width: 6,
                ),
                setCommonText(
                    '${Currency.curr}${this.totalPrice + 20 + this.riderTip}',
                    Colors.black,
                    14.0,
                    FontWeight.w500,
                    1),
              ],
            ),
          ],
        ));
  }

  _setCartTotalAndDescriptionWidgets(double height) {
    return new Container(
      height: height,
      // color:Colors.yellow,
      child: new Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Container(
              padding: new EdgeInsets.only(left: 10, right: 10),
              // color:Colors.blue,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      setCommonText(S.current.item_total, Colors.grey, 14.0,
                          FontWeight.w500, 2),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          setCommonText('${Currency.curr}${this.paidPrice}',
                              Colors.grey, 14.0, FontWeight.w500, 1),
                          new Container(
                              width: 50, height: 2, color: Colors.grey),
                        ],
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      setCommonText('${Currency.curr}${this.totalPrice}',
                          Colors.grey, 14.0, FontWeight.w500, 1),
                    ],
                  )
                ],
              ),
            ),
          ),
          new Divider(color: Colors.grey)
        ],
      ),
    );
  }

  _setTotalPriceCount() {
    var total = 0.0;
    var totalWithDis = 0.0;
    for (var i = 0; i < SharedManager.shared.cartItems.length; i++) {
      var price = double.parse(SharedManager.shared.cartItems[i].price);
      var discount = double.parse(SharedManager.shared.cartItems[i].discount);
      var count = SharedManager.shared.cartItems[i].count;

      total = total + (count * price);
      totalWithDis = totalWithDis + (count * (price - discount));
    }

    this.paidPrice = total;
    this.totalPrice = totalWithDis;
  }

  _setAddedProductList(double height) {
    return new Container(
      height: height,
      // color: Colors.red,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: SharedManager.shared.cartItems.length,
          itemBuilder: (context, index) {
            return new Container(
              height: 100,
              child: new Column(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        new Container(
                          color: Colors.white,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                  height: 80,
                                  width: 80,
                                  color: Colors.white,
                                  padding: new EdgeInsets.all(10),
                                  child: Image(
                                    image: NetworkImage(
                                        '${SharedManager.shared.cartItems[index].image}'),
                                    fit: BoxFit.fill,
                                  )),
                              new Expanded(
                                flex: 4,
                                child: new Container(
                                  padding: new EdgeInsets.all(3),
                                  color: Colors.white,
                                  child: new Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            child: new Image(
                                              image: (SharedManager
                                                          .shared
                                                          .cartItems[index]
                                                          .type ==
                                                      "1")
                                                  ? AssetImage(
                                                      'Assets/RestaurantDetails/veg.png')
                                                  : AssetImage(
                                                      'Assets/RestaurantDetails/nonVeg.png'),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          SizedBox(width: 3),
                                          Expanded(
                                            child: setCommonText(
                                                SharedManager.shared
                                                    .cartItems[index].name,
                                                Colors.black,
                                                13.0,
                                                FontWeight.w500,
                                                1),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      setCommonText(
                                          SharedManager.shared.cartItems[index]
                                              .description,
                                          Colors.grey[600],
                                          12.0,
                                          FontWeight.w400,
                                          2),
                                      new SizedBox(
                                        height: 10,
                                      ),
                                      new Row(
                                        children: <Widget>[
                                          new Stack(
                                            alignment: Alignment.center,
                                            children: <Widget>[
                                              setCommonText(
                                                  '${Currency.curr}${SharedManager.shared.cartItems[index].price}',
                                                  Colors.deepOrangeAccent,
                                                  12.0,
                                                  FontWeight.w500,
                                                  1),
                                              new Container(
                                                height: 1,
                                                width: 45,
                                                color: Colors.black87,
                                              )
                                            ],
                                          ),
                                          new SizedBox(width: 5),
                                          setCommonText(
                                              '${Currency.curr}${(double.parse(SharedManager.shared.cartItems[index].price)) - (double.parse(SharedManager.shared.cartItems[index].discount))}',
                                              Colors.black54,
                                              12.0,
                                              FontWeight.w500,
                                              1),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                // Quantity Counter Button
                                decoration: BoxDecoration(
                                  color: Color(0xff62C45D),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Material(
                                        borderRadius: BorderRadius.circular(15),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          onTap: () {
                                            if (SharedManager.shared
                                                    .cartItems[index].count >
                                                1) {
                                              setState(() {
                                                // currently setState is not able to call in showModelBottomSheet Lack of time Did'nt review the code
                                                SharedManager
                                                    .shared
                                                    .cartItems[index]
                                                    .count = SharedManager
                                                        .shared
                                                        .cartItems[index]
                                                        .count -
                                                    1;
                                                _setTotalPriceCount(); // item price counter method
                                              });
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border:
                                                  Border.all(color: Colors.red),
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        child: Text(
                                          '${SharedManager.shared.cartItems[index].count}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Material(
                                        borderRadius: BorderRadius.circular(15),
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          onTap: () {
                                            setState(() {
                                              SharedManager
                                                  .shared
                                                  .cartItems[index]
                                                  .count = SharedManager.shared
                                                      .cartItems[index].count +
                                                  1;
                                              _setTotalPriceCount();
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border:
                                                  Border.all(color: Colors.red),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // Container(
                              //   height: 60,
                              //   width: 80,
                              //   padding: new EdgeInsets.all(3),
                              //   child: Column(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: <Widget>[
                              //       new Container(
                              //           height: 28,
                              //           // color: Colors.green,
                              //           decoration: BoxDecoration(
                              //               borderRadius:
                              //                   BorderRadius.circular(5),
                              //               border: Border.all(
                              //                 color: AppColor.themeColor,
                              //               )),
                              //           child: new Row(
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment.center,
                              //             crossAxisAlignment:
                              //                 CrossAxisAlignment.center,
                              //             children: <Widget>[
                              //               Expanded(
                              //                 flex: 1,
                              //                 child: new Container(
                              //                     color: Colors.white,
                              //                     child: new Align(
                              //                       alignment:
                              //                           Alignment.topCenter,
                              //                       child: new GestureDetector(
                              //                         onTap: () {
                              //                           if (SharedManager
                              //                                   .shared
                              //                                   .cartItems[
                              //                                       index]
                              //                                   .count >
                              //                               1) {
                              //                             setState(() {
                              //                               SharedManager
                              //                                       .shared
                              //                                       .cartItems[
                              //                                           index]
                              //                                       .count =
                              //                                   SharedManager
                              //                                           .shared
                              //                                           .cartItems[
                              //                                               index]
                              //                                           .count -
                              //                                       1;
                              //                               _setTotalPriceCount();
                              //                             });
                              //                           }
                              //                         },
                              //                         child: new Text(
                              //                           "-",
                              //                           style: new TextStyle(
                              //                               fontSize: 25,
                              //                               color: AppColor
                              //                                   .themeColor),
                              //                         ),
                              //                       ),
                              //                     )),
                              //               ),
                              //               Expanded(
                              //                 flex: 1,
                              //                 child: new Container(
                              //                   color: AppColor.themeColor,
                              //                   child: new Center(
                              //                     child: setCommonText(
                              //                         '${SharedManager.shared.cartItems[index].count}',
                              //                         Colors.white,
                              //                         14.0,
                              //                         FontWeight.w500,
                              //                         1),
                              //                   ),
                              //                 ),
                              //               ),
                              //               Expanded(
                              //                 flex: 1,
                              //                 child: new Container(
                              //                   color: Colors.white,
                              //                   child: new Center(
                              //                     child: new GestureDetector(
                              //                       onTap: () {
                              //                         setState(() {
                              //                           SharedManager
                              //                                   .shared
                              //                                   .cartItems[index]
                              //                                   .count =
                              //                               SharedManager
                              //                                       .shared
                              //                                       .cartItems[
                              //                                           index]
                              //                                       .count +
                              //                                   1;
                              //                           _setTotalPriceCount();
                              //                         });
                              //                       },
                              //                       child: new Text(
                              //                         "+",
                              //                         style: new TextStyle(
                              //                             fontSize: 20,
                              //                             color: AppColor
                              //                                 .themeColor),
                              //                       ),
                              //                     ),
                              //                   ),
                              //                 ),
                              //               ),
                              //             ],
                              //           )),
                              //       new SizedBox(
                              //         height: 5,
                              //       ),
                              //       setCommonText(
                              //           '${Currency.curr}${(((double.parse(SharedManager.shared.cartItems[index].price)) - (double.parse(SharedManager.shared.cartItems[index].discount))) * SharedManager.shared.cartItems[index].count)}',
                              //           Colors.black87,
                              //           15.0,
                              //           FontWeight.w500,
                              //           1),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                        new Positioned(
                            bottom: -15,
                            right: -10,
                            child: IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                                iconSize: 20,
                                onPressed: () {
                                  setState(() {
                                    SharedManager.shared.cartItems
                                        .removeAt(index);
                                    // _setTotalPriceCount();
                                  });
                                }))
                      ],
                    ),
                  ),
                  new Divider(
                    color: Colors.grey[300],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
