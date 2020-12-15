import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:product/BlocClass/MainModelBlocClass/DashboadBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/LocationManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/Dashboard.dart';
import 'package:product/Screens/Cart/Cart.dart';
import 'package:product/Screens/TabBarScreens/TabScreen/TabBar.dart';
import 'package:product/generated/i18n.dart';
import 'Widgets/BannerBottom.dart';
import 'Widgets/BannerFirst.dart';
import 'Widgets/BannerRestaurants.dart';
import 'Widgets/BannerSecond.dart';
import 'Widgets/CategoryList.dart';
import 'Widgets/MealDealItems.dart';
import 'Widgets/MostPopularResWidgets.dart';
import 'Widgets/TopRestaurantWidget.dart';

void main() => runApp(new DashboardApp());

class DashboardApp extends StatefulWidget {
  DashboardApp({Key key, isOrderDone}) : super(key: key);

  @override
  _DashboardAppState createState() => _DashboardAppState();
}

class _DashboardAppState extends State<DashboardApp>
    with SingleTickerProviderStateMixin {
  var localAddress = "";
  var isOrderStates = "no";
  AnimationController _animationController;
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Keys.kGoogleApiKey);
  bool isSearchAddress = false;
  LatLng currentLocation;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final List discountList = [
    {
      'discount': '14',
      'discountName': 'Foodis Friday',
      'velidity': '20th july 2020',
      'code': 'FooDy2020',
      'bannerImage': 'Assets/RestaurantDetails/RestaurantApp.jpg'
    },
    {
      'discount': '18',
      'discountName': 'July Special',
      'velidity': '18th july 2020',
      'code': 'July2020',
      'bannerImage': 'Assets/food.jpeg'
    },
    {
      'discount': '20',
      'discountName': 'Birthday Offer',
      'velidity': '22th july 2020',
      'code': 'HDOffer',
      'bannerImage': 'Assets/res.jpeg'
    },
    {
      'discount': '25',
      'discountName': 'Junmasti Special',
      'velidity': '25th july 2020',
      'code': 'KANHA2020',
      'bannerImage': 'Assets/RestaurantDetails/RestaurantApp.jpg'
    },
  ];

  // final List categoryList = [
  //   {
  //     'title': 'Pizza',
  //     'bannerImage': 'Assets/RestaurantDetails/RestaurantApp.jpg'
  //   },
  //   {'title': 'Italiyan', 'bannerImage': 'Assets/food.jpeg'},
  //   {'title': 'Maxican', 'bannerImage': 'Assets/res.jpeg'},
  //   {
  //     'title': 'South Indian',
  //     'bannerImage': 'Assets/RestaurantDetails/RestaurantApp.jpg'
  //   },
  // ];

