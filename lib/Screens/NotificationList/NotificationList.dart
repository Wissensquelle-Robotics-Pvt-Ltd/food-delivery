import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/NotificationListBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelNotificationList.dart';
import 'package:product/generated/i18n.dart';

void main() => runApp(new NotificationList());

class NotificationList extends StatefulWidget {
  @override
  _NotificationListState createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    notificationListBloc.fetchnotificationList(SharedManager.shared.userID);

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: AppColor.themeColor,
        title: setCommonText(
            S.current.notifications, AppColor.white, 20.0, FontWeight.w600, 1),
        elevation: 0.0,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColor.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: StreamBuilder(
          stream: notificationListBloc.notificationList,
          builder: (context, AsyncSnapshot<ResNotificationList> snapshot) {
            if (snapshot.hasData) {
              final result = snapshot.data.notificationList;
              if (result.length == 0) {
                return dataFound(
                    context,
                    "You don\'t have any single notification in your list",
                    AssetImage('Assets/images/bell.png'),
                    "1");
              } else {
                return new Container(
                  child: ListView.builder(
                      itemCount: result.length,
                      itemBuilder: (context, index) {
                        return new Container(
                          padding: new EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'Assets/images/bell.png'),
                                        fit: BoxFit.fill)),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              new Expanded(
                                  child: new Container(
                                padding: new EdgeInsets.only(
                                    left: 10, right: 10, top: 5, bottom: 5),
                                child: new Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    setCommonText(
                                        result[index].title,
                                        AppColor.black87,
                                        16.0,
                                        FontWeight.w500,
                                        1),
                                    SizedBox(height: 2),
                                    setCommonText(
                                        result[index].date,
                                        AppColor.grey,
                                        14.0,
                                        FontWeight.w400,
                                        1),
                                    SizedBox(height: 2),
                                    Row(
                                      children: <Widget>[
                                        setCommonText(
                                            '${S.current.order_Id}',
                                            AppColor.grey[800],
                                            14.0,
                                            FontWeight.w400,
                                            1),
                                        SizedBox(width: 2),
                                        setCommonText(
                                            "#${result[index].typeId}",
                                            AppColor.grey[700],
                                            14.0,
                                            FontWeight.w400,
                                            1),
                                      ],
                                    ),
                                    Divider()
                                  ],
                                ),
                              ))
                            ],
                          ),
                        );
                      }),
                );
              }
            } else {
              return new Center(child: new CircularProgressIndicator());
            }
          }),
    );
  }
}
