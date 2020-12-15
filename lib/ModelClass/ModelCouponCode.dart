import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResCouponCode extends BaseModel {
  int code;
  String message;
  CouponData data;

  ResCouponCode({this.code, this.message, this.data});

  ResCouponCode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new CouponData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class CouponData {
  String discountType;
  String discount;

  CouponData({this.discountType, this.discount});

  CouponData.fromJson(Map<String, dynamic> json) {
    discountType = json['discount_type'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    return data;
  }
}
