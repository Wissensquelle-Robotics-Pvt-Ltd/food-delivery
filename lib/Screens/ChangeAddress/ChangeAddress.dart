import 'dart:async';
import 'package:flutter/material.dart';
import 'package:product/BlocClass/MainModelBlocClass/AddressListBloc.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/ModelClass/ModelAddressList.dart';
import 'package:product/Screens/AddNewAddress/AddNewAddress.dart';
import 'package:product/generated/i18n.dart';

void main() => runApp(new ChangeAddress());

class ChangeAddress extends StatefulWidget {
  @override
  _ChangeAddressState createState() => _ChangeAddressState();
}

class _ChangeAddressState extends State<ChangeAddress> {
  bool isDeleteAddress = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _setSavedAddressWidgets() {
    return new Container(
      // height: 80,
      // color: Colors.red,
      padding: new EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          new GestureDetector(
            onTap: () async {
              final status = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddNewAddress()));
              if (status != null) {
                setState(() {
                  _setSnackBar();
                });
              }
            },
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    new Icon(Icons.add, color: Colors.black, size: 20),
                    SizedBox(
                      width: 5,
                    ),
                    setCommonText(S.current.add_delivery_address, Colors.black,
                        15.0, FontWeight.w500, 1),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                setCommonText(
                    'We have disabled address validation.You can order any address as of now for testing purpose.',
                    AppColor.red,
                    14.0,
                    FontWeight.w400,
                    3)
              ],
            ),
          ),
          new SizedBox(
            height: 5,
          ),
          new Divider()
        ],
      ),
    );
  }

  _setSnackBar() {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        content: setCommonText(S.current.please_wait_for_address,
            AppColor.white, 17.0, FontWeight.w500, 2)));
  }

  _setAddressCardWidgets(AddressDetails address) {
    return new GestureDetector(
      onTap: () {
        print("${address.addressLine1}");

        //Firt check Distace between Restaurant and Delivery Address.
        //Distance should be less than 15 kms.

        SharedManager.shared.address = address.addressLine1;
        SharedManager.shared.addressId = address.id;
        SharedManager.shared.deliveryAddressNumber = address.phone;
        SharedManager.shared.deliveryAddressName = address.name;
        Navigator.of(context).pop(true);

        // double totalDistance = SharedManager.shared.calculateDistance(
        //     double.parse(address.latitude),
        //     double.parse(address.longitude),
        //     double.parse(SharedManager.shared.resLatitude),
        //     double.parse(SharedManager.shared.resLongitude));
        // print(totalDistance);
        // if (totalDistance <= SharedManager.shared.distanceFilter) {
        //   SharedManager.shared.address = address.addressLine1;
        //   SharedManager.shared.addressId = address.id;
        //   SharedManager.shared.deliveryAddressNumber = address.phone;
        //   SharedManager.shared.deliveryAddressName = address.name;
        //   Navigator.of(context).pop(true);
        // } else {
        //   SharedManager.shared
        //       .showAlertDialog(S.current.delivery_not_availablel, context);
        //   return;
        // }
      },
      child: new Container(
        // height: 140,
        width: MediaQuery.of(context).size.width,
        padding: new EdgeInsets.only(left: 15, right: 15),
        // color: Colors.green,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            setCommonText(
                S.current.delivert_to, Colors.grey, 14.0, FontWeight.w500, 1),
            new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                setCommonText(_setAddressType(address.addressType),
                    Colors.black, 14.0, FontWeight.w700, 1),
                new IconButton(
                  icon: Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 20,
                  ),
                  onPressed: () async {
                    setState(() {
                      this.isDeleteAddress = true;
                    });
                    print('You have clicked on cross');
                    final status = await this._deleteAddress(address.id);
                    // Navigator.of(context).pop(true);
                    print("status ===>$status");
                    if (status) {
                      setState(() {
                        this.isDeleteAddress = false;
                      });
                    } else {
                      SharedManager.shared.showAlertDialog(
                          "Address not deleted please try again.", context);
                    }
                  },
                ),
              ],
            ),
            setCommonText(address.name, Colors.grey, 12.0, FontWeight.w400, 1),
            SizedBox(
              height: 3,
            ),
            setCommonText(address.phone, Colors.grey, 12.0, FontWeight.w400, 1),
            SizedBox(
              height: 5,
            ),
            setCommonText(
                address.addressLine1, Colors.grey, 12.0, FontWeight.w400, 2),
            Divider(
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _deleteAddress(String addressId) async {
    final manager = Requestmanager();
    final status = await manager.deleteAddress(APIS.deleteAddress, addressId);
    return status;
  }

  String _setAddressType(String type) {
    if (type == "0") {
      return S.current.home;
    } else if (type == "1") {
      return S.current.office;
    } else {
      return S.current.other;
    }
  }

  @override
  void dispose() {
    super.dispose();
    // addressListBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    (this.isDeleteAddress)
        ? new Text('')
        : addressListBloc.fetchAddressList(
            APIS.addressList, SharedManager.shared.userID);
    return new Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        leading: new IconButton(
          icon: Icon(Icons.arrow_back, color: AppColor.white),
          onPressed: () {
            Navigator.of(context).pop(false);
          },
        ),
        backgroundColor: AppColor.themeColor,
        title: setCommonText(
            S.current.select_address, AppColor.white, 20.0, FontWeight.w600, 1),
        elevation: 0.0,
      ),
      body: (this.isDeleteAddress)
          ? new Center(child: new CircularProgressIndicator())
          : new StreamBuilder(
              stream: addressListBloc.addressList,
              builder: (context, AsyncSnapshot<ResAddressList> snapshot) {
                if (snapshot.hasData) {
                  final addressList = snapshot.data.addressList;
                  return new Container(
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        _setSavedAddressWidgets(),
                        new Expanded(
                            child: new Container(
                          child: new ListView.builder(
                            itemCount: addressList.length,
                            itemBuilder: (context, index) {
                              return _setAddressCardWidgets(addressList[index]);
                            },
                          ),
                        ))
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return new Center(
                    child: new CircularProgressIndicator(),
                  );
                } else {
                  return new Center(
                    child: new CircularProgressIndicator(),
                  );
                }
              }),
    );
  }
}
