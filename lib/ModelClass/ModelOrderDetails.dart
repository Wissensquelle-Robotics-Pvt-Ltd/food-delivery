import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResOrderDetails extends BaseModel {
  int code;
  String message;
  Details orderDetails;

  ResOrderDetails({this.code, this.message, this.orderDetails});

  ResOrderDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    orderDetails =
        json['result'] != null ? new Details.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.orderDetails != null) {
      data['result'] = this.orderDetails.toJson();
    }
    return data;
  }
}

class Details {
  String orderId;
  String driverId;
  String isReview;
  String name;
  String bannerImage;
  String address;
  String date;
  String totalPrice;
  String tipPrice;
  String discountPrice;
  String paymentType;
  String orderStatus;
  String phone;
  String deliveryAddress;
  String restaurantId;
  String latitude;
  String longitude;
  List<Products> products;

  Details(
      {this.orderId,
      this.driverId,
      this.isReview,
      this.name,
      this.bannerImage,
      this.address,
      this.date,
      this.totalPrice,
      this.tipPrice,
      this.discountPrice,
      this.paymentType,
      this.orderStatus,
      this.phone,
      this.deliveryAddress,
      this.products,
      this.latitude,
      this.longitude,
      this.restaurantId});

  Details.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    driverId = json['driver_id'];
    restaurantId = json['restaurant_id'];
    isReview = json['isReviewed'];
    name = json['name'];
    bannerImage = json['banner_image'];
    address = json['address'];
    date = json['date'];
    totalPrice = json['total_price'];
    tipPrice = json['tip_price'];
    discountPrice = json['discount_price'];
    paymentType = json['payment_type'];
    orderStatus = json['order_status'];
    phone = json['phone'];
    deliveryAddress = json['delivery_address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['restaurant_id'] = this.restaurantId;
    data['name'] = this.name;
    data['banner_image'] = this.bannerImage;
    data['address'] = this.address;
    data['date'] = this.date;
    data['total_price'] = this.totalPrice;
    data['tip_price'] = this.tipPrice;
    data['discount_price'] = this.discountPrice;
    data['payment_type'] = this.paymentType;
    data['order_status'] = this.orderStatus;
    data['phone'] = this.phone;
    data['delivery_address'] = this.deliveryAddress;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String productName;
  String productPrice;
  String extraNote;
  String productQuantity;
  String productId;
  String type;
  String discount;
  String price;
  String description;
  String image;

  Products(
      {this.productName,
      this.productPrice,
      this.extraNote,
      this.productQuantity,
      this.productId,
      this.type,
      this.discount,
      this.price,
      this.description,
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productPrice = json['product_price'];
    extraNote = json['extra_note'];
    productQuantity = json['product_quantity'];
    productId = json['product_id'];
    type = json['type'];
    discount = json['discount'];
    price = json['price'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_price'] = this.productPrice;
    data['extra_note'] = this.extraNote;
    data['product_quantity'] = this.productQuantity;
    data['product_id'] = this.productId;
    data['type'] = this.type;
    data['discount'] = this.discount;
    data['price'] = this.price;
    data['description'] = this.description;
    data['image'] = this.image;
    return data;
  }
}
