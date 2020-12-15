import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/Dashboard.dart';
import 'package:product/Screens/RestaurantDetails/RestaurantDetails.dart';

import 'Widget/BottomBannerWidget.dart';

void main() => runApp(new GoogleMapView());

class GoogleMapView extends StatefulWidget {
  final List<BannerRestaurent> bannerData;
  GoogleMapView({Key key, this.bannerData}) : super(key: key);
  @override
  _GoogleMapViewState createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  GoogleMapController _controller;

  List<Marker> allMarkers = [];
  PageController _pageController;
  int prevPage;

  @override
  void initState() {
    super.initState();
    for (var restaurant in this.widget.bannerData) {
      allMarkers.add(Marker(
        markerId: MarkerId(restaurant.id),
        draggable: false,
        infoWindow: InfoWindow(
            title: restaurant.name,
            snippet: restaurant.address,
            onTap: () {
              Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                  builder: (context) => RestaurantDetails(
                        restaurantID: restaurant.id,
                      )));
            }),
        position: LatLng(double.parse(restaurant.latitude),
            double.parse(restaurant.longitude)),
      ));
      _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
        ..addListener(_onScroll);
    }
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
      color: Colors.red,
      child: new Stack(
        children: <Widget>[
          new Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(SharedManager.shared.latitude,
                      SharedManager.shared.longitude),
                  zoom: 14.0),
              markers: Set.from(allMarkers),
              onMapCreated: mapCreated,
            ),
          ),
          Positioned(
            bottom: 20.0,
            child: Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                controller: _pageController,
                itemCount: this.widget.bannerData.length,
                itemBuilder: (BuildContext context, int index) {
                  return BottomBannerWidget(
                    this.widget.bannerData,
                    _pageController,
                    index,
                  );
                },
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 5,
            child: new IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColor.themeColor,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
    ));
  }

  void mapCreated(controller) {
    setState(() {
      controller = _controller;
    });
  }
}
