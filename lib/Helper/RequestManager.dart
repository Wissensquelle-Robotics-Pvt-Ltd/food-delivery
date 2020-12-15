import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/Dashboard.dart';
import 'package:product/ModelClass/ModelAddressList.dart';
import 'package:product/ModelClass/ModelAllRestaurantList.dart';
import 'package:product/ModelClass/ModelAllReviewList.dart';
import 'package:product/ModelClass/ModelCategoryList.dart';
import 'package:product/ModelClass/ModelCheckOut.dart';
import 'package:product/ModelClass/ModelCouponCode.dart';
import 'package:product/ModelClass/ModelDriverCurrentLocation.dart';
import 'package:product/ModelClass/ModelMealDeals.dart';
import 'package:product/ModelClass/ModelNotificationList.dart';
import 'package:product/ModelClass/ModelOrderDetails.dart';
import 'package:product/ModelClass/ModelOrderList.dart';
import 'package:product/ModelClass/ModelOrderStatus.dart';
import 'package:product/ModelClass/ModelPayPalToken.dart';
import 'package:product/ModelClass/ModelProfileData.dart';
import 'package:product/ModelClass/ModelRestaurantDetails.dart';
import 'package:product/ModelClass/ModelSearchResult.dart';
import 'package:product/ModelClass/ModelUserLogin.dart';
import 'package:product/ModelClass/ModelUserLogin.dart' as prefix0;
import 'package:product/ModelClass/ModelWalletAmount.dart';
import 'Constant.dart';

class Requestmanager {
//Fetch all notification list data
  Future<ResNotificationList> fetchAllNotificationList(String userId) async {
    final param = {"user_id": userId};
    http.Response response = await _apiRequest(APIS.notificationList, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Restaurant Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final notificationList = ResNotificationList();
        notificationList.code = 0;
        notificationList.message = "Error";
        notificationList.notificationList = [];
        return notificationList;
      } else {
        return ResNotificationList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

//Checkout Process
  Future<ResAddOrder> proccedToCheckOut(String strUrl, dynamic param) async {
    var responseBody = '{"code":0,"message": "failure","result": []}';
    http.Response response = await _apiRequest(strUrl, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Address List Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResAddOrder();
        object.code = 0;
        object.message = "error";
        object.checkoutData = [];
        return object;
      } else {
        return ResAddOrder.fromJson(json.decode(response.body));
      }
    } else {
      var result = json.decode(responseBody);
      print("Json Failure  Details:------>$result");
      return ResAddOrder.fromJson(json.decode(responseBody));
    }
  }

//Add new Address
  Future<bool> addNewAddress(String strUrl, dynamic param) async {
    http.Response response = await _apiRequest(strUrl, param);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

//Delete existing address
  Future<bool> deleteAddress(String strUrl, String addressID) async {
    final param = {"address_id": addressID};
    http.Response response = await _apiRequest(strUrl, param);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

//Fetch user data after login
  Future<UserLogin> getUserLogin(
      String stringUrl, bool isPost, dynamic param) async {
    UserLogin userData = UserLogin();
    http.Response response = await _apiRequest(stringUrl, param);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == 1) {
        userData = UserLogin.fromJson(json.decode(response.body));
        return userData;
      } else {
        userData = UserLogin(
            code: 0,
            message: responseData['message'],
            result: prefix0.Result(
              address: "",
              email: "",
              name: "",
              phone: "",
              profileImage: "",
              userId: "",
            ));
        return userData;
      }
    } else {
      return userData;
    }
  }

//Fetch paypal token for nonce
  Future<ResPayPalToken> getPayPalToken(dynamic param) async {
    ResPayPalToken userData = ResPayPalToken();
    http.Response response = await _apiRequest(APIS.getToken, param);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == 1) {
        userData = ResPayPalToken.fromJson(json.decode(response.body));
        return userData;
      } else {
        userData = ResPayPalToken(
            code: 0, message: responseData['message'], result: '');
        return userData;
      }
    } else {
      return userData;
    }
  }

//Fetch user data during registrations.
  Future<UserLogin> requestForUserRegistration(
      String stringUrl, bool isPost, dynamic param) async {
    UserLogin userData = UserLogin();
    http.Response response = await _apiRequest(stringUrl, param);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == 1) {
        userData = UserLogin.fromJson(json.decode(response.body));
        return userData;
      } else {
        userData = UserLogin(
            code: 0,
            message: responseData['message'],
            result: prefix0.Result(
              address: "",
              email: "",
              name: "",
              phone: "",
              profileImage: "",
              userId: "",
            ));
        return userData;
      }
    } else {
      return userData;
    }
  }

