import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';



class ResAddressList extends BaseModel {
  int code;
  String message;
  List<AddressDetails> addressList;

  ResAddressList({this.code, this.message, this.addressList});

  ResAddressList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      addressList = new List<AddressDetails>();
      json['result'].forEach((v) {
        addressList.add(new AddressDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.addressList != null) {
      data['result'] = this.addressList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressDetails {
  String id;
  String name;
  String phone;
  String addressLine1;
  String addressLine2;
  String pincode;
  String latitude;
  String longitude;
  String city;
  String state;
  String country;
  String isDefault;
  String addressType;

  AddressDetails(
      {this.id,
      this.name,
      this.phone,
      this.addressLine1,
      this.addressLine2,
      this.pincode,
      this.latitude,
      this.longitude,
      this.city,
      this.state,
      this.country,
      this.isDefault,
      this.addressType});

  AddressDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    addressLine1 = json['address_line_1'];
    addressLine2 = json['address_line_2'];
    pincode = json['pincode'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    isDefault = json['isDefault'];
    addressType = json['address_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address_line_1'] = this.addressLine1;
    data['address_line_2'] = this.addressLine2;
    data['pincode'] = this.pincode;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['isDefault'] = this.isDefault;
    data['address_type'] = this.addressType;
    return data;
  }
}
