import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResProfileData extends BaseModel {
  int code;
  String message;
  ResultProfile result;

  ResProfileData({this.code, this.message, this.result});

  ResProfileData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result = json['result'] != null
        ? new ResultProfile.fromJson(json['result'])
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

class ResultProfile {
  String userId;
  String name;
  String email;
  String profileImage;
  String phone;
  String wallet;
  String totalOrder;
  List<RecentOrders> orders;

  ResultProfile(
      {this.userId,
      this.name,
      this.email,
      this.profileImage,
      this.phone,
      this.wallet,
      this.totalOrder,
      this.orders});

  ResultProfile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    phone = json['phone'];
    wallet = json['wallet_amount'];
    totalOrder = json['total_orders'];
    if (json['orders'] != null) {
      orders = new List<RecentOrders>();
      json['orders'].forEach((v) {
        orders.add(new RecentOrders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['profile_image'] = this.profileImage;
    data['wallet_amount'] = this.wallet;
    data['phone'] = this.phone;
    data['total_orders'] = this.totalOrder;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecentOrders extends BaseModel {
  String name;
  String bannerImage;
  String address;
  String orderId;
  String orderStatus;
  String totalPrice;
  String created;
  String review;

  RecentOrders({
    this.name,
    this.bannerImage,
    this.address,
    this.orderId,
    this.orderStatus,
    this.totalPrice,
    this.created,
    this.review,
  });

  RecentOrders.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    bannerImage = json['banner_image'];
    address = json['address'];
    orderId = json['order_id'];
    orderStatus = json['order_status'];
    totalPrice = json['total_price'];
    created = json['created'];
    review = json['review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['banner_image'] = this.bannerImage;
    data['address'] = this.address;
    data['order_id'] = this.orderId;
    data['order_status'] = this.orderStatus;
    data['total_price'] = this.totalPrice;
    data['created'] = this.created;
    data['review'] = this.review;
    return data;
  }
}
