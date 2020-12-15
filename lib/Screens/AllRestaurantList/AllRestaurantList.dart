import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/AllRestaurantListBloc.dart';
import 'package:product/BlocClass/MainModelBlocClass/MealDealsItemsBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelAllRestaurantList.dart';
import 'package:product/ModelClass/ModelMealDeals.dart';
import 'package:product/Screens/BannerDetailsScreen/BannerDetailsScreen.dart';
import 'Widgets/GridviewWidget.dart';
import 'Widgets/ListviewWidgets.dart';
import 'Widgets/MealDealListviewWidget.dart';

void main() => runApp(new AllRestaurantList());

class AllRestaurantList extends StatefulWidget {
  final listTypeId;
  final title;
  final apiKey;
  final bool isMealDeal;

  AllRestaurantList(
      {Key key, this.listTypeId, this.title, this.apiKey, this.isMealDeal})
      : super(key: key);

  @override
  _AllRestaurantListState createState() => _AllRestaurantListState();
}

class _AllRestaurantListState extends State<AllRestaurantList> {
  bool isGrid = false;
  var itemCount = 0;
  BannerAd myBanner;

  _setBannerAdds() {
    MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
      keywords: <String>['food', 'Zometo', 'Food Panda', 'Uber Eats'],
      contentUrl: 'google.com',
      childDirected: false, // or MobileAdGender.female, MobileAdGender.unknown
      testDevices: <String>[], // Android emulators are considered test devices
    );

    this.myBanner = BannerAd(
      adUnitId: Keys.bannerID,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );

    FirebaseAdMob.instance.initialize(appId: Keys.admobAppID);

    myBanner
      // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 60.0,
        // Positions the banner ad 10 pixels from the center of the screen to the right
        horizontalCenterOffset: 0.0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    _setBannerAdds();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    try {
      this.myBanner.dispose();
      this.myBanner = null;
    } catch (ex) {
      print("banner dispose error");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.widget.isMealDeal
        ? mealDealsItemsBloc.fetchMealDealsItems(APIS.mealDeals)
        : allRestaurantListBloc.fetchAllRestaurant(this.widget.apiKey);
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColor.white),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: AppColor.themeColor,
        title: setCommonText(
            widget.title, AppColor.white, 20.0, FontWeight.w500, 1),
        actions: <Widget>[
          SizedBox(width: 10),
          new IconButton(
              icon: this.isGrid
                  ? Icon(Icons.grid_on, color: AppColor.white)
                  : Icon(Icons.list, color: AppColor.white),
              onPressed: () {
                setState(() {
                  if (this.isGrid) {
                    this.isGrid = false;
                  } else {
                    this.isGrid = true;
                  }
                });
              }),
        ],
      ),
      body: this.widget.isMealDeal
          ? StreamBuilder(
              stream: mealDealsItemsBloc.mealDealsItems,
              builder: (context, AsyncSnapshot<ResMealDeals> snapshot) {
                if (snapshot.hasData) {
                  final result = snapshot.data.result;
                  return new Container(
                      child: this.isGrid
                          ? GridViewMealWidget(result)
                          : ListviewMealWidget(result)
                      // child: _setGridViewItems(context,''),
                      );
                } else {
                  return new Center(
                    child: new CircularProgressIndicator(),
                  );
                }
              })
          : StreamBuilder(
              stream: allRestaurantListBloc.restaurantList,
              builder: (context, AsyncSnapshot<ResAllRestaurantList> snapshot) {
                if (snapshot.hasData) {
                  final result = snapshot.data.allRestaurants;
                  return new Container(
                    child: this.isGrid
                        ? GridViewWidgets(result)
                        : ListViewWidget(result),
                    // child: _setGridViewItems(context,''),
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

class GridViewMealWidget extends StatelessWidget {
  final List<Result> data;
  GridViewMealWidget(this.data);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return new Container(
      color: AppColor.white,
      padding: new EdgeInsets.all(5),
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 0.75,
        children: new List<Widget>.generate(data.length, (index) {
          return new GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => BannerDetailsScreen(
                        restaurantID: data[index].id,
                      )));
            },
            child: Container(
              width: width / 3,
              // height: 170,
              padding: new EdgeInsets.all(8),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    width: width / 3,
                    child: Column(
                      children: [
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                            flex: 5,
                            child: Container(
                              width: width / 3,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 1,
                                      spreadRadius: 1,
                                      color: AppColor.grey[300],
                                      offset: Offset(0, 0))
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 40),
                                    Text(
                                      data[index].name,
                                      style: TextStyle(
                                          color: AppColor.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.0,
                                          fontFamily: SharedManager
                                              .shared.fontFamilyName),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                    ),
                                    SizedBox(height: 3),
                                    Text(
                                      data[index].restaurantName,
                                      style: TextStyle(
                                          color: AppColor.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10.0,
                                          fontFamily: SharedManager
                                              .shared.fontFamilyName),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 3),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${Currency.curr}${data[index].price}',
                                          style: TextStyle(
                                              color: AppColor.black87,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 12.0,
                                              fontFamily: SharedManager
                                                  .shared.fontFamilyName),
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  Positioned(
                      top: 0,
                      child: Container(
                        height: 70,
                        // width: 70,
                        width: width / 4.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                color: AppColor.grey[300],
                                offset: Offset(0, 0))
                          ],
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(data[index].image)),
                        ),
                      )),
                ],
              ),
            ),
            // new Container(
            //   color: Colors.white,
            //   padding: new EdgeInsets.all(5),
            //   child: new Material(
            //     elevation: 1.0,
            //     borderRadius: new BorderRadius.circular(8),
            //     child: new Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Expanded(
            //             flex: 5,
            //             child: new Container(
            //               // color: Colors.red,
            //               decoration: BoxDecoration(
            //                   image: DecorationImage(
            //                       image: NetworkImage(data[index].image),
            //                       fit: BoxFit.cover),
            //                   borderRadius: BorderRadius.only(
            //                       topLeft: Radius.circular(8),
            //                       topRight: Radius.circular(8))),
            //             )),
            //         Expanded(
            //             flex: 3,
            //             child: new Container(
            //                 // color: Colors.yellow,
            //                 padding: new EdgeInsets.only(
            //                     left: 3, right: 3, bottom: 2, top: 2),
            //                 child: _setCommonWidgetsForMealList(
            //                     14.0, 11.0, 11.0, 11.0, 12, data[index]))),
            //       ],
            //     ),
            //   ),
            // ),
          );
        }),
      ),
    );
  }
}
