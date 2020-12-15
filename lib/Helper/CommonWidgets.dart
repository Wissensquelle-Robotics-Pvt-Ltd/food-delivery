import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/Screens/LanguageScreen/LanguageScreen.dart';
import 'package:product/Screens/Login/LoginPage.dart';
import 'package:product/Screens/SignUP/SignUp.dart';
import 'package:product/Screens/SupportScreens/SupportScreens.dart';
import 'package:product/Screens/TabBarScreens/TabScreen/TabBar.dart';
import 'package:product/generated/i18n.dart';

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

//This is the common function which works whole application, which set Text with different font and color.
setCommonText(String title, dynamic color, dynamic fontSize, dynamic fontweight,
    dynamic noOfLine) {
  return new AutoSizeText(
    title,
    textDirection: SharedManager.shared.direction,
    style: new TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontweight,
      fontFamily: SharedManager.shared.fontFamilyName,
    ),
    maxLines: noOfLine,
    overflow: TextOverflow.ellipsis,
    wrapWords: true,
  );
}

showSnackbar(String value, GlobalKey<ScaffoldState> key) {
  key.currentState.showSnackBar(new SnackBar(
      duration: Duration(seconds: 15),
      content: new Row(
        children: <Widget>[
          SizedBox(
            child: CircularProgressIndicator(),
            height: 25.0,
            width: 25.0,
          ),
          SizedBox(width: 15),
          new Expanded(
              child: setCommonText(
                  value, AppColor.white, 17.0, FontWeight.w500, 2))
        ],
      )));
}

setHeight(double height) {
  return SizedBox(
    height: height,
  );
}

setWidth(double width) {
  return SizedBox(
    width: width,
  );
}

//If application works with login or registrations set this widget.
setLockedAccessWidgets(BuildContext context, bool isFromCart) {
  (isFromCart)
      ? SharedManager.shared.isFromCart = true
      : SharedManager.shared.isFromCart = false;
  return new Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Colors.white,
    child: new Column(
      children: <Widget>[
        SizedBox(height: 150),
        new Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('Assets/images/lockedAccess.png'),
                  fit: BoxFit.cover)),
        ),
        SizedBox(height: 10),
        new Padding(
          padding: new EdgeInsets.only(left: 35, right: 35),
          child: new Text(
            S.current.must_be_login,
            style: new TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontFamily: SharedManager.shared.fontFamilyName,
                fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 35),
        new GestureDetector(
          onTap: () {
            Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage()),
                ModalRoute.withName(AppRoute.login));
          },
          child: new Container(
            height: 46,
            width: 160,
            decoration: BoxDecoration(
                color: AppColor.themeColor,
                borderRadius: BorderRadius.circular(23)),
            child: new Center(
              child: setCommonText(
                  S.current.login, Colors.white, 18.0, FontWeight.w400, 1),
            ),
          ),
        ),
        SizedBox(height: 25),
        new Padding(
          padding: new EdgeInsets.only(left: 20, right: 20),
          child: new GestureDetector(
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (context) => SignUpPage(
                            isFromLoginPage: false,
                          )),
                  ModalRoute.withName(AppRoute.signUp));
            },
            child: new Center(
              child: setCommonText(S.current.dont_have_account, Colors.grey,
                  17.0, FontWeight.w600, 1),
            ),
          ),
        )
      ],
    ),
  );
}

