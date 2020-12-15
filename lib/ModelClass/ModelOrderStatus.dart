import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResOrderStatus extends BaseModel {
  int code;
  String message;
  OrderStatus result;

  ResOrderStatus({this.code, this.message, this.result});

  ResOrderStatus.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result = json['result'] != null
        ? new OrderStatus.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class OrderStatus {
  String orderStatus;
  DriverDetails driverDetails;

  OrderStatus({this.orderStatus, this.driverDetails});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    orderStatus = json['order_status'];
    driverDetails = json['driver_details'] != null
        ? new DriverDetails.fromJson(json['driver_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_status'] = this.orderStatus;
    if (this.driverDetails != null) {
      data['driver_details'] = this.driverDetails.toJson();
    }
    return data;
  }
}

class DriverDetails {
  String name;
  String image;
  String review;
  String phone;

  DriverDetails({this.name, this.image, this.review, this.phone});

  DriverDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    review = json['review'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['review'] = this.review;
    data['phone'] = this.phone;
    return data;
  }
}
