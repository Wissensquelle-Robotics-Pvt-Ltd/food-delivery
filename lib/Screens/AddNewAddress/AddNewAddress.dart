import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:product/Helper/CommonWidgets.dart';
import 'package:product/Helper/Constant.dart';
import 'package:product/Helper/RequestManager.dart';
import 'package:product/Helper/SharedManaged.dart';
import 'package:product/generated/i18n.dart';

void main() => runApp(new AddNewAddress());

class AddNewAddress extends StatefulWidget {
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  static TextEditingController nameController = new TextEditingController();
  static TextEditingController phoneController = new TextEditingController();
  static TextEditingController pinCodeController = new TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  bool isLocation = false;

  double latitude = 0;
  double longitude = 0;
  var strAddress = "";

  bool valOffice = false;
  bool valHome = false;
  bool valOther = false;

  var userid = "";
  var addressline_1 = "";
  var addressline_2 = "";
  var pincode = "";
  var lat = "";
  var long = "";
  var city = "";
  var state = "";
  var country = "";
  var isDefault = "";
  var addresstype = "";
  var name = "";
  var phone = "";
  var type = 0;

  var address = "";
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: Keys.kGoogleApiKey);

  @override
  void initState() {
    super.initState();
    _getLocation();
    _setLocationStatus(0);
  }

  bool _setLocationStatus(int index) {
    switch (index) {
      case 0:
        valOffice = false;
        valOther = false;
        return valHome = true;
        break;
      case 1:
        valOffice = true;
        valOther = false;
        valHome = false;
        return valOffice;
        break;
      case 2:
        valHome = false;
        valOther = true;
        valOffice = false;
        return valOther;
        break;
      default:
        return false;
        break;
    }
  }

  _setGoogleMap() {
    // Completer<GoogleMapController> _controller = Completer();
    // final CameraPosition _kGooglePlex = CameraPosition(
    //   target:
    //       LatLng(SharedManager.shared.latitude, SharedManager.shared.longitude),
    //   zoom: 14.4746,
    // );

    Set<Marker> markers = Set();
    markers.addAll([
      Marker(
          markerId: MarkerId('value'),
          position: LatLng(22.315845, 73.1697058),
          draggable: true,
          onDragEnd: ((value) {
            print(value.latitude);
            print(value.longitude);
            // _getAdd(value.latitude,value.longitude);
          })),
    ]);
    return Column(
      children: <Widget>[
        new Expanded(
            child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('Assets/map.png'))),
        ))
      ],
    );
  }

  _getLocation() async {
    final coordinate = await SharedManager.shared.getLocationCoordinate();
    this.latitude = coordinate.latitude;
    this.longitude = coordinate.longitude;

    _getAddressFromCurrentLocation(
        await SharedManager.shared.getLocationCoordinate());
  }

  _getAddressFromCurrentLocation(LatLng coordinate) async {
    // var coordinate = await SharedManager.shared.getLocationCoordinate();
    print("Stored Location:$coordinate");

    final coordinates =
        new Coordinates(coordinate.latitude, coordinate.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print('${first.addressLine}, ${first.featureName}');
    print(first);

    this.country = first.countryName;
    this.city = first.locality;
    this.state = first.adminArea;
    this.lat = coordinate.latitude.toString();
    this.long = coordinate.longitude.toString();
    this.addressline_1 = first.addressLine;
    this.addressline_2 = first.featureName;
    this.pincode = first.postalCode;

    setState(() {
      if (first.addressLine != null) {
        this.address = first.addressLine;
      }
      if (first.featureName != null) {
        this.address = this.address + " " + first.featureName;
      }
      print("Final Address:---->$address");
      SharedManager.shared.address = address;
    });
  }

  @override
  void dispose() {
    super.dispose();
    //this method not called when user press android back button or quit

    print('dispose');
  }

  Future<Null> displayPrediction(var p) async {
    if (p != null) {
      var detail = await _places.getDetailsByPlaceId(p.placeId);

      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      setState(() {
        final currentLocation = LatLng(lat, lng);
        _getAddressFromCurrentLocation(currentLocation);
      });
    }
  }

  Future<bool> _saveAddress() async {
    if (nameController.text == "") {
      return false;
    } else if (phoneController.text == "") {
      return false;
    } else if (addressline_1 == "") {
      return false;
    } else if (pinCodeController.text == "") {
      return false;
    }

    var param = {
      "user_id": SharedManager.shared.userID,
      "address_line_1": this.addressline_1,
      "address_line_2": this.addressline_2,
      "pincode": pinCodeController.text,
      "latitude": this.lat,
      "longitude": this.long,
      "city": this.city,
      "state": this.state,
      "country": this.country,
      "name": nameController.text,
      "phone": phoneController.text,
      "isDefault": 0,
      "address_type": this.type
    };

    print("Address Parameters:$param");
    final manger = Requestmanager();
    final status = await manger.addNewAddress(APIS.addNewAddress, param);
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: EmptyAppBar(),
      primary: false,
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      body: new Container(
        color: Colors.white,
        child: new ListView(
          children: <Widget>[
            new Container(
              height: 200,
              child: new Stack(
                children: <Widget>[
                  _setGoogleMap(),
                  new Padding(
                    padding: new EdgeInsets.only(top: 8),
                    child: new Align(
                      alignment: Alignment.topLeft,
                      child: new IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            new Container(
              // color: Colors.green,
              height: 600,
              child: new Container(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                            height: 30,
                            padding: new EdgeInsets.only(left: 10, top: 5),
                            // color: Colors.yellow,
                            child: setCommonText(S.current.add_delivery_address,
                                Colors.black, 20.0, FontWeight.w600, 1)),
                        Divider(),
                      ],
                    ),
                    new Expanded(
                      child: new Container(
                        // color: Colors.pink,
                        padding: new EdgeInsets.all(10),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            setCommonText(S.current.current_location,
                                AppColor.themeColor, 18.0, FontWeight.w500, 1),
                            SizedBox(height: 3),
                            GestureDetector(
                              onTap: () async {
                                Prediction p = await PlacesAutocomplete.show(
                                    context: context,
                                    apiKey: Keys.kGoogleApiKey);
                                this.displayPrediction(p);
                              },
                              child: new Row(
                                children: <Widget>[
                                  new Expanded(
                                    flex: 1,
                                    child: new Container(
                                        child: new Align(
                                      alignment: Alignment.center,
                                      child: new Icon(Icons.check_circle,
                                          color: Colors.green, size: 20),
                                    )),
                                  ),
                                  new SizedBox(
                                    width: 5,
                                  ),
                                  new Expanded(
                                    flex: 6,
                                    child: new Container(
                                      child: new Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          setCommonText(
                                              this.address,
                                              Colors.black,
                                              15.0,
                                              FontWeight.w500,
                                              2),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            new Container(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  setCommonText(S.current.pinCode, Colors.grey,
                                      16.0, FontWeight.w500, 1),
                                  new TextFormField(
                                    controller: pinCodeController,
                                    decoration: InputDecoration(
                                      hintText: S.current.pinCode,
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            new Container(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  setCommonText(S.current.full_name,
                                      Colors.grey, 16.0, FontWeight.w500, 1),
                                  new TextFormField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: S.current.your_name,
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 5),
                            new Container(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  setCommonText(S.current.current_number,
                                      Colors.grey, 16.0, FontWeight.w500, 1),
                                  new TextFormField(
                                    controller: phoneController,
                                    decoration: InputDecoration(
                                      hintText: S.current.number,
                                      hintStyle: TextStyle(color: Colors.grey),
                                    ),
                                    style: new TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            signed: true, decimal: true),
                                  )
                                ],
                              ),
                            ),
                            new Container(
                              // height: 60,
                              // color:Colors.red,
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  new Row(
                                    children: <Widget>[
                                      new Checkbox(
                                        value: this.valHome,
                                        onChanged: (value) {
                                          setState(() {
                                            this.type = 0;
                                            _setLocationStatus(0);
                                          });
                                        },
                                      ),
                                      setCommonText(S.current.home, Colors.grey,
                                          14.0, FontWeight.w500, 1),
                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new Checkbox(
                                        value: this.valOffice,
                                        onChanged: (value) {
                                          setState(() {
                                            this.type = 1;
                                            _setLocationStatus(1);
                                          });
                                        },
                                      ),
                                      setCommonText(
                                          S.current.office,
                                          Colors.grey,
                                          14.0,
                                          FontWeight.w500,
                                          1),
                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      new Checkbox(
                                        value: this.valOther,
                                        onChanged: (value) {
                                          setState(() {
                                            this.type = 2;
                                            _setLocationStatus(2);
                                          });
                                        },
                                      ),
                                      setCommonText(
                                          S.current.other,
                                          Colors.grey,
                                          14.0,
                                          FontWeight.w500,
                                          1),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            new Container(
                              padding: new EdgeInsets.only(
                                  left: 20, right: 20, top: 5, bottom: 5),
                              height: 65,
                              width: MediaQuery.of(context).size.width,
                              // color: Colors.red,
                              child: new InkWell(
                                onTap: () async {
                                  showSnackbar(S.current.loading, _scaffoldKey);

                                  final status = await _saveAddress();
                                  print("status ===>$status");
                                  if (status) {
                                    pinCodeController.text = "";
                                    nameController.text = "";
                                    phoneController.text = "";
                                    Navigator.of(context).pop(true);
                                  } else {
                                    //  Navigator.of(context).pop(true);
                                    _scaffoldKey.currentState
                                        .hideCurrentSnackBar();
                                    SharedManager.shared.showAlertDialog(
                                        S.current.pleaseCheckAllFields,
                                        context);
                                  }
                                },
                                child: new Material(
                                  color: Colors.green,
                                  elevation: 2.0,
                                  child: new Center(
                                    child: setCommonText(S.current.save_address,
                                        Colors.white, 18.0, FontWeight.w600, 1),
                                  ),
                                  borderRadius: new BorderRadius.circular(8),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
