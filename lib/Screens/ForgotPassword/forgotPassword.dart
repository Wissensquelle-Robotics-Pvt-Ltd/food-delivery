import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/generated/i18n.dart';

void main() => runApp(ForgotPassword());

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
//set widgets

  TextEditingController emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _setNavigationBar() {
    return new Column(
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Container(
              height: 50,
              width: 50,
              child: new Center(
                child: new IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: AppColor.themeColor),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            )
          ],
        ),
        new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            setCommonText(S.current.forgotPassword, AppColor.black87, 30.0,
                FontWeight.w800, 1),
            SizedBox(
              height: 20,
            ),
            setCommonText(S.current.pleaseEnterEmail, AppColor.black87, 20.0,
                FontWeight.w500, 1),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${S.current.receivedNewPasswordOnMail}',
                style: TextStyle(
                    fontFamily: SharedManager.shared.fontFamilyName,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: AppColor.black54),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ],
    );
  }

  _setEmailWidgets() {
    return new Container(
      padding: new EdgeInsets.all(20),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          new TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: S.current.email_address),
            style: TextStyle(fontFamily: SharedManager.shared.fontFamilyName),
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 50,
          ),
          new Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            child: InkWell(
              onTap: () {
                _forgotPassword(emailController.text).then((value) {
                  _scaffoldKey.currentState.hideCurrentSnackBar();
                  if (value) {
                    SharedManager.shared.showAlertDialog(
                        '${S.current.newPasswordSent}', context);
                  }
                });
              },
              child: new Material(
                  color: AppColor.themeColor,
                  elevation: 2.0,
                  borderRadius: BorderRadius.circular(25),
                  child: new Center(
                      child: setCommonText(S.current.submit, AppColor.white,
                          18.0, FontWeight.w500, 1))),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _forgotPassword(String email) async {
    final emailStr = SharedManager.shared.validateEmail(email);
    if (emailController.text == "") {
      SharedManager.shared
          .showAlertDialog('${S.current.enterEmailFirst}', context);
      return false;
    } else if (emailStr == '${S.current.validEmail}') {
      SharedManager.shared
          .showAlertDialog('${S.current.inValidEmail}', context);
      return false;
    }
    showSnackbar('${S.current.loading}', _scaffoldKey);

    final param = {'email': email};

    Requestmanager manager = Requestmanager();
    bool status = false;
    await manager.forgotPassword(param, context).then((value) {
      status = value;
    });
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: new ListView(
        children: <Widget>[_setNavigationBar(), _setEmailWidgets()],
      ),
    );
  }
}
