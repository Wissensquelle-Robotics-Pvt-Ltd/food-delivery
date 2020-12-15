import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/generated/i18n.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: AppColor.themeColor,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('Assets/images/mail.png'))),
                    ),
                    SizedBox(height: 5),
                    setCommonText(S.current.contactUs, AppColor.white, 20.0,
                        FontWeight.bold, 1)
                  ],
                ),
              )),
          Expanded(
              flex: 7,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.red,
                  padding: new EdgeInsets.all(40),
                  child: Column(
                    children: <Widget>[],
                  )))
        ],
      ),
    );
  }
}
