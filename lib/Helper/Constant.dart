import 'package:flutter/material.dart';

//All Api placed in this class.
//Just replace with existing base url here.
class APIS {
  static var baseurl = "http://18.222.150.207/foodzone/webservices/";
  // static var baseurl = "http://18.191.219.230/foodorders/webservices/";
  //http://18.222.150.207/foodzone/

  static var login = baseurl + "login";
  static var registration = baseurl + "registration";
  static var socialSignIn = baseurl + "social_signin";
  static var dashBoard = baseurl + "home";
  static var resDetails = baseurl + "details";
  static var addNewAddress = baseurl + "add_user_address";
  static var addressList = baseurl + "get_user_address";
  static var deleteAddress = baseurl + "delete_address";
  static var makeOrder = baseurl + "add_order";
  static var orderList = baseurl + "orders_list";
  static var orderDetails = baseurl + "order_details";
  static var allTopRestaurant = baseurl + "all_top_restaurants";
  static var mostPopularRestaurant = baseurl + "most_polupar_restaurants";
  static var profile = baseurl + "profile";
  static var mealDeals = baseurl + "mealDeal";
  static var searchKeyWords = baseurl + "search";
  static var notificationList = baseurl + "notifications";
  static var getToken = baseurl + "get_braintree_token";
  static var addRestaurantReview = baseurl + "add_restaurant_review";
  static var addDriverReview = baseurl + "add_driver_review";
  static var getOrderStatus = baseurl + "get_order_status";
  static var cancelOrder = baseurl + "cancel_order";
  static var getAllReview = baseurl + "get_all_review";
  static var walletAmount = baseurl + "get_wallet_amount/";
  static var getCategoryList = baseurl + "categories";
  static var changePassword = baseurl + "change_password";
  static var forgotPassword = baseurl + "forgot_password";
  static var checkPromocode = baseurl + "check_promocode";
  static var getDriverLocation = baseurl + "get_driver_location";
  static var verifyOTP = baseurl + "checkOtp";
}

//We have used Shared preferance for storing some low level data.
//For this we have used this keys.
class DefaultKeys {
  static var userName = "name";
  static var userEmail = "email";
  static var userId = "userId";
  static var userImage = "image";
  static var userAddress = "address";
  static var userPhone = "phone";
  static var isLoggedIn = "isLoogedIn";
  static var pushToken = "firebaseToken";
}

//These are all required keys which are usefull for the Stripe,Paypal payment gateways as well as google place API.
//You must have to replaced with your new keys and API.
//Otherwise application will not work perfectly.
class Keys {
  //You must have to add paid google direcion api.Without paid direction api route will not work
  static var razorPayId = 'rzp_test_XDtOe2jxxxxx';
  static var bannerID = 'ca-app-pub-8299041309330339/xxxxxxx';
  static var interstatialID = 'ca-app-pub-8299041309330339xxxxxxxx';
  static var admobAppID = 'ca-app-pub-8299041309330339~1xxxxxxx';
  static var directionAPI = "AIzaSyBEx18KDb60DYVfrxxxxxxxxx";
  static var paypalMerchantID = "9fjqbjhdxxxxxxx";
  static var kGoogleApiKey = "AIzaSyC_jtk7R4VRNR3d1EOLiVxxxxxxx";
  static var publishKey = "pk_test_5MNsOgVhHdH1U3SMbBTzq7xxxxxxx";
  static var clientNonce =
      "eyJ2ZXJzaW9uIjoyLCJlbnZpcm9ubWVudCI6InNhbmRib3giLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPxxxxxxxxxxxxxxSXdNVGd3TkRJMk1UWXRjMkZ1WkdKdmVDSXNJbWx6Y3lJNklrRjFkR2g1SW4wLmV5SmxlSEFpT2pFMU9EY3pNak16TmpJc0ltcDBhU0k2SWpRM1lUaGhZbVZpTFdabU1HUXRORGMzWVMxaU56Qm1MVFV5TTJJME9UUmxPV000WWlJc0luTjFZaUk2SWpsbWFuRmlhbWhrZDNkNmVHMTZaM0VpTENKcGMzTWlPaUpCZFhSb2VTSXNJbTFsY21Ob1lXNTBJanA3SW5CMVlteHBZMTlwWkNJNklqbG1hbkZpYW1oa2QzZDZlRzE2WjNFaUxDSjJaWEpwWm5sZlkyRnlaRjlpZVY5a1pXWmhkV3gwSWpwbVlXeHpaWDBzSW5KcFoyaDBjeUk2V3lKdFlXNWhaMlZmZG1GMWJIUWlYU3dpYjNCMGFXOXVjeUk2ZXlKamRYTjBiMjFsY2w5cFpDSTZJakV4TVRZMU5qWTBNeUo5ZlEuUkhCMXNMdmlfN1g1T1NUM1ZDRFNOTU5KcjYtaThhYUhGUm9TQjBjbkdQWGlsMlltSEh3YldJRkxaal9YVHptTEdidGdOTU9tZzExSEwyRFFKZXFfb0E/Y3VzdG9tZXJfaWQ9IiwiY29uZmlnVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzlmanFiamhkd3d6eG16Z3EvY2xpZW50X2FwaS92MS9jb25maWd1cmF0aW9uIiwiaGFzQ3VzdG9tZXIiOnRydWUsImdyYXBoUUwiOnsidXJsIjoiaHR0cHM6Ly9wYXltZW50cy5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tL2dyYXBocWwiLCJkYXRlIjoiMjAxOC0wNS0wOCJ9LCJjaGFsbGVuZ2VzIjpbXSwiY2xpZW50QXBpVXJsIjoiaHR0cHM6Ly9hcGkuc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbTo0NDMvbWVyY2hhbnRzLzlmanFiamhkd3d6eG16Z3EvY2xpZW50X2FwaSIsImFzc2V0c1VybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXV0aFVybCI6Imh0dHBzOi8vYXV0aC52ZW5tby5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tIiwiYW5hbHl0aWNzIjp7InVybCI6Imh0dHBzOi8vb3JpZ2luLWFuYWx5dGljcy1zYW5kLnNhbmRib3guYnJhaW50cmVlLWFwaS5jb20vOWZqcWJqaGR3d3p4bXpncSJ9LCJ0aHJlZURTZWN1cmVFbmFibGVkIjp0cnVlLCJwYXlwYWxFbmFibGVkIjp0cnVlLCJwYXlwYWwiOnsiZGlzcGxheU5hbWUiOiJBTFBBQkhBTkRFUkkiLCJjbGllbnRJZCI6IkFhZm5NMmxlVjNxanpzX2MyVjlhcjc2V3AtNld6ZXlIN3FMdTYwYTBvSmhPbVRwal9Xdng1VTJGYkx4TFhSZllxNEkzVXlZSHh2bUE3TERqIiwicHJpdmFjeVVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS9wcCIsInVzZXJBZ3JlZW1lbnRVcmwiOiJodHRwOi8vZXhhbXBsZS5jb20vdG9zIiwiYmFzZVVybCI6Imh0dHBzOi8vYXNzZXRzLmJyYWludHJlZWdhdGV3YXkuY29tIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9jaGVja291dC5wYXlwYWwuY29tIiwiZGlyZWN0QmFzZVVybCI6bnVsbCwiYWxsb3dIdHRwIjp0cnVlLCJlbnZpcm9ubWVudE5vTmV0d29yayI6dHJ1ZSwiZW52aXJvbm1lbnQiOiJvZmZsaW5lIiwidW52ZXR0ZWRNZXJjaGFudCI6ZmFsc2UsImJyYWludHJlZUNsaWVudElkIjoibWFzdGVyY2xpZW50MyIsImJpbGxpbmdBZ3JlZW1lbnRzRW5hYmxlZCI6dHJ1ZSwibWVyY2hhbnRBY2NvdW50SWQiOiJhbHBhYmhhbmRlcmkiLCJjdXJyZW5jeUlzb0NvZGUiOiJVU0QifSwibWVyY2hhbnRJZCI6IjlmanFiamhkd3d6eG16Z3EiLCJ2ZW5tbyI6Im9mZiJ9";
}

