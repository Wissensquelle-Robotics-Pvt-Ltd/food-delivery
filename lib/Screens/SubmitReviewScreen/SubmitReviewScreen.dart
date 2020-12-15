import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/Screens/TabBarScreens/TabScreen/TabBar.dart';
import 'Widgets/RestaurantReviewRatings.dart';

class SubmitReviewScreen extends StatefulWidget {
  final String resName;
  final String resAddress;
  final String resImage;
  final String orderID;
  final String resId;
  final String driverId;

  SubmitReviewScreen(
      {this.resName,
      this.resAddress,
      this.resImage,
      this.orderID,
      this.resId,
      this.driverId});
  @override
  _SubmitReviewScreenState createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends State<SubmitReviewScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: EmptyAppBar(),
      primary: false,
      body: Container(
        color: AppColor.grey[100],
        child: ListView(
          children: <Widget>[
            _setRestaurantBannerImage(context, this.widget.resImage,
                this.widget.resName, this.widget.resAddress),
            RestaurantReviewRatings(
                this.widget.orderID, this.widget.resId, this.widget.driverId),
            // DriverReviewRating(this.widget.orderID, this.widget.driverId)
          ],
        ),
      ),
    );
  }
}

_setRestaurantBannerImage(
    BuildContext context, String image, String resName, String resAddress) {
  return new Container(
    height: 330,
    child: Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(image))),
                )),
            Expanded(
                flex: 1,
                child: Container(
                  // color: AppColor.amber,
                  padding:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      setCommonText('$resName', AppColor.black87, 18.0,
                          FontWeight.w500, 1),
                      setCommonText('$resAddress', AppColor.black54, 14.0,
                          FontWeight.w400, 2)
                    ],
                  ),
                )),
            Container(
              height: 1,
              color: AppColor.grey,
            )
          ],
        ),
        Positioned(
          top: 25,
          child: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppColor.black,
              ),
              onPressed: () {
                SharedManager.shared.currentIndex = 0;
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => TabBarScreen()),
                    ModalRoute.withName(AppRoute.tabbar));
              }),
        )
      ],
    ),
  );
}
