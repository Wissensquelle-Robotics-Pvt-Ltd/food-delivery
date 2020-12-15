import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/Screens/ChangeAddress/ChangeAddress.dart';
import 'package:product/Screens/ChangePasswordScreen/ChangePasswordScreen.dart';
import 'package:product/Screens/EditProfileScreen/EditProfileScreen.dart';
import 'package:product/Screens/LanguageScreen/LanguageScreen.dart';
import 'package:product/Screens/NotificationList/NotificationList.dart';
import 'package:product/Screens/SupportScreens/SupportScreens.dart';
import 'package:product/Screens/TabBarScreens/TabScreen/TabBar.dart';
import 'package:product/generated/i18n.dart';

class ProfileListWidget extends StatelessWidget {
  final List listOptions = [
    {
      "title": S.current.change_password,
      "icon": Icon(Icons.lock, color: AppColor.grey[700], size: 18)
    },
    {
      "title": S.current.support,
      "icon": Icon(Icons.headset_mic, color: AppColor.grey[700], size: 18)
    },
    {
      "title": S.current.languages,
      "icon": Icon(Icons.language, color: AppColor.grey[700], size: 18)
    },
    {
      "title": S.current.notifications,
      "icon": Icon(Icons.notifications, color: AppColor.grey[700], size: 18)
    },
    {
      "title": S.current.saved_address,
      "icon": Icon(Icons.note_add, color: AppColor.grey[700], size: 18)
    },
    {
      "title": S.current.logout,
      "icon": Icon(Icons.settings_power, color: AppColor.grey[700], size: 18)
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: (60.0 * listOptions.length),
        // color: AppColor.green,
        padding: new EdgeInsets.all(15),
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: listOptions.length,
          itemBuilder: (context, index) {
            return new InkWell(
              onTap: () async {
                // await SharedManager.shared.facebookSignIn.logOut();
                // await SharedManager.shared.googleSignIn.signOut();
                if (index == 0) {
                  // SharedManager.shared
                  //     .showAlertDialog(S.current.coming_soon, context);

                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => ChangePasswordScreen()));
                } else if (index == 2) {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(
                          builder: (context) => LanguageScreen()));
                } else if (index == 1) {
                  Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (context) => SupportScreen()));
                } else if (index == 4) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => ChangeAddress()));
                } else if (index == 5) {
                  _showMyDialog(context);
                } else if (index == 3) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => NotificationList()));
                }
              },
              child: new Container(
                height: 55,
                child: new Column(
                  children: <Widget>[
                    new Expanded(
                      child: new Container(
                        color: AppColor.white,
                        child: new Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                child: listOptions[index]['icon'],
                              ),
                            ),
                            Expanded(
                              flex: 10,
                              child: Container(
                                // color: AppColor.red,
                                padding:
                                    new EdgeInsets.only(left: 10, right: 10),
                                child: setCommonText(
                                    listOptions[index]['title'],
                                    AppColor.grey[500],
                                    14.0,
                                    FontWeight.w400,
                                    1),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new Divider(
                      color: AppColor.black38,
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(
            '${S.current.sureWantToLogout}',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: AppColor.themeColor,
                fontFamily: SharedManager.shared.fontFamilyName),
          ),
          actions: <Widget>[
            new FlatButton(
              child: Text(
                '${S.current.cancel}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: AppColor.themeColor,
                    fontFamily: SharedManager.shared.fontFamilyName),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: Text(
                '${S.current.ok}',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: AppColor.themeColor,
                    fontFamily: SharedManager.shared.fontFamilyName),
              ),
              onPressed: () async {
                await SharedManager.shared.storeString("no", "isLoogedIn");
                SharedManager.shared.currentIndex = 2;
                SharedManager.shared.isLoggedIN = "no";
                Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => TabBarScreen()),
                    ModalRoute.withName(AppRoute.tabbar));
              },
            ),

            // title: setCommonText('${S.current.sureWantToLogout}', AppColor.black,
            //     16.0, FontWeight.w500, 2),
            // content: SingleChildScrollView(
            // child: Container(
            //   height: 80,
            //   color: AppColor.amber,
            // ),
            // ),
            // actions: <Widget>[
            // usually buttons at the bottom of the dialog
            // new FlatButton(
            //   child: setCommonText('${S.current.cancel}',
            //       AppColor.themeColor, 13.0, FontWeight.w500, 2),
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            // ),
            // new FlatButton(
            //   child: setCommonText('${S.current.ok}',
            //       AppColor.themeColor, 13.0, FontWeight.w500, 2),
            //   onPressed: () async {
            //     await SharedManager.shared
            //         .storeString("no", "isLoogedIn");
            //     SharedManager.shared.currentIndex = 2;
            //     SharedManager.shared.isLoggedIN = "no";
            //     Navigator.of(context, rootNavigator: true)
            //         .pushAndRemoveUntil(
            //             MaterialPageRoute(
            //                 builder: (context) => TabBarScreen()),
            //             ModalRoute.withName(AppRoute.tabbar));
            //   },
            // ),
          ],
        );
      },
    );
  }
}