//This is the app colors.
//You can change your theme color based on your requirements.
//This is the main application theme color.
class AppColor {
  //static var themeColor = Colors.green;
  static var pagingIndicatorColor = Colors.red;
  static var black = HexToColor("#000000");
  static var orangeDeep = Colors.deepOrange;
  static var colorGyay_100 = Colors.grey[100];
  static var white = Colors.white;
  static var amber = Colors.amber;
  static var grey = Colors.grey;
  static var black87 = Colors.black87;
  static var red = Colors.red;
  static var black38 = Colors.black38;
  static var deepOrange = Colors.deepOrange;
  static var black54 = Colors.black54;
  static var orange = Colors.orange;
  static var teal = Colors.teal;
  static var facebookBG = hexToColor("#5B7CB4"); //Facebook icon color
  static var googleBG = hexToColor("#D95946"); //Google plus icon color

  // You can use sample theme color

  static var themeColor = hexToColor('#ff0000');
  // static var themeColor = hexToColor('#2F3841'); //this is icon bg color.
  // static var themeColor = HexToColor("#79CABD");
  // static var themeColor = HexToColor("#f2bd68");
  // static var themeColor = HexToColor("#9468f2");
  // static var themeColor = HexToColor("#f268b4");
  // static var themeColor = HexToColor("#f26868");

}

//Convert color from hax color.
class HexToColor extends Color {
  static _hexToColor(String code) {
    return int.parse(code.substring(1, 7), radix: 16) + 0xFF000000;
  }

  HexToColor(final String code) : super(_hexToColor(code));
}

//Important Images path we have used in application.
class AppImages {
  static var appLogo = "Assets/FoodZoneLogo.png";
  static var background = 'Assets/RestaurantDetails/RestaurantApp.jpg';
  static var googleIcon = "Assets/googlePlus.png";
  static var facebookIcon = "Assets/facebook.png";
  static var vegItem = "Assets/RestaurantDetails/veg.png";
  static var nonVegItem = "Assets/RestaurantDetails/nonVeg.png";
  static var cartDefaultImage = "Assets/Cart/emptyCart.png";
}

class AppRoute {
  static const dashboard = '/dashboard';
  static const tabbar = '/tabbar';
  static const login = '/login';
  static const signUp = '/signUp';
  static const checkOut = '/checkout';
}

Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

class Currency {
  static const curr = '\$';
  // static const curr = '₹';
  // static const curr = ''';
}
