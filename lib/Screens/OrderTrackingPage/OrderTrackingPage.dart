import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/generated/i18n.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderTrackingPage extends StatelessWidget {
  final String latitude;
  final String longitude;
  final String driverId;

  OrderTrackingPage({this.latitude, this.longitude, this.driverId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapSample(latitude, longitude, driverId),
    );
  }
}

class MapSample extends StatefulWidget {
  final String latitude;
  final String longitude;
  final String driverId;

  MapSample(this.latitude, this.longitude, this.driverId);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  bool loading = true;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  Set<Polyline> get polyLines => _polyLines;
  Completer<GoogleMapController> _controller = Completer();
  static LatLng latLng;
  LocationData currentLocation;
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor destinationLocationIcon;
  Timer timer;

  var count = 0;
  //this is restaurant address
  double lat = 23.031581;
  double lng = 72.510317;
  var time = "12kms";
  var distance = "19min";

  @override
  void initState() {
    setState(() {
      // getLocation();
      latLng = LatLng(double.parse(this.widget.latitude),
          double.parse(this.widget.longitude));
      _onAddMarkerButtonPressed();
      sendRequest();
    });
    _updateDriverLocation();
    _setupTimer();
    super.initState();
  }

  @override
  void dispose() {
    try {
      this.timer.cancel();
    } catch (error) {
      print(error);
    }
    super.dispose();
  }

  _setupTimer() {
    this.timer = Timer.periodic(
        Duration(seconds: SharedManager.shared.updateDriver), (timer) async {
      _updateDriverLocation();
    });
  }

  _updateDriverLocation() async {
    Requestmanager manager = Requestmanager();
    await manager
        .fetchDriverCurrentLocation(this.widget.driverId)
        .then((value) {
      if (value.code == 1) {
        print(
            "Updated location is:${value.result.latitude},${value.result.longitude}");
        setState(() {
          this.lat = double.parse(value.result.latitude);
          this.lng = double.parse(value.result.longitude);
          sendRequest();
        });
      }
    });
  }

  void _onAddMarkerButtonPressed() {
    setState(() {
      setCustomMapPin();
      setDriverMapPin();
      // _modalBottomSheetMenu();
      _markers.add(Marker(
          markerId: MarkerId("111"),
          position: latLng,
          icon: destinationLocationIcon));
    });
  }

  _calling() async {
    final url = 'tel:${SharedManager.shared.driverPhone}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 150,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Container(
                          // color: AppColor.red,
                          child: _setCommonView(
                              '${S.current.distance}', '${this.distance}'),
                        )),
                        Container(
                          height: 30,
                          width: 1,
                          color: AppColor.grey,
                        ),
                        Expanded(
                            child: Container(
                          child: _setCommonView(
                              '${S.current.time}', '${this.time}'),
                        )),
                        Container(
                          height: 30,
                          width: 1,
                          color: AppColor.grey,
                        ),
                        Expanded(
                            child: Container(
                          child: Center(
                            child: IconButton(
                                icon: Icon(
                                  Icons.call,
                                  color: AppColor.black,
                                ),
                                onPressed: () {
                                  _calling();
                                }),
                          ),
                        )),
                      ],
                    ),
                  ),
                  flex: 2,
                ),
                Divider(),
                Expanded(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Center(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    '${SharedManager.shared.driverImage}'),
                              ),
                            ),
                          ),
                          flex: 2,
                        ),
                        Container(
                          height: 50,
                          width: 1,
                          color: AppColor.grey,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                setCommonText(
                                    '${SharedManager.shared.driverName}',
                                    AppColor.black54,
                                    14.0,
                                    FontWeight.w500,
                                    1),
                                Row(
                                  children: <Widget>[
                                    setCommonText(
                                        '${SharedManager.shared.driverReview}',
                                        AppColor.orange,
                                        14.0,
                                        FontWeight.w600,
                                        1),
                                    Icon(
                                      Icons.star,
                                      color: AppColor.orange,
                                      size: 18,
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    setCommonText(
                                        '${S.current.avgDeliveryTime}',
                                        AppColor.black54,
                                        14.0,
                                        FontWeight.w600,
                                        1),
                                    setCommonText('17 min', AppColor.black54,
                                        14.0, FontWeight.w600, 1)
                                  ],
                                )
                              ],
                            ),
                          ),
                          flex: 5,
                        ),
                      ],
                    ),
                  ),
                  flex: 3,
                ),
              ],
            ),
          );
        });
  }

  _setCommonView(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        setCommonText('$title', AppColor.black54, 14.0, FontWeight.bold, 1),
        setCommonText('$value', AppColor.black87, 14.0, FontWeight.w500, 1),
      ],
    );
  }

  void onCameraMove(CameraPosition position) {
    latLng = position.target;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void setCustomMapPin() async {
    destinationLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 10.1),
        'Assets/TrackOrder/destination_map.png');
  }

  void setDriverMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 10.1),
        'Assets/TrackOrder/car.png');
  }

  void sendRequest() async {
    LatLng destination = LatLng(this.lat, this.lng);
    String route =
        await _googleMapsServices.getRouteCoordinates(latLng, destination);
    createRoute(route);
    _addMarker(destination, "${SharedManager.shared.driverName}");
    setState(() {});
  }

  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId(latLng.toString()),
        width: 4,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.red));
  }

  void _addMarker(LatLng location, String address) {
    _markers.add(Marker(
        markerId: MarkerId("112"),
        position: location,
        infoWindow:
            InfoWindow(title: address, snippet: "${S.current.avgTime}: 15min"),
        icon: pinLocationIcon));
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  @override
  Widget build(BuildContext context) {
//    print("getLocation111:$latLng");
    return Scaffold(
        appBar: AppBar(
          title: setCommonText('${S.current.trackOrder}', AppColor.white, 20.0,
              FontWeight.w600, 1),
          backgroundColor: AppColor.themeColor,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton(
                onPressed: () {
                  _modalBottomSheetMenu();
                },
                child: setCommonText('${S.current.driverDetails}',
                    AppColor.white, 16.0, FontWeight.w500, 1))
          ],
        ),
        body: Container(
          child: Container(
            child: GoogleMap(
                polylines: polyLines,
                markers: _markers,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: latLng,
                  zoom: 10,
                ),
                onCameraMove: onCameraMove,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                gestureRecognizers: Set()
                  ..add(Factory<PanGestureRecognizer>(
                      () => PanGestureRecognizer()))
                  ..add(Factory<ScaleGestureRecognizer>(
                      () => ScaleGestureRecognizer()))
                  ..add(Factory<TapGestureRecognizer>(
                      () => TapGestureRecognizer()))
                  ..add(Factory<VerticalDragGestureRecognizer>(
                      () => VerticalDragGestureRecognizer()))),
          ),
        ));
  }
}
