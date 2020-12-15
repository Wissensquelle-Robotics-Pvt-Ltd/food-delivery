import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResAddOrder extends BaseModel{
  int code;
  String message;
  List<DataSuccess> checkoutData;

  ResAddOrder({this.code, this.message, this.checkoutData});

  ResAddOrder.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      checkoutData = new List<DataSuccess>();
      json['result'].forEach((v) {
        checkoutData.add(new DataSuccess.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.checkoutData != null) {
      data['result'] = this.checkoutData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSuccess {
  String type;
  String orderId;

  DataSuccess({this.type, this.orderId});

  DataSuccess.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['orderId'] = this.orderId;
    return data;
  }
}