//Mobile OTP Verification

  Future<bool> verifyMobileOTP(dynamic param, BuildContext context) async {
    http.Response response = await _apiRequest(APIS.verifyOTP, param);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == 1) {
        return true;
      } else if (responseData['code'] == 5) {
        SharedManager.shared.showAlertDialog(
            'Invalid OTP.Please Enter valid OTP First', context);
        return false;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

//Fetch all restaurants list and meal deal list data for dashboard based on location.
  Future<Dashboard> requestApiForDashboard(String url, dynamic param) async {
    final param = {
      "latitude": SharedManager.shared.latitude.toString(),
      "longitude": SharedManager.shared.longitude.toString()
    };
    http.Response response = await _apiRequest(url, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Restaurant Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = Dashboard();
        object.code = 0;
        object.message = "error";
        object.result = RestaurantLists();
        return object;
      } else {
        return Dashboard.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
    }
  }

//Fetch Restaurant details based on restaurant id.
  Future<ResRestaurantDetails> requestForFetchRestaurantDetails(
      String resID, String strUrl) async {
    final param = {"restaurant_id": resID};
    http.Response response = await _apiRequest(strUrl, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Restaurant Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResRestaurantDetails();
        object.code = 0;
        object.message = "error";
        object.result = ResDetails();
        return object;
      } else {
        return ResRestaurantDetails.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
      // return restaurantDetails;
    }
  }

//Fetch all order list data.
  Future<ResOrderList> fetchAllOrderList(
      String strUrl, String uerId, String isAll) async {
    final param = {"user_id": uerId, "is_all": isAll};

    http.Response response = await _apiRequest(strUrl, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Address List Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResOrderList();
        object.code = 0;
        object.message = "error";
        object.orderList = [];
        return object;
      } else {
        return ResOrderList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
      // return ResOrderList();
    }
  }

//Fetch all popular, top restaurants data
  Future<ResAllRestaurantList> fetchAllRestaurantList(String strUrl) async {
    final param = {
      "latitude": SharedManager.shared.latitude,
      "longitude": SharedManager.shared.longitude
    };

    http.Response response = await _apiRequest(strUrl, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Address List Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResAllRestaurantList();
        object.code = 0;
        object.message = "error";
        object.allRestaurants = [];
        return object;
      } else {
        return ResAllRestaurantList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
      // return ResOrderList();
    }
  }

//Fetch all meal deal list data
  Future<ResMealDeals> featchMealDealsItems(String strUrl) async {
    final param = {
      "latitude": SharedManager.shared.latitude,
      "longitude": SharedManager.shared.longitude
    };
    http.Response response = await _apiRequest(strUrl, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Address List Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResMealDeals();
        object.code = 0;
        object.message = "error";
        object.result = [];
        return object;
      } else {
        return ResMealDeals.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
      // return ResOrderList();
    }
  }

//Fetch Search Result data.
  Future<ResSearchResult> fetchSearcResultData(String keyWord) async {
    final param = {
      "search_keyword": keyWord,
    };
    http.Response response = await _apiRequest(APIS.searchKeyWords, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Address List Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResSearchResult();
        object.code = 0;
        object.message = "error";
        object.result = SearchResult();
        return object;
      } else {
        return ResSearchResult.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
      // return ResOrderList();
    }
  }

//Fetch Profile list data
  Future<ResProfileData> fetchProfileData(String userId) async {
    final param = {"user_id": userId};

    http.Response response = await _apiRequest(APIS.profile, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Address List Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResProfileData();
        object.code = 0;
        object.message = "error";
        object.result = ResultProfile();
        return object;
      } else {
        return ResProfileData.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
      // return addressListResponse;
    }
  }

//Fetch Order Details
  Future<ResOrderDetails> fetchOrderDetails(String orderId) async {
    final param = {"order_id": orderId};

    http.Response response = await _apiRequest(APIS.orderDetails, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Address List Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResOrderDetails();
        object.code = 0;
        object.message = "error";
        object.orderDetails = Details();
        return object;
      } else {
        return ResOrderDetails.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
      // return addressListResponse;
    }
  }

//Fetch all address list data
  Future<ResAddressList> requestForFetchAddressList(
      String strUrl, String userId) async {
    final param = {"user_id": userId};
    http.Response response = await _apiRequest(strUrl, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Address List Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResAddressList();
        object.code = 0;
        object.message = "error";
        object.addressList = [];
        return object;
      } else {
        return ResAddressList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed restaurant details");
      // return addressListResponse;
    }
  }

//Add Review For Restaurant and Driver

  Future<bool> requestForAddRestaurantReview(
      dynamic param, String strUrl) async {
    http.Response response = await _apiRequest(strUrl, param);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //Change Password

  Future<bool> changePassword(dynamic param, BuildContext context) async {
    http.Response response = await _apiRequest(APIS.changePassword, param);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == 1) {
        return true;
      } else if (responseData['code'] == 4) {
        SharedManager.shared.showAlertDialog(responseData['message'], context);
        return false;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  //Change Password

  Future<bool> forgotPassword(dynamic param, BuildContext context) async {
    http.Response response = await _apiRequest(APIS.forgotPassword, param);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == 1) {
        return true;
      } else if (responseData['code'] == 4) {
        SharedManager.shared.showAlertDialog(responseData['message'], context);
        return false;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

//Fetch Current Order Status
  Future<ResOrderStatus> fetchCurrentOrderStatus(String orderID) async {
    final param = {"order_id": orderID};
    http.Response response = await _apiRequest(APIS.getOrderStatus, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Address List Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResOrderStatus();
        object.code = 0;
        object.message = "error";
        object.result = OrderStatus();
        return object;
      } else {
        return ResOrderStatus.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed Order Status");
      // return addressListResponse;
    }
  }

//Fetch Driver Current Location
  Future<ResDriverLocation> fetchDriverCurrentLocation(String driverId) async {
    final param = {"driver_id": driverId};
    http.Response response = await _apiRequest(APIS.getDriverLocation, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Address List Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResDriverLocation();
        object.code = 0;
        object.message = "error";
        object.result = DriverData();
        return object;
      } else {
        return ResDriverLocation.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed Order Status");
      // return addressListResponse;
    }
  }

//Fetch All Restaurant Review

  Future<ResAllReview> fetchRestaurantReview(String restaurantID) async {
    final param = {"restaurant_id": restaurantID};
    http.Response response = await _apiRequest(APIS.getAllReview, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Address List Details:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResAllReview();
        object.code = 0;
        object.message = "error";
        object.reviews = [];
        return object;
      } else {
        return ResAllReview.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed Order Status");
      // return addressListResponse;
    }
  }

//Get Wallet Amount for transaction.

  Future<ResWalletAmount> fetchWalletAmount(String strURL) async {
    print("URL:--$strURL");
    // final param = {"restaurant_id": restaurantID};
    http.Response response = await _apiRequestWithGet(strURL);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Wallet Amount:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResWalletAmount();
        object.code = 0;
        object.message = "error";
        object.amount = Amount();
        return object;
      } else {
        return ResWalletAmount.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed Order Status");
      // return addressListResponse;
    }
  }

  //Get All category list

  Future<ResCategoryList> fetchAllCategoryList() async {
    http.Response response = await _apiRequestWithGet(APIS.getCategoryList);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Wallet Amount:------>$result");
      final code = result['code'];
      if (code == 0) {
        final object = ResCategoryList();
        object.code = 0;
        object.message = "error";
        object.categoryList = [];
        return object;
      } else {
        return ResCategoryList.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

  //Coupon Code Functionality
  Future<ResCouponCode> applyCouponCode(
      BuildContext context, dynamic param) async {
    http.Response response = await _apiRequest(APIS.checkPromocode, param);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      print("Wallet Amount:------>$result");
      final code = result['code'];
      if (code == 0) {
        SharedManager.shared.showAlertDialog(result['message'], context);
        final object = ResCouponCode();
        object.code = 0;
        object.message = "error";
        object.data = CouponData();
        return object;
      } else if (code == 5) {
        SharedManager.shared.showAlertDialog(result['message'], context);
        final object = ResCouponCode();
        object.code = 0;
        object.message = "error";
        object.data = CouponData();
        return object;
      } else if (code == 4) {
        SharedManager.shared.showAlertDialog(result['message'], context);
        final object = ResCouponCode();
        object.code = 0;
        object.message = "error";
        object.data = CouponData();
        return object;
      } else {
        return ResCouponCode.fromJson(json.decode(response.body));
      }
    } else {
      throw Exception("Fetch to failed Order Status");
    }
  }

//Cancel Order by customer
  Future<bool> requestForCancelOrder(String orderId) async {
    final param = {'order_id': orderId};
    http.Response response = await _apiRequest(APIS.cancelOrder, param);
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      print(responseData);
      if (responseData['code'] == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

//Common Method for request api
//POST
  Future<http.Response> _apiRequest(String url, Map jsonMap) async {
    var body = jsonEncode(jsonMap);
    var response = await http.post(
      url,
      headers: {
        "Accept": "application/json",
        "content-type": "application/json",
      },
      body: body,
    );
    print(response.body);
    return response;
  }
}

//GET
Future<http.Response> _apiRequestWithGet(String url) async {
  var response = await http.get(url.toString());
  print(response.body);
  return response;
}
