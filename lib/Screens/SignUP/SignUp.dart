import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/LocationManager.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/Screens/OTPVerificationPage/OTPVerificationPage.dart';
import 'package:product/Screens/TabBarScreens/TabScreen/TabBar.dart';
import 'package:product/generated/i18n.dart';

void main() => runApp(new SignUpPage());

class SignUpPage extends StatefulWidget {
  final bool isFromLoginPage;
  SignUpPage({Key key, this.isFromLoginPage}) : super(key: key);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  static TextEditingController userNameController = new TextEditingController();
  static TextEditingController emailController = new TextEditingController();
  static TextEditingController passwordController = new TextEditingController();
  // static TextEditingController phoneController = new TextEditingController();

  static double latitude = 0.0;
  static double longitude = 0.0;
  bool isSecure = true;
  // variable Declaration for International phone input field
  String phoneNumber;
  String phoneIsoCode;

  @override
  void initState() {
    super.initState();
    //Select default language
    LocationManager.shared.getCurrentLocation();
    _getUserCurrentLocation();
    emailController.text = "";
  }

  void _onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      print(phoneNumber);
      phoneNumber = internationalizedPhoneNumber;
      phoneIsoCode = isoCode;
    });
  }

  _getUserCurrentLocation() async {
    LatLng coordinate = await SharedManager.shared.getLocationCoordinate();
    latitude = coordinate.latitude;
    longitude = coordinate.longitude;
  }

  _actionMethodRegistration() async {
    print(emailController.text);
    print(passwordController.text);
    print(phoneNumber);
    print(userNameController.text);

    var url = APIS.registration;
    var param = {
      "name": userNameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "device_token": SharedManager.shared.token,
      "phone": phoneNumber.toString(),
      "latitude": latitude.toString(),
      "longitude": longitude.toString()
    };

    var manager = Requestmanager();
    var data = await manager.requestForUserRegistration(url, true, param);
    if (data.code == 1) {
      emailController.text = '';
      passwordController.text = '';
      // phoneController.text = '';
      userNameController.text = '';
      await SharedManager.shared.storeString("yes", "isLoogedIn");
      await SharedManager.shared.storeUserLoginData(data);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OTPVerificationPage(
              phoneNumber:
                  phoneNumber))); // passing phone number to the OTP SCREEN
    } else {
      Navigator.pop(context);
      SharedManager.shared.showAlertDialog(data.message, context);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(right: 20, left: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              controller: userNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '${S.current.full_name}'),
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
                        height: 25,
                      ),
                      Container(
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
                        height: 25,
                      ),
                      // Added the international Phone Number Input Field
                      Container(
                        child: InternationalPhoneInput(
                          onPhoneNumberChange: _onPhoneNumberChange,
                          initialPhoneNumber: phoneNumber,
                          initialSelection: "+91",
                          hintText: '${S.current.phone}',
                        ),
                      ),
                      SizedBox(
                        height: 25,
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      InkWell(
                        onTap: () {
                          var validator = SharedManager.shared
                              .validateEmail(emailController.text);

                          if (userNameController.text == "") {
                            SharedManager.shared.showAlertDialog(
                                S.current.not_a_valid_full_name, context);
                            return;
                          } else if (emailController.text == "" &&
                              validator == S.current.email) {
                            SharedManager.shared.showAlertDialog(
                                S.current.pleaseEnterEmail, context);
                            return;
                          } else if (phoneNumber == "") {
                            SharedManager.shared.showAlertDialog(
                                S.current.not_a_valid_phone, context);
                            return;
                          } else if (passwordController.text == "" &&
                              (passwordController.text.length < 5)) {
                            SharedManager.shared.showAlertDialog(
                                S.current.wrong_email_or_password, context);
                            return;
                          }
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              });
                          _actionMethodRegistration();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColor.themeColor,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: setCommonText('${S.current.register}',
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
                          setCommonText('${S.current.haveUnAccount}',
                              AppColor.grey, 14.0, FontWeight.w500, 1),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: setCommonText('${S.current.login}',
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

/*
return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Stack(
              children: <Widget>[
                new Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.background,
                    ),
                    fit: BoxFit.cover
                  )
                ),
              ),
              new Container(
                height: MediaQuery.of(context).size.height,
                color: AppColor.black.withOpacity(0.4),
              ),
                 new ListView(
              children: <Widget>[
                _setHeaderView(),
                _setFormView()
              ],
                ),
              ],
            ),
        ),
        routes: <String,WidgetBuilder>{
        AppRoute.signUp:(BuildContext context) => new SignUpPage()
        }
    );
 */

//AppID:ca-app-pub-8299041309330339~1673534621
