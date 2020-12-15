import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:product/BlocClass/MainModelBlocClass/UserProfileBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelProfileData.dart';
import 'Widgets/ProfileWidgets.dart';
import 'Widgets/RecentOrderWidget.dart';

void main() => runApp(new ProfileScreen());

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static var name = "";
  static var email = "";
  static var image = "";

  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    _getUserStoredData();
  }

  _getUserStoredData() async {
    name = await SharedManager.shared.userName();
    email = await SharedManager.shared.userEmail();
    image = await SharedManager.shared.userImage();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    (SharedManager.shared.isLoggedIN == 'yes')
        ? userProfileBloc.fetchProfileData(SharedManager.shared.userID)
        : new Text('');
    return new Scaffold(
      primary: false,
      appBar: new EmptyAppBar(),
      body: (SharedManager.shared.isLoggedIN == 'yes')
          ? StreamBuilder(
              stream: userProfileBloc.profileData,
              builder: (context, AsyncSnapshot<ResProfileData> snapshot) {
                if (snapshot.hasData) {
                  final result = snapshot.data.result.orders;
                  name = snapshot.data.result.name;
                  email = snapshot.data.result.email;
                  image = snapshot.data.result.profileImage;
                  return new Container(
                    color: AppColor.white,
                    child: new ListView(
                      children: <Widget>[
                        ProfileWidgets(
                            name,
                            email,
                            image,
                            snapshot.data.result.wallet,
                            snapshot.data.result.phone,
                            snapshot.data.result.totalOrder),
                        ProfileListWidget(),
                        RecentOrderWidgets(result)
                      ],
                    ),
                  );
                } else {
                  return new Center(
                    child: new CircularProgressIndicator(),
                  );
                }
              },
            )
          : LoginScreen(),
    );
  }
}
