import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResSearchResult extends BaseModel{
  int code;
  String message;
  SearchResult result;

  ResSearchResult({this.code, this.message, this.result});

  ResSearchResult.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result =
        json['result'] != null ? new SearchResult.fromJson(json['result']) : null;
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

class SearchResult {
  List<Restaurents> restaurents;
  List<MealDeal> mealDeal;

  SearchResult({this.restaurents, this.mealDeal});

  SearchResult.fromJson(Map<String, dynamic> json) {
    if (json['restaurents'] != null) {
      restaurents = new List<Restaurents>();
      json['restaurents'].forEach((v) {
        restaurents.add(new Restaurents.fromJson(v));
      });
    }
    if (json['mealDeal'] != null) {
      mealDeal = new List<MealDeal>();
      json['mealDeal'].forEach((v) {
        mealDeal.add(new MealDeal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.restaurents != null) {
      data['restaurents'] = this.restaurents.map((v) => v.toJson()).toList();
    }
    if (this.mealDeal != null) {
      data['mealDeal'] = this.mealDeal.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurents {
  String id;
  String name;
  String image;
  String address;
  String discount;
  String latitude;
  String longitude;
  String discountType;

  Restaurents(
      {this.id,
      this.name,
      this.image,
      this.address,
      this.discount,
      this.latitude,
      this.longitude,
      this.discountType});

  Restaurents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    address = json['address'];
    discount = json['discount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
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
    data['discount_type'] = this.discountType;
    return data;
  }
}

class MealDeal {
  String id;
  String name;
  String restaurantName;
  String image;
  String price;
  String discount;
  String latitude;
  String longitude;
  String discountType;

  MealDeal(
      {this.id,
      this.name,
      this.restaurantName,
      this.image,
      this.price,
      this.discount,
      this.latitude,
      this.longitude,
      this.discountType});

  MealDeal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    restaurantName = json['restaurant_name'];
    image = json['image'];
    price = json['price'];
    discount = json['discount'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    discountType = json['discount_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['restaurant_name'] = this.restaurantName;
    data['image'] = this.image;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['discount_type'] = this.discountType;
    return data;
  }
}