//In the cart section if no data found for the check out this common widget will show.
dataFound(BuildContext context, String text, AssetImage image, String type) {
  return new Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: Colors.white,
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: (type == "0") ? 200 : 100,
          width: (type == "0") ? 200 : 100,
          decoration: BoxDecoration(
              image: DecorationImage(image: image, fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 15,
        ),
        new Container(
            padding: new EdgeInsets.only(left: 15, right: 15),
            child: new Text(
              text,
              style: new TextStyle(
                  color: Colors.orange,
                  fontSize: 16.0,
                  fontFamily: SharedManager.shared.fontFamilyName),
              textAlign: TextAlign.center,
            )),
        SizedBox(height: 15),
        new Container(
          height: 40,
          width: 130,
          child: new GestureDetector(
            onTap: () {
              SharedManager.shared.currentIndex = 2;
              SharedManager.shared.isFromTab = true;
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => TabBarScreen()),
                  ModalRoute.withName(AppRoute.tabbar));
            },
            child: new Material(
              elevation: 2.0,
              borderRadius: BorderRadius.circular(20),
              color: AppColor.themeColor,
              child: new Center(
                child: setCommonText(S.current.start_exploring, Colors.white,
                    14.0, FontWeight.w600, 1),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

//This widget will display after payment success.
setSuccessView(BuildContext context) {
  return new Container(
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
    color: AppColor.themeColor,
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("Assets/Checkout/success.png"),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 30,
        ),
        setCommonText(
            S.current.thank_you, Colors.white, 20.0, FontWeight.w400, 1),
        SizedBox(
          height: 8,
        ),
        setCommonText(S.current.your_order_placed, Colors.white, 16.0,
            FontWeight.w400, 1),
        SizedBox(
          height: 1,
        ),
        setCommonText(
            S.current.have_a_great_day, Colors.white, 16.0, FontWeight.w400, 1),
        SizedBox(
          height: 20,
        ),
        new Container(
          height: 50,
          width: MediaQuery.of(context).size.width - 200,
          child: new InkWell(
            onTap: () {
              SharedManager.shared.storeString("yes", "isOrderDone");
              SharedManager.shared.currentIndex = 2;
              SharedManager.shared.isFromTab = true;
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => TabBarScreen()),
                  ModalRoute.withName(AppRoute.tabbar));
            },
            child: new Material(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(25),
              child: new Center(
                child: setCommonText(S.current.check_order, Colors.black87,
                    16.0, FontWeight.w500, 1),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

//This is the common textfield widgets which use whole app.
setCommonTetField(String title, Icon icon, dynamic controller, bool isSecure,
    TextInputType type) {
  return new Container(
    padding: new EdgeInsets.only(left: 8, right: 8),
    height: 50,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.themeColor, width: 2.0)),
    child: new Row(
      children: <Widget>[
        icon,
        SizedBox(
          width: 5,
        ),
        new Expanded(
          child: new TextFormField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: title,
                hintStyle: new TextStyle(color: AppColor.white),
                border: InputBorder.none),
            style: new TextStyle(
                color: AppColor.white,
                fontFamily: SharedManager.shared.fontFamilyName,
                fontSize: 18),
            obscureText: isSecure,
            keyboardType: type,
          ),
        )
      ],
    ),
  );
}

class LoginScreen extends StatelessWidget {
  final List profileList = [
    {
      "name": S.current.languages,
      "icon": Icon(Icons.language, size: 17, color: AppColor.grey)
    },
    {
      "name": S.current.support,
      "icon": Icon(Icons.headset, size: 17, color: AppColor.grey)
    },
    {
      "name": S.current.notifications,
      "icon": Icon(Icons.notifications, size: 17, color: AppColor.grey)
    },
    {
      "name": S.current.recent_orders,
      "icon": Icon(Icons.local_shipping, size: 17, color: AppColor.grey)
    },
    {
      "name": S.current.login,
      "icon": Icon(Icons.power_settings_new, size: 17, color: AppColor.grey)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Expanded(
                flex: 2,
                child: new Stack(
                  children: <Widget>[
                    new Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'Assets/RestaurantDetails/RestaurantApp.jpg'),
                              fit: BoxFit.cover)),
                    ),
                    new Container(
                      color: AppColor.black.withOpacity(0.5),
                    ),
                    new Center(
                        child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage: AssetImage(
                            'Assets/images/lockedAccess.png',
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                        setCommonText("Guest User", AppColor.amber, 18.0,
                            FontWeight.w500, 1),
                        SizedBox(height: 3),
                        setCommonText("guestuser@hotmail.com", AppColor.white,
                            16.0, FontWeight.w400, 1),
                      ],
                    ))
                  ],
                )),
            SizedBox(height: 20),
            new Expanded(
                flex: 3,
                child: new Container(
                  child: new ListView.builder(
                      itemCount: profileList.length,
                      itemBuilder: (context, index) {
                        return new Container(
                          // height: 50,
                          padding: new EdgeInsets.only(
                              left: 15, right: 15, top: 2, bottom: 2),
                          child: new InkWell(
                            onTap: () {
                              if (index == 4) {
                                Navigator.of(context, rootNavigator: true)
                                    .pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                        ModalRoute.withName(AppRoute.login));
                              } else if (index == 2 || index == 3) {
                                SharedManager.shared.showAlertDialog(
                                    "Please Login First", context);
                              } else if (index == 0) {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LanguageScreen()));
                              } else if (index == 1) {
                                Navigator.of(context, rootNavigator: true).push(
                                    MaterialPageRoute(
                                        builder: (context) => SupportScreen()));
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        profileList[index]['icon'],
                                        SizedBox(width: 8),
                                        setCommonText(
                                            profileList[index]['name'],
                                            AppColor.grey,
                                            16.0,
                                            FontWeight.w400,
                                            1)
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward_ios,
                                        size: 17, color: AppColor.grey)
                                  ],
                                ),
                                SizedBox(height: 10),
                                Divider()
                              ],
                            ),
                          ),
                        );
                      }),
                ))
          ],
        ),
      ),
    );
  }
}

//This is for restaurant close
setRestaurantClosedWidget(BuildContext context, String title) {
  return InkWell(
    onTap: () {
      SharedManager.shared.showAlertDialog(
          'Restaurant is closed,Service is unavailable', context);
    },
    child: Container(
      decoration: BoxDecoration(
          color: AppColor.black54, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: setCommonText("$title", AppColor.red, 18.0, FontWeight.bold, 1),
      ),
    ),
  );
}

commonRestaurantCloseAlert(BuildContext context) {
  SharedManager.shared
      .showAlertDialog('Restaurant is closed,Service is unavailable', context);
}

//This is for Item out of stock
setItemOutOfStockWidget(BuildContext context, String title) {
  return InkWell(
    onTap: () {
      SharedManager.shared.showAlertDialog(
          'Item is out of stock.Please try after sometime', context);
    },
    child: Container(
      decoration: BoxDecoration(
          color: AppColor.black54, borderRadius: BorderRadius.circular(5)),
      child: Center(
        child: setCommonText("$title", AppColor.red, 18.0, FontWeight.bold, 1),
      ),
    ),
  );
}

commonItemOutofStockAlert(BuildContext context) {
  SharedManager.shared.showAlertDialog(
      'Item is out of stock.Please try after sometime', context);
}
