import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/Screens/Cart/Cart.dart';
import 'package:product/Screens/TabBarScreens/Dashboard/Dashboard.dart';
import 'package:product/Screens/TabBarScreens/Orders/OrderScreen.dart';
import 'package:product/Screens/TabBarScreens/Profile/ProfileScreen.dart';
import 'package:product/Screens/TabBarScreens/SearchScreen/SearchScreen.dart';
import 'package:product/generated/i18n.dart';

void main() => runApp(new TabBarScreen());

class TabBarScreen extends StatefulWidget {
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final List<Widget> _children = [
    OrderScreen(),
    SearchScreen(),
    DashboardApp(),
    CartApp(),
    ProfileScreen(),
  ];

  _onTapped(int index) {
    setState(() {
      print("index $index");
      SharedManager.shared.isFromTab = true;
      SharedManager.shared.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return new Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          _children[SharedManager.shared.currentIndex],
        ],
      ),
      bottomNavigationBar: new BottomNavigationBar(
        backgroundColor: AppColor.white,
        // elevation: 1,
        type: BottomNavigationBarType
            .fixed, //if you remove this tab bar will white.
        currentIndex: SharedManager.shared.currentIndex,
        onTap: _onTapped,
        items: [
          BottomNavigationBarItem(
              icon: new Icon(Icons.local_shipping, size: 25),
              activeIcon: new Icon(Icons.local_shipping,
                  color: AppColor.themeColor, size: 25),
              title: setCommonText(
                  '${S.current.orders}',
                  (SharedManager.shared.currentIndex == 0)
                      ? AppColor.themeColor
                      : null,
                  1.0,
                  FontWeight.w500,
                  1)),
          BottomNavigationBarItem(
              icon: new Icon(Icons.search, size: 25),
              activeIcon:
                  new Icon(Icons.search, color: AppColor.themeColor, size: 25),
              title: setCommonText(
                  '${S.current.search}',
                  (SharedManager.shared.currentIndex == 1)
                      ? AppColor.themeColor
                      : null,
                  1.0,
                  FontWeight.w500,
                  1)),
          BottomNavigationBarItem(
              icon: new Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.grey[400],
                        blurRadius:
                            10.0, // has the effect of softening the shadow
                        spreadRadius:
                            3.0, // has the effect of extending the shadow
                        offset: Offset(
                          0.0, // horizontal, move right 10
                          0.0, // vertical, move down 10
                        ),
                      )
                    ],
                    color: AppColor.themeColor,
                    borderRadius: new BorderRadius.circular(15),
                  ),
                  child: new Center(
                    child: new Icon(
                      Icons.home,
                      color: AppColor.white,
                      size: 23,
                    ),
                  )),
              title: setCommonText(
                  '${S.current.home}',
                  (SharedManager.shared.currentIndex == 2)
                      ? AppColor.themeColor
                      : null,
                  1.0,
                  FontWeight.w500,
                  1)),
          BottomNavigationBarItem(
              icon: new Icon(Icons.shopping_cart, size: 25),
              activeIcon: new Icon(Icons.shopping_cart,
                  color: AppColor.themeColor, size: 25),
              title: setCommonText(
                  '${S.current.cart}',
                  (SharedManager.shared.currentIndex == 3)
                      ? AppColor.themeColor
                      : null,
                  1.0,
                  FontWeight.w500,
                  1)),
          BottomNavigationBarItem(
              icon: new Icon(Icons.person, size: 25),
              activeIcon:
                  new Icon(Icons.person, color: AppColor.themeColor, size: 25),
              title: setCommonText(
                  '${S.current.profile}',
                  (SharedManager.shared.currentIndex == 4)
                      ? AppColor.themeColor
                      : null,
                  1.0,
                  FontWeight.w500,
                  1)),
        ],
      ),
    );
  }
}
