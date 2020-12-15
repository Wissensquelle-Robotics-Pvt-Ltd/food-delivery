import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/LocationManager.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/Screens/ForgotPassword/forgotPassword.dart';
import 'package:product/Screens/SignUP/SignUp.dart';
import 'package:product/Screens/TabBarScreens/TabScreen/TabBar.dart';

import 'package:product/generated/i18n.dart';

void main() => runApp(LoginPage());

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var width = 40.0;
  var height = 40.0;
  var status = true;

  var widthgp = 40.0;
  var heightgp = 40.0;
  var statusgp = true;

  static TextEditingController emailController = new TextEditingController();
  static TextEditingController passwordController = new TextEditingController();
  bool isSecure = true;
  static double latitude = 0.00;
  static double longitude = 0.00;

//Social Media Integrations for login.

  @override
  void initState() {
    super.initState();
    //Select default language
    LocationManager.shared.getCurrentLocation();
    _getUserCurrentLocation();
    emailController.text = "";
  }

  // var facebookLogin = FacebookLogin();

  _getUserCurrentLocation() async {
    LatLng coordinate = await SharedManager.shared.getLocationCoordinate();
    latitude = coordinate.latitude;
    longitude = coordinate.longitude;
  }

  _setLoginMethod() async {
    var validator = SharedManager.shared.validateEmail(emailController.text);

    if (emailController.text == "" || validator == "Enter Valid Email") {
      Navigator.pop(context);
      SharedManager.shared
          .showAlertDialog("${S.current.enterEmailFirst}", context);
      return;
    } else if (passwordController.text == "") {
      Navigator.pop(context);
      SharedManager.shared
          .showAlertDialog("${S.current.enterOldpass}}", context);
      return;
    }

    var param = {
      "email": emailController.text,
      "password": passwordController.text,
      "device_token": SharedManager.shared.token,
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
    };

    print("Request Parameter:$param");

    var manager = Requestmanager();
    var data = await manager.getUserLogin(APIS.login, true, param);
    print("User data: ===== >>>>>>${data.code}");
    if (data.code == 1) {
      emailController.text = '';
      passwordController.text = '';
      await SharedManager.shared.storeString("yes", "isLoogedIn");
      await SharedManager.shared.storeUserLoginData(data);
      SharedManager.shared.isLoggedIN = "yes";
      Navigator.pop(context);
      (SharedManager.shared.isFromCart)
          ? SharedManager.shared.currentIndex = 3
          : SharedManager.shared.currentIndex = 2;
      (SharedManager.shared.isFromCart)
          ? SharedManager.shared.isFromTab = true
          : SharedManager.shared.isFromTab = false;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => TabBarScreen()),
          ModalRoute.withName(AppRoute.tabbar));
    } else {
      Navigator.pop(context);
      SharedManager.shared.showAlertDialog(data.message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: AppColor.white,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // color: AppColor.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(AppImages.appLogo),
                          ),
                          setCommonText(S.current.food_zone, AppColor.black54,
                              20.0, FontWeight.w500, 1)
                        ],
                      ),
                    ),
                    Positioned(
                        top: 40,
                        right: 12,
                        child: InkWell(
                          onTap: () {
                            SharedManager.shared.currentIndex = 2;
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => TabBarScreen()),
                                    ModalRoute.withName(AppRoute.tabbar));
                          },
                          child: setCommonText(S.current.skip, AppColor.black,
                              16.0, FontWeight.w500, 1),
                        ))
                  ],
                )),
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  // color: AppColor.amber,
                  child: Column(
                    children: <Widget>[
                      Container(
                        // height: 60,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '${S.current.email}'),
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.grey,
                                  fontFamily:
                                      SharedManager.shared.fontFamilyName),
                            ),
                            Container(
                              height: 1,
                              color: AppColor.black38,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        // height: 60,
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: TextFormField(
                                    controller: passwordController,
                                    obscureText: this.isSecure ? true : false,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '${S.current.password}'),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.grey,
                                        fontFamily: SharedManager
                                            .shared.fontFamilyName),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      this.isSecure = !this.isSecure;
                                    });
                                  },
                                  child: Icon(
                                    this.isSecure
                                        ? Icons.visibility_off
                                        : Icons.remove_red_eye,
                                    color: this.isSecure
                                        ? AppColor.grey
                                        : AppColor.black54,
                                    size: 20.0,
                                  ),
                                )
                              ],
                            ),
                            Container(
                              height: 1,
                              color: AppColor.black38,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()));
                                  },
                                  child: setCommonText(
                                      '${S.current.forgotPassword}',
                                      AppColor.grey,
                                      14.0,
                                      FontWeight.w500,
                                      1),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          _setLoginMethod();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColor.themeColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: setCommonText('${S.current.login}',
                                AppColor.white, 16.0, FontWeight.bold, 1),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          setCommonText('${S.current.dont_have_account}',
                              AppColor.grey, 14.0, FontWeight.w500, 1),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {
                              //SignUpPage
                              //OTPVerificationPage
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUpPage(
                                        isFromLoginPage: true,
                                      )));
                            },
                            child: setCommonText('${S.current.register}',
                                AppColor.themeColor, 15.0, FontWeight.bold, 1),
                          )
                        ],
                      ),
                      SizedBox(height: 25),
                      Container(
                        height: 45,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.facebookBG,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: setCommonText('${S.current.facebook}',
                                    AppColor.white, 16.0, FontWeight.bold, 1),
                              ),
                            )),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  color: AppColor.googleBG,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: setCommonText('${S.current.google}',
                                    AppColor.white, 16.0, FontWeight.bold, 1),
                              ),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