class ProfileWidgets extends StatelessWidget {
  final String name;
  final String email;
  final String image;
  final String walletAmount;
  final String mobile;
  final String totalOrders;
  ProfileWidgets(this.name, this.email, this.image, this.walletAmount,
      this.mobile, this.totalOrders);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 265,
          color: AppColor.white,
          padding: new EdgeInsets.only(top: 20, right: 15, left: 30),
          child: new Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  setCommonText('${S.current.myProfile}', AppColor.black87,
                      20.0, FontWeight.bold, 1),
                  IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: AppColor.themeColor,
                        size: 20,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditProfileScreen()));
                      })
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: <Widget>[
                  new Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColor.grey,
                          width: 4,
                        ),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover)),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: setCommonText(
                        name, AppColor.black87, 18.0, FontWeight.w500, 1),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.email,
                        color: AppColor.grey[500],
                        size: 18,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      setCommonText(
                          email, AppColor.grey[500], 15.0, FontWeight.w400, 1),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.phone,
                        color: AppColor.grey[500],
                        size: 18,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      setCommonText('$mobile', AppColor.grey[500], 13.0,
                          FontWeight.w400, 1),
                    ],
                  ),
                ],
              )
              // new Container(
              //   decoration: BoxDecoration(
              //       image: DecorationImage(
              //           image: ExactAssetImage('Assets/res.jpeg'),
              //           fit: BoxFit.cover)),
              // ),
              // Container(
              //   color: AppColor.black38,
              // ),
              // new Align(
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: <Widget>[
              // new Container(
              //   height: 100,
              //   width: 100,
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       border: Border.all(
              //         color: AppColor.white,
              //         width: 4,
              //       ),
              //       image: DecorationImage(
              //           image: NetworkImage(image), fit: BoxFit.cover)),
              // ),
              //       SizedBox(
              //         height: 10,
              //       ),
              //       setCommonText(name, AppColor.white, 20.0, FontWeight.w500, 1),
              //       SizedBox(
              //         height: 2,
              //       ),
              //       setCommonText(email, AppColor.white, 18.0, FontWeight.w500, 1),
              //       new FlatButton(
              //         child: setCommonText(S.current.edit_profile,
              //             AppColor.themeColor, 16.0, FontWeight.bold, 1),
              //         onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => EditProfileScreen()));
              //         },
              //       )
              //     ],
              //   ),
              // )
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppColor.grey[300],
        ),
        Container(
          height: 60,
          color: AppColor.white,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setCommonText('${Currency.curr}$walletAmount',
                        AppColor.black, 15.0, FontWeight.w500, 1),
                    setCommonText('${S.current.wallete}', AppColor.grey[600],
                        12.0, FontWeight.w500, 1)
                  ],
                ),
              )),
              Container(
                width: 1,
                color: AppColor.grey[300],
              ),
              Expanded(
                  child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setCommonText('$totalOrders', AppColor.black, 15.0,
                        FontWeight.w500, 1),
                    setCommonText('${S.current.orders}', AppColor.grey[600],
                        12.0, FontWeight.w500, 1)
                  ],
                ),
              )),
            ],
          ),
        ),
        Container(
          height: 1,
          color: AppColor.grey[300],
        ),
      ],
    );
  }
}
