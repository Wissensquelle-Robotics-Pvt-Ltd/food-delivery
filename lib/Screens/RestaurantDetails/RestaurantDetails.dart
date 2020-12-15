import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:product/BlocClass/MainModelBlocClass/RestaurantDetails.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelRestaurantDetails.dart';
import 'package:product/Screens/BannerDetailsScreen/Widgets/ReviewWidgets/ReviewWidgets.dart';
import 'package:product/Screens/Cart/Cart.dart';
import 'package:product/Screens/RestaurantItemList/RestaurantItemList.dart';
import 'package:product/Screens/ReviewListScreen/ReviewListScreen.dart';
import 'package:product/generated/i18n.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new RestaurantDetails());

class RestaurantDetails extends StatefulWidget {
  final restaurantID;
  RestaurantDetails({Key key, this.restaurantID}) : super(key: key);

  @override
  _RestaurantDetailsState createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  ScrollController _controller = new ScrollController();

  var itemCount = 0;
  var totlaPrice = 0.0;
  bool isFirst = false;
  bool isDataLoad = false;
  var result = ResDetails();
  InterstitialAd myInterstitial;

  _setImageStackView(double width, String bannerImage, String resName) {
    return new Stack(
      children: <Widget>[
        new Hero(
          tag: 'popular0',
          child: new Container(
            width: width,
            height: width - 150,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(bannerImage), fit: BoxFit.fill)),
          ),
        ),
        Container(
          color: AppColor.black.withOpacity(0.4),
          height: width - 150,
        ),
        new Container(
          padding: new EdgeInsets.only(top: 25, bottom: 5),
          width: width,
          height: width - 150,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new IconButton(
                icon: new Icon(Icons.arrow_back_ios, color: AppColor.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new Container(
                padding: new EdgeInsets.only(left: 15, right: 0),
                width: width,
                height: 80,
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      flex: 2,
                      child: new Container(
                        // color: AppColor.red,
                        child: setCommonText('$resName',
                            AppColor.amber.shade300, 18.0, FontWeight.bold, 2),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: new Container(
                          // color: AppColor.white,
                          child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Icon(
                            Icons.place,
                            color: AppColor.amber.shade300,
                          ),
                          setCommonText(
                              S.current.view_on_map,
                              AppColor.amber.shade300,
                              12.0,
                              FontWeight.bold,
                              2),
                        ],
                      )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _calling() async {
    final url = 'tel:${result.phone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _setSocialWidgets(double width, String review, String resName) {
    return new Container(
      width: width,
      height: 80,
      // color: AppColor.red,
      color: AppColor.white,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              // _calling();
            },
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.share,
                  color: AppColor.black,
                ),
                setCommonText(
                    S.current.share, AppColor.black, 14.0, FontWeight.w600, 1),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          new GestureDetector(
            onTap: () {
              _calling();
            },
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.phone,
                  color: AppColor.black,
                ),
                setCommonText(S.current.contact, AppColor.black, 14.0,
                    FontWeight.w600, 1),
              ],
            ),
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
                setCommonText('${S.current.reviews}', AppColor.black, 13.0,
                    FontWeight.w600, 1)
              ],
            ),
          )
        ],
      ),
    );
  }

  _setRestaurantDetails(List<Categories> categories) {
    return new Container(
        // height: 150,
        color: AppColor.white,
        padding: new EdgeInsets.only(left: 15, right: 15, top: 5),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            setCommonText(S.current.res_recommenditions, AppColor.black, 15.0,
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
      // color: AppColor.red,
      color: AppColor.white,
      padding: new EdgeInsets.only(top: 3, left: 15, right: 15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          setCommonText(S.current.res_address, AppColor.grey[500], 15.0,
              FontWeight.w500, 1),
          SizedBox(
            height: 5,
          ),
          new Row(
            children: <Widget>[
              Expanded(
                flex: 4,
                child: new Container(
                  // color: AppColor.white,
                  child: setCommonText(
                      address, AppColor.black, 13.0, FontWeight.w400, 2),
                ),
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
              setCommonText(S.current.delivery_in_minutes, AppColor.orange,
                  14.0, FontWeight.w500, 1),
              SizedBox(
                height: 5,
              ),
              setCommonText('$discount% ${S.current.all_offer}', AppColor.teal,
                  12.0, FontWeight.w600, 1),
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

  _setDynamicCategory(int subCatCount, dynamic data, double width,
      List<Categories> categories) {
    return Container(
      height: (categories.length == 1)
          ? (500 * subCatCount).toDouble()
          : (calculateTotalHeight(categories)),
      color: AppColor.white,
      child: new ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: subCatCount,
        itemBuilder: (context, index) {
          return _checkStatus(
              categories[index].isGrid,
              index,
              width,
              categories[index].subcategories,
              categories[index].categoryName,
              categories);
        },
      ),
    );
  }

  double calculateTotalHeight(List<Categories> categories) {
    var height = 0.0;
    for (var category in categories) {
      height = height +
          ((category.subcategories.length >= 3)
              ? ((3 * 110) + (categories.length * 8.0))
              : (category.subcategories.length * 110) +
                  (categories.length * 8.0));
    }
    // print("Final Height is:$height");
    return height;
  }

  _checkStatus(bool status, int index, double width, List<Subcategories> data,
      String subCatName, List<Categories> categories) {
    return _setSubCategoryList((160.0 * ((data.length >= 3) ? 3 : data.length)),
        subCatName, index, data, categories);
  }

  _setSubCategoryList(double height, String subCategoryTitle, int index,
      List<Subcategories> subcategories, List<Categories> categories) {
    return new Container(
      // color: Colors.pink,
      padding: new EdgeInsets.only(left: 15, right: 15),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            children: <Widget>[
              new Container(
                child: new Text(
                  subCategoryTitle,
                  style: new TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColor.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              new Container(
                height: 5,
                // color: AppColor.red,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    subcategories.length > 3
                        ? new GestureDetector(
                            onTap: () async {
                              if (result.isAvailable == '1') {
                                final status = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RestaurantItemList(
                                              itemList: subcategories,
                                              title: categories[index]
                                                  .categoryName,
                                            )));
                                if (status) {
                                  setState(() {
                                    this.itemCount = 0;
                                    this.totlaPrice = 0.0;
                                    SharedManager.shared.cartItems = [];
                                    // this.itemCount =  _setItemCount(categories);
                                    for (var category in categories) {
                                      for (var subCat
                                          in category.subcategories) {
                                        if (subCat.isAdded) {
                                          SharedManager.shared.cartItems
                                              .add(subCat);
                                        }
                                      }
                                    }

                                    for (var item
                                        in SharedManager.shared.cartItems) {
                                      this.itemCount = this.itemCount + 1;
                                      this.totlaPrice = this.totlaPrice +
                                          (double.parse(item.price) -
                                              double.parse(item.discount));
                                    }
                                  });
                                }
                              } else {
                                commonRestaurantCloseAlert(context);
                              }
                            },
                            child: new Container(
                                child: setCommonText(
                                    S.current.seeAll,
                                    AppColor.themeColor,
                                    15.0,
                                    FontWeight.w400,
                                    1)),
                          )
                        : new Text('')
                  ],
                ),
              ),
            ],
          ),
          new Container(
            height: (subcategories.length > 3)
                ? 500.0 - 80.0
                : (subcategories.length * 115.0),
            // color: AppColor.black,
            child: new ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              itemCount: subcategories.length > 3 ? 3 : subcategories.length,
              itemBuilder: (context, row) {
                return new Container(
                  padding: new EdgeInsets.all(5),
                  child: new Material(
                    color: AppColor.white,
                    elevation: 3.0,
                    borderRadius: new BorderRadius.circular(5),
                    child: new Row(
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: new Container(
                                height: 80,
                                width: 85,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          subcategories[row].image),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        ),
                        new Expanded(
                          flex: 2,
                          child: new Container(
                            padding: new EdgeInsets.only(top: 10, right: 10),
                            color: AppColor.white,
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                new Row(
                                  children: <Widget>[
                                    new Container(
                                      padding: new EdgeInsets.all(5),
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: (subcategories[row].type ==
                                                    "1")
                                                ? AssetImage(
                                                    'Assets/RestaurantDetails/veg.png')
                                                : AssetImage(
                                                    'Assets/RestaurantDetails/nonVeg.png'),
                                            fit: BoxFit.cover),
                                        borderRadius: new BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            bottomLeft: Radius.circular(5)),
                                      ),
                                    ),
                                    SizedBox(width: 2),
                                    Expanded(
                                        flex: 3,
                                        child: setCommonText(
                                            subcategories[row].name,
                                            AppColor.black,
                                            13.0,
                                            FontWeight.w600,
                                            2)),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                setCommonText(subcategories[row].description,
                                    AppColor.grey, 12.0, FontWeight.w400, 2),
                                SizedBox(height: 4),
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Row(
                                      children: <Widget>[
                                        new Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            setCommonText(
                                                '${Currency.curr}${subcategories[row].price}',
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
                                          width: 5,
                                        ),
                                        setCommonText(
                                            '${Currency.curr}${double.parse(subcategories[row].price) - double.parse(subcategories[row].discount)}',
                                            AppColor.black,
                                            12.0,
                                            FontWeight.w700,
                                            1),
                                      ],
                                    ),
                                    new Container(
                                      height: 25,
                                      // width: 50,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: subcategories[row].isAdded
                                                  ? AppColor.red
                                                  : AppColor.themeColor)),
                                      padding: new EdgeInsets.all(2),
                                      child: InkWell(
                                        onTap: () {
                                          if (subcategories[row].isAvailable ==
                                              '1') {
                                            setState(() {
                                              if (subcategories[row].isAdded) {
                                                subcategories[row].isAdded =
                                                    false;
                                              } else {
                                                subcategories[row].isAdded =
                                                    true;
                                              }
                                              this.itemCount =
                                                  _setItemCount(categories);
                                            });
                                          } else {
                                            commonItemOutofStockAlert(context);
                                          }
                                        },
                                        child: new Material(
                                          color: AppColor.white,
                                          borderRadius:
                                              new BorderRadius.circular(10),
                                          child: new Center(
                                            child: subcategories[row].isAdded
                                                ? setCommonText(
                                                    '  ${S.current.added}  ',
                                                    AppColor.red,
                                                    10.0,
                                                    FontWeight.w500,
                                                    1)
                                                : setCommonText(
                                                    '  ${S.current.add_plus}  ',
                                                    AppColor.themeColor,
                                                    10.0,
                                                    FontWeight.w500,
                                                    1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 2,
                                ),
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
          )
        ],
      ),
    );
  }

  void _goToElement(int index) {
    _controller.animateTo(
        (_getHeight(index +
            1)), // 100 is the height of container and index of 6th element is 5
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut);
  }

  double _getHeight(int index) {
    var height = 0;
    for (var i = 0; i < index; i++) {
      height = height +
          ((this.result.categories[i].isGrid) ? 180 : 380) *
              ((this.result.categories[i].isGrid)
                  ? ((this.result.categories[i].subcategories.length <= 2)
                      ? 1
                      : 2)
                  : ((this.result.categories[i].subcategories.length <= 4)
                      ? 1
                      : 1));
    }
    return height.toDouble();
  }

  int _setItemCount(List<Categories> categories) {
    var count = 0;
    var price = 0.0;
    SharedManager.shared.cartItems = [];
    for (int i = 0; i < categories.length; i++) {
      List<Subcategories> subList = categories[i].subcategories;
      for (int j = 0; j < subList.length; j++) {
        if (subList[j].isAdded) {
          count = count + 1;
          price = price +
              (double.parse(subList[j].price) -
                  double.parse(subList[j].discount));
          SharedManager.shared.cartItems.add(subList[j]);
        }
      }
    }
    this.totlaPrice = price;
    return count;
  }

  List<SpeedDialChild> setSpeedDialChild(List<Categories> categories) {
    List<SpeedDialChild> listSpeedDial = [];
    for (var i = 0; i < categories.length; i++) {
      final dial = SpeedDialChild(
          child: Icon(
            Icons.fastfood,
            color: AppColor.themeColor,
          ),
          backgroundColor: AppColor.white,
          label: categories[i].categoryName,
          labelStyle: TextStyle(
            fontSize: 16.0,
            fontFamily: SharedManager.shared.fontFamilyName,
          ),
          onTap: () => _goToElement(i));
      listSpeedDial.add(dial);
    }
    return listSpeedDial;
  }

  @override
  void initState() {
    // try {
    //   SharedManager.shared.myBanner.dispose();
    //   SharedManager.shared.myBanner = null;
    // } catch (ex) {
    //   print("banner dispose error");
    // }
    _setIntestatialAdds();
    resDetailsBloc.fetchRestaurantDetails(widget.restaurantID, APIS.resDetails);
    super.initState();
    SharedManager.shared.restaurantID = this.widget.restaurantID;
  }

  @override
  void dispose() {
    // try {
    //   this.myInterstitial.dispose();
    //   this.myInterstitial = null;
    // } catch (ex) {
    //   print("banner dispose error");
    // }
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
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      primary: false,
      appBar: EmptyAppBar(),
      body: StreamBuilder(
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
              } else {}
              return Column(
                children: <Widget>[
                  Expanded(
                    flex: 12,
                    child: Container(
                      color: AppColor.white,
                      child: new ListView(
                        controller: _controller,
                        children: <Widget>[
                          _setImageStackView(
                              width, result.bannerImage, result.name),
                          _setSocialWidgets(
                              width,
                              (result.avgReview != null)
                                  ? result.avgReview
                                  : '0.0',
                              result.name),
                          _setRestaurantDetails(result.categories),
                          _setAddressWidgets(result.address, result.discount,
                              result.openingTime, result.closingTime),
                          _setDynamicCategory(result.categories.length,
                              result.categories, width, result.categories),
                          (result.reviews.length > 0)
                              ? ReviewWidgets(result.reviews,
                                  this.widget.restaurantID, result.name)
                              : Text('')
                        ],
                      ),
                    ),
                  ),
                  (this.itemCount > 0)
                      ? Container(
                          padding:
                              new EdgeInsets.only(left: 15, right: 90, top: 5),
                          color: AppColor.white,
                          width: width,
                          height: 50,
                          child: new Material(
                              color: AppColor.themeColor,
                              borderRadius: new BorderRadius.circular(30),
                              child: new Container(
                                padding:
                                    new EdgeInsets.only(left: 12, right: 15),
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        setCommonText(
                                            '${this.itemCount} ${S.current.items}',
                                            AppColor.white,
                                            12.0,
                                            FontWeight.w600,
                                            1),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        setCommonText(
                                            '${S.current.totals} ${Currency.curr}${this.totlaPrice}',
                                            AppColor.white,
                                            12.0,
                                            FontWeight.w600,
                                            1),
                                      ],
                                    ),
                                    new Row(
                                      children: <Widget>[
                                        new GestureDetector(
                                          onTap: () {
                                            if (result.isAvailable == '1') {
                                              List<Subcategories> listData = [];
                                              for (int i = 0;
                                                  i <
                                                      this
                                                          .result
                                                          .categories
                                                          .length;
                                                  i++) {
                                                List<Subcategories> subList =
                                                    this
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
                                              SharedManager.shared.cartItems =
                                                  listData;
                                              SharedManager.shared.isFromTab =
                                                  false;
                                              print("Cart item");
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CartApp()));
                                            } else {
                                              commonRestaurantCloseAlert(
                                                  context);
                                            }
                                          },
                                          child: setCommonText(
                                              S.current.view_cart,
                                              AppColor.white,
                                              13.0,
                                              FontWeight.w600,
                                              1),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        new Icon(Icons.arrow_forward,
                                            color: AppColor.white, size: 18)
                                      ],
                                    )
                                  ],
                                ),
                              )))
                      : new Container(),
                  SizedBox(
                    height: 15,
                  )
                ],
              );
            } else {
              return new Center(
                child: new CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: SpeedDial(
          marginRight: 18,
          marginBottom: 20,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 20.0),
          // this is ignored if animatedIcon is non null
          visible: true,
          // If true user is forced to close dial manually
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: AppColor.black,
          overlayOpacity: 0.5,
          onOpen: () {
            print('DIAL OPEN');
            if (isFirst) {
              setState(() {});
            }
          },
          onClose: () => print('DIAL CLOSED'),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: AppColor.themeColor,
          foregroundColor: AppColor.white,
          elevation: 8.0,
          children: setSpeedDialChild(
              (result.categories == null) ? [] : result.categories)),
    );
  }
}

/*

Expanded(
                                      flex: 1,
                                      child: new Container(
                                        height: 30,
                                        child: new Material(
                                          color: AppColor.grey[600],
                                          borderRadius:
                                              new BorderRadius.circular(10),
                                          child: new Container(
                                            padding: new EdgeInsets.all(2),
                                            child: InkWell(
                                              onTap: () {
                                                if (subcategories[row]
                                                        .isAvailable ==
                                                    '1') {
                                                  setState(() {
                                                    if (subcategories[row]
                                                        .isAdded) {
                                                      subcategories[row]
                                                          .isAdded = false;
                                                    } else {
                                                      subcategories[row]
                                                          .isAdded = true;
                                                    }
                                                    this.itemCount =
                                                        _setItemCount(
                                                            categories);
                                                  });
                                                } else {
                                                  commonItemOutofStockAlert(
                                                      context);
                                                }
                                              },
                                              child: new Material(
                                                color: AppColor.white,
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        10),
                                                child: new Center(
                                                  child: subcategories[row]
                                                          .isAdded
                                                      ? setCommonText(
                                                          S.current.added,
                                                          AppColor.red,
                                                          10.0,
                                                          FontWeight.w700,
                                                          1)
                                                      : setCommonText(
                                                          S.current.add_plus,
                                                          AppColor.themeColor,
                                                          10.0,
                                                          FontWeight.w700,
                                                          1),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
*/