// @override
  void initState() {
    // super.initState();
    LocationManager.shared.getCurrentLocation();
    dashboardBloc.fetchDashboardData(APIS.dashBoard, []);
    _setStatus();
    // SharedManager.shared.setBannerAdds();

    super.initState();
  }

  @override
  void dispose() {
    // try {
    //   SharedManager.shared.myBanner.dispose();
    //   SharedManager.shared.myBanner = null;
    // } catch (ex) {
    //   print("banner dispose error");
    // }
    super.dispose();
  }

  _setStatus() async {
    final status = await SharedManager.shared.isLoggedIn();
    final userId = await SharedManager.shared.userId();
    // final token = await SharedManager.shared.getPushToken();

    print("Login Status:$status");
    print("User ID is:$userId");
    SharedManager.shared.isLoggedIN = status;
    SharedManager.shared.userID = userId;
    // SharedManager.shared.token = token;

    if (!isSearchAddress) {
      _getAddressFromCurrentLocation(
          await SharedManager.shared.getLocationCoordinate());
    } else {
      _getAddressFromCurrentLocation(currentLocation);
    }

    this.isOrderStates = await SharedManager.shared.getStrng("isOrderDone");
    if (this.isOrderStates == "yes") {
      _animationController =
          new AnimationController(vsync: this, duration: Duration(seconds: 2));
      _animationController.repeat();
    }
  }

  _getAddressFromCurrentLocation(LatLng coordinate) async {
    // var coordinate = await SharedManager.shared.getLocationCoordinate();
    print("Stored Location:$coordinate");
    if (this.isSearchAddress) {
      _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: setCommonText(
              '${S.current.pleaseWaitCollectiingNewRestaurants}',
              AppColor.white,
              17.0,
              FontWeight.w500,
              2)));
    }

    SharedManager.shared.latitude = coordinate.latitude;
    SharedManager.shared.longitude = coordinate.longitude;

    final coordinates =
        new Coordinates(coordinate.latitude, coordinate.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print('${first.addressLine}, ${first.featureName}');
    setState(() {
      if (first.addressLine != null) {
        this.localAddress = first.addressLine;
      }
      if (first.featureName != null) {
        this.localAddress = this.localAddress + " " + first.featureName;
      }
      SharedManager.shared.address = localAddress;
      print("Final Address:---->$localAddress");
    });
  }

  Future<Null> displayPrediction(var p) async {
    if (p != null) {
      var detail = await _places.getDetailsByPlaceId(p.placeId);

      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      setState(() {
        this.isSearchAddress = true;
        this.currentLocation = LatLng(lat, lng);
        _getAddressFromCurrentLocation(currentLocation);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return new Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          elevation: 0.0,
          title: Stack(
            children: <Widget>[
              new Container(
                width: width,
                height: 50,
                color: AppColor.white,
                child: new InkWell(
                  onTap: () async {
                    Prediction p = await PlacesAutocomplete.show(
                        context: context, apiKey: Keys.kGoogleApiKey);
                    this.displayPrediction(p);
                  },
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Expanded(
                        child: Text(
                          SharedManager.shared.address,
                          style: TextStyle(
                              color: AppColor.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              fontFamily: SharedManager.shared.fontFamilyName),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                        //  setCommonText(SharedManager.shared.address,
                        //     AppColor.black, 16.0, FontWeight.w500, 2),
                      ),
                      (localAddress != "")
                          ? Icon(
                              Icons.arrow_drop_down,
                              color: AppColor.black87,
                              size: 30,
                            )
                          : new Text("")
                    ],
                  ),
                ),
              )
            ],
          ),
          backgroundColor: AppColor.white,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                    height: 50,
                    width: width - 50,
                    color: AppColor.white,
                    padding: new EdgeInsets.only(left: 20, right: 5),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                            height: 40,
                            width: width,
                            decoration: new BoxDecoration(
                                border: new Border.all(color: AppColor.black38),
                                borderRadius: new BorderRadius.circular(8)),
                            child: new TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: new Icon(
                                  Icons.search,
                                  color: AppColor.black38,
                                ),
                                hintText: S.current.search,
                                hintStyle: new TextStyle(
                                    color: AppColor.black38, fontSize: 16),
                              ),
                              style: new TextStyle(
                                  color: AppColor.black38, fontSize: 16),
                            )),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )),
                Column(
                  children: <Widget>[
                    SizedBox(height: 1),
                    new Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1.0, color: AppColor.black38),
                            borderRadius: BorderRadius.circular(5)),
                        child: new Stack(
                          children: <Widget>[
                            new IconButton(
                                icon: Icon(Icons.shopping_cart, size: 22),
                                onPressed: () {}),
                            Positioned(
                                top: 3,
                                right: 3,
                                child: new Container(
                                  height: 14,
                                  width: 14,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(7),
                                      color: AppColor.themeColor),
                                  child: new Center(
                                    child: setCommonText(
                                        '${SharedManager.shared.cartItems.length}',
                                        AppColor.white,
                                        14.0,
                                        FontWeight.w500,
                                        1),
                                  ),
                                )),
                            new GestureDetector(
                              onTap: () {
                                SharedManager.shared.isFromTab = false;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CartApp()));
                              },
                              child: new Container(
                                height: 40,
                                width: 40,
                                color: AppColor.white.withOpacity(0),
                              ),
                            )
                          ],
                        )),
                  ],
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        ),
        body: new Stack(
          children: <Widget>[
            StreamBuilder(
              stream: dashboardBloc.dashboardData,
              builder: (context, AsyncSnapshot<Dashboard> snapshot) {
                if (snapshot.hasData) {
                  // dashboardBloc.dispose();
                  var result = snapshot.data.result;
                  return new Container(
                    color: AppColor.white,
                    child: new ListView(
                      children: <Widget>[
                        BannerRestaurants(width, result.topRestaurents),
                        SizedBox(height: 5),
                        CategoryList(result.categories),
                        _setCommonDivider(),
                        PopularRestaurants(width, result.topRestaurents),
                        _setCommonDivider(),
                        SizedBox(height: 5),
                        (result.couponCodes.length > 0)
                            ? _setTodaysOfferWidgets(
                                context, result.couponCodes)
                            : SizedBox(
                                height: 0,
                              ),
                        (discountList.length > 0)
                            ? SizedBox(
                                height: 15,
                              )
                            : SizedBox(
                                height: 0,
                              ),
                        SizedBox(height: 5),
                        _setCommonDivider(),
                        SizedBox(height: 5),
                        BannerFirst(),
                        SizedBox(height: 5),
                        MealDealsItems(width, result.mealDeal),
                        // _setCommonDivider(),
                        SizedBox(height: 5),
                        BannerSecond(),
                        SizedBox(height: 5),
                        TopRestaurants(width, result.topRestaurents),
                        BannerBottom()
                      ],
                    ),
                  );
                } else {
                  return Container(
                    color: AppColor.white,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            (this.isOrderStates == "yes")
                ? new Positioned(
                    bottom: 0,
                    left: 0,
                    child: new Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      color: AppColor.themeColor,
                      child: new Center(
                        child: FadeTransition(
                          opacity: _animationController,
                          child: MaterialButton(
                              onPressed: () async {
                                await SharedManager.shared
                                    .storeString("no", "isOrderDone");
                                SharedManager.shared.currentIndex = 0;
                                Navigator.of(context, rootNavigator: true)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TabBarScreen()),
                                        ModalRoute.withName(AppRoute.tabbar));
                                // var status = await Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //         builder: (context) => OrderTracking()));
                                // if (status) {
                                //   await SharedManager.shared
                                //       .storeString("no", "isOrderDone");
                                //   setState(() {
                                //     _setStatus();
                                //   });
                                // }
                              },
                              child: setCommonText(S.current.orderPlaced,
                                  AppColor.white, 15.0, FontWeight.w600, 1),
                              color: AppColor.themeColor,
                              elevation: 0),
                        ),
                      ),
                    ))
                : new Container(),
          ],
        ),
        resizeToAvoidBottomPadding: false);
  }
}

