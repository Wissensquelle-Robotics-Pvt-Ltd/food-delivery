import 'dart:io';

import 'package:flutter/material.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/generated/i18n.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: setCommonText('${S.current.editProfile}', AppColor.white, 20.0,
              FontWeight.w500, 1),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading: IconButton(
              icon: Icon(
                Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
                color: AppColor.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ),
        body: Container(
          color: AppColor.white,
          child: ListView(
            children: <Widget>[
              Container(
                height: 180,
                child: Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(width: 3, color: AppColor.grey[300]),
                        borderRadius: BorderRadius.circular(50)),
                    child: Stack(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 100,
                          backgroundImage: AssetImage('Assets/jacMa.jpg'),
                        ),
                        Positioned(
                            bottom: 3,
                            right: 3,
                            child: Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColor.themeColor,
                                  border: Border.all(
                                      width: 2, color: AppColor.grey[300])),
                              child: Icon(
                                Icons.edit,
                                size: 12,
                                color: AppColor.white,
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                // color: AppColor.red,
                padding: new EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppColor.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          setCommonText('${S.current.fullName}',
                              AppColor.black87, 15.0, FontWeight.w500, 1),
                          TextFormField(
                            decoration: InputDecoration(hintText: 'Jec Ma'),
                            style: TextStyle(
                                color: AppColor.black87,
                                fontFamily:
                                    SharedManager.shared.fontFamilyName),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppColor.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          setCommonText('${S.current.mobileNo}',
                              AppColor.black87, 15.0, FontWeight.w500, 1),
                          TextFormField(
                            decoration:
                                InputDecoration(hintText: '+9123456789'),
                            style: TextStyle(
                                color: AppColor.black87,
                                fontFamily:
                                    SharedManager.shared.fontFamilyName),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: AppColor.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          setCommonText('${S.current.email}', AppColor.black87,
                              15.0, FontWeight.w500, 1),
                          TextFormField(
                            enabled: false,
                            decoration:
                                InputDecoration(hintText: 'jcm@gmail.com'),
                            style: TextStyle(
                                color: AppColor.black87,
                                fontFamily:
                                    SharedManager.shared.fontFamilyName),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      height: 40,
                      width: 120,
                      decoration: BoxDecoration(
                          color: AppColor.themeColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: setCommonText('${S.current.update}',
                            AppColor.white, 17.0, FontWeight.w500, 1),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
