import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/ModelClass/ModelRestaurantDetails.dart';
import 'package:product/ModelClass/ModelUserLogin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:http/http.dart' as http;
import 'dart:convert';

class SharedManager {
  static final SharedManager shared = SharedManager._internal();

  factory SharedManager() {
    return shared;
  }

  SharedManager._internal();

  var fontFamilyName = "Quicksand";
  bool isRTL = false;
  var direction = TextDirection.ltr;
  var address = "Select Address";
  var latitude = 0.0;
  var longitude = 0.0;
  var addressId = "";
  var deliveryAddressName = "";
  var deliveryAddressNumber = "";
  var restaurantID = "";
  var userID = "1";
  var oldResID = "";
  var resName = "";
  var resAddress = "";
  var resImage = "";
  bool isFromTab = false;
  bool isFromCart = false;
  int currentIndex = 2;
  var isLoggedIN = "no";
  var token = "";
  String resLatitude = "";
  String resLongitude = "";
  String orderId = "";
  //Set Distance Radius.
  //Order is only applicable between 15kms.
  double distanceFilter = 15.0;

  //We have set 30 second for updating driver location every time.
  //during order tracking.
  //you can set according to your requirements.
  int updateDriver = 30;

  //Couponcode Functionality
  //Make sure after order complete it should be clear

  bool isCouponApplied = false;
  var discountType = "";
  var discount = "0";
  var discountPice = "0";
  double tempTotalPrice = 0.0;
  var couponCode = '';

//Driver Details
  var driverName = '';
  var driverImage = '';
  var driverReview = '';
  var driverPhone = '';

  List<Subcategories> cartItems = [];

  ValueNotifier<Locale> locale = new ValueNotifier(Locale('en', ''));
  // final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  storeLocationCoordinate(LatLng coordinates) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (coordinates.latitude != 0.0 || coordinates.longitude != 0.0) {
      await prefs.setDouble("latitude", coordinates.latitude);
      await prefs.setDouble("longitude", coordinates.longitude);
    }
  }

  Future<bool> set(key, value) async {
    final shareSave = await SharedPreferences.getInstance();

    return shareSave.setString(key, value);
  }

  Future<String> get(key) async {
    final shareSave = await SharedPreferences.getInstance();
    return shareSave.getString(key);
  }

  Future<LatLng> getLocationCoordinate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    this.latitude = await prefs.get("latitude");
    this.longitude = await prefs.get("longitude");
    var latlong = LatLng(latitude, longitude);

    return latlong;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  storeUserLoginData(UserLogin data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(DefaultKeys.userName, data.result.name);
    await prefs.setString(DefaultKeys.userEmail, data.result.email);
    await prefs.setString(DefaultKeys.userId, data.result.userId);
    await prefs.setString(DefaultKeys.userAddress, data.result.address);
    await prefs.setString(DefaultKeys.userPhone, data.result.phone);
    await prefs.setString(DefaultKeys.userImage, data.result.profileImage);
  }

  Future<String> getPushToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.get(DefaultKeys.pushToken);
    if (token != null) {
      return token;
    }
    return "";
  }

  Future<String> userName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var name = await prefs.get(DefaultKeys.userName);
    if (name != null) {
      return name;
    }
    return "";
  }

  Future<String> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isLoogedIn = await prefs.get(DefaultKeys.isLoggedIn);
    if (isLoogedIn != null) {
      return isLoogedIn;
    }
    return "no";
  }

  Future<String> userEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = await prefs.get(DefaultKeys.userEmail);
    if (email != null) {
      return email;
    }
    return "";
  }

  Future<String> userImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userImage = await prefs.get(DefaultKeys.userImage);
    if (userImage != null) {
      return userImage;
    }
    return "";
  }

  Future<String> userPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userPhone = await prefs.get(DefaultKeys.userPhone);
    if (userPhone != null) {
      return userPhone;
    }
    return "";
  }

  Future<String> userId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userId = await prefs.get(DefaultKeys.userId);
    if (userId != null) {
      return userId;
    }
    return "";
  }

  Future<String> userAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userAddress = await prefs.get(DefaultKeys.userAddress);
    if (userAddress != null) {
      return userAddress;
    }
    return "";
  }

  storeString(String value, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> getStrng(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final value = await prefs.get(key);
    if (value != null) {
      return value;
    } else {
      return "";
    }
  }

  void showAlertDialog(String message, BuildContext context) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Zu-Man"),
          content: new Text(message),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

//Calculate Distance between two location.

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=${Keys.directionAPI}";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);

    return values["routes"][0]["overview_polyline"]["points"];
  }
}