_setCommonDivider() {
  return Container(color: AppColor.grey[100], height: 8);
}

_setTodaysOfferWidgets(BuildContext context, List<CouponCodes> discountList) {
  return new Container(
    height: 90,
    // color: AppColor.red,
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              setCommonText('${S.current.todaysOffers}', AppColor.black, 15.0,
                  FontWeight.w500, 1),
              // InkWell(
              //   onTap: () {},
              //   child: setCommonText(S.current.see_all, AppColor.themeColor, 16.0,
              //       FontWeight.w600, 1),
              // )
            ],
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
            child: Container(
          // color: AppColor.red[100],
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              // itemCount: discountList.length,
              itemCount: 1,
              itemBuilder: (context, index) {
                return new Container(
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: new EdgeInsets.only(
                        left: 4, right: 4, bottom: 0, top: 0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColor.grey[300]),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(width: 8),
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('Assets/offer.png'))),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                              child: Container(
                                  child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (discountList[index].discountType == '1')
                                    ? 'Flat ${discountList[index].discount}% off'
                                    : 'Upto ${discountList[index].discount}% off',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.black87,
                                    fontFamily:
                                        SharedManager.shared.fontFamilyName),
                                textAlign: TextAlign.start,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Container(
                                height: 26,
                                child: setCommonText(
                                    ' ${discountList[index].couponCode} ',
                                    AppColor.red,
                                    12.0,
                                    FontWeight.bold,
                                    1),
                              )
                            ],
                          ))),
                        ],
                      ),
                    )
                    //  Stack(
                    //   children: <Widget>[
                    //     Container(
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(5),
                    //           image: DecorationImage(
                    //               fit: BoxFit.cover,
                    //               image: NetworkImage(
                    //                   '${discountList[index].image}'))),
                    //     ),
                    //     Container(
                    //       decoration: BoxDecoration(
                    //         color: AppColor.black.withOpacity(0.7),
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //       child: Row(
                    //         children: <Widget>[
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           Expanded(
                    //               flex: 2,
                    //               child: Container(
                    //                 child: Column(
                    //                   children: <Widget>[
                    //                     SizedBox(height: 12),
                    //                     setCommonText(
                    //                         '${discountList[index].discount}%',
                    //                         AppColor.white,
                    //                         22.0,
                    //                         FontWeight.bold,
                    //                         1),
                    //                     setCommonText(
                    //                         '${S.current.discount}',
                    //                         AppColor.white,
                    //                         15.0,
                    //                         FontWeight.bold,
                    //                         1),
                    //                     SizedBox(
                    //                       height: 2,
                    //                     ),
                    //                     setCommonText(
                    //                         '${S.current.useCode}',
                    //                         AppColor.themeColor,
                    //                         14.0,
                    //                         FontWeight.w600,
                    //                         1),
                    //                     SizedBox(
                    //                       height: 5,
                    //                     ),
                    //       Container(
                    //         height: 26,
                    //         decoration: BoxDecoration(
                    //             color: AppColor.white,
                    //             borderRadius:
                    //                 BorderRadius.circular(5)),
                    //         child: Center(
                    //           child: setCommonText(
                    //               ' ${discountList[index].couponCode} ',
                    //               AppColor.red,
                    //               13.0,
                    //               FontWeight.w500,
                    //               1),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           Expanded(
                    //             child: Container(
                    //               child: Column(
                    //                 children: <Widget>[
                    //                   SizedBox(height: 12),
                    //                   Text(
                    //                     '${discountList[index].description}',
                    //                     style: TextStyle(
                    //                         fontSize: 12,
                    //                         fontWeight: FontWeight.w500,
                    //                         color: AppColor.white,
                    //                         fontFamily: SharedManager
                    //                             .shared.fontFamilyName),
                    //                     textAlign: TextAlign.center,
                    //                     maxLines: 4,
                    //                     overflow: TextOverflow.ellipsis,
                    //                   ),
                    //                   SizedBox(
                    //                     height: 3,
                    //                   ),
                    //                   setCommonText('${S.current.validTill}',
                    //                       AppColor.red, 14.0, FontWeight.w400, 1),
                    //                   setCommonText(
                    //                       '${discountList[index].endDate}',
                    //                       AppColor.amber,
                    //                       14.0,
                    //                       FontWeight.w600,
                    //                       1),
                    //                 ],
                    //               ),
                    //             ),
                    //             flex: 3,
                    //           ),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // ),
                    );
              }),
        ))
      ],
    ),
  );
}
