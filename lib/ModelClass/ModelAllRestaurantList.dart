import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResAllRestaurantList extends BaseModel {
  int code;
  String message;
  List<Restaurant> allRestaurants;

  ResAllRestaurantList({this.code, this.message, this.allRestaurants});

  ResAllRestaurantList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      allRestaurants = new List<Restaurant>();
      json['result'].forEach((v) {
        allRestaurants.add(new Restaurant.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.allRestaurants != null) {
      data['result'] = this.allRestaurants.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurant {
  String id;
  String name;
  String image;
  String address;
  String discount;
  String latitude;
  String longitude;
  String discountType;
  String review;
  String isAvailable;

  Restaurant(
      {this.id,
      this.name,
      this.image,
      this.address,
      this.discount,
      this.latitude,
      this.longitude,
      this.review,
      this.isAvailable,
      this.discountType});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    address = json['address'];
    discount = json['discount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    review = json['review'];
    isAvailable = json['is_available'];
    discountType = json['discount_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['address'] = this.address;
    data['discount'] = this.discount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['review'] = this.review;
    data['is_available'] = this.isAvailable;
    data['discount_type'] = this.discountType;
    return data;
  }
}
