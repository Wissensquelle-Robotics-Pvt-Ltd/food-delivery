import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResRestaurantDetails extends BaseModel {
  int code;
  String message;
  ResDetails result;

  ResRestaurantDetails({this.code, this.message, this.result});

  ResRestaurantDetails.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result =
        json['result'] != null ? new ResDetails.fromJson(json['result']) : null;
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

class ResDetails {
  String restaurantId;
  String avgReview;
  String name;
  String email;
  String bannerImage;
  String phone;
  String address;
  String openingTime;
  String closingTime;
  String latitude;
  String longitude;
  String averagePrice;
  String discount;
  String discountType;
  String isAvailable;
  List<Reviews> reviews;
  List<Categories> categories;

  ResDetails(
      {this.restaurantId,
      this.avgReview,
      this.name,
      this.email,
      this.bannerImage,
      this.phone,
      this.address,
      this.openingTime,
      this.closingTime,
      this.latitude,
      this.longitude,
      this.averagePrice,
      this.discount,
      this.discountType,
      this.isAvailable,
      this.reviews,
      this.categories});

  ResDetails.fromJson(Map<String, dynamic> json) {
    restaurantId = json['restaurant_id'];
    avgReview = json['avg_review'];
    name = json['name'];
    email = json['email'];
    bannerImage = json['banner_image'];
    phone = json['phone'];
    address = json['address'];
    openingTime = json['opening_time'];
    closingTime = json['closing_time'];
    averagePrice = json['average_price'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    discount = json['discount'];
    discountType = json['discount_type'];
    isAvailable = json['is_available'];
    if (json['reviews'] != null) {
      reviews = new List<Reviews>();
      json['reviews'].forEach((v) {
        reviews.add(new Reviews.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['restaurant_id'] = this.restaurantId;
    data['avg_review'] = this.avgReview;
    data['name'] = this.name;
    data['email'] = this.email;
    data['banner_image'] = this.bannerImage;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['opening_time'] = this.openingTime;
    data['closing_time'] = this.closingTime;
    data['average_price'] = this.averagePrice;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['is_available'] = this.isAvailable;
    if (this.reviews != null) {
      data['reviews'] = this.reviews.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Reviews {
  String review;
  String message;
  String userName;
  String userImage;
  String city;
  String date;

  Reviews(
      {this.review,
      this.message,
      this.userImage,
      this.userName,
      this.city,
      this.date});

  Reviews.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    message = json['message'];
    userName = json['user_name'];
    userImage = json['user_image'];
    city = json['city'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review'] = this.review;
    data['message'] = this.message;
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    data['city'] = this.city;
    data['date'] = this.date;
    return data;
  }
}

class Categories {
  String categoryName;
  String categoryId;
  bool isGrid = false;
  List<Subcategories> subcategories;

  Categories(
      {this.categoryName, this.categoryId, this.subcategories, this.isGrid});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryId = json['category_id'];
    isGrid = false;
    if (json['subcategories'] != null) {
      subcategories = new List<Subcategories>();
      json['subcategories'].forEach((v) {
        subcategories.add(new Subcategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['category_id'] = this.categoryId;
    if (this.subcategories != null) {
      data['subcategories'] =
          this.subcategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategories {
  String id;
  String name;
  String catigoryName = '';
  String extraNote = '';
  String image;
  String price;
  String discount;
  String discountType;
  String type;
  String description;
  String isAvailable;
  bool isAdded;
  int count = 1;

  Subcategories(
      {this.id,
      this.name,
      this.catigoryName,
      this.extraNote,
      this.image,
      this.price,
      this.discount,
      this.discountType,
      this.type,
      this.description,
      this.isAvailable,
      this.isAdded,
      this.count});

  Subcategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    price = json['price'];
    discount = json['discount'];
    discountType = json['discount_type'];
    type = json['type'];
    description = json['description'];
    isAvailable = json['is_available'];
    isAdded = false;
    count = this.count;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['isAdded'] = this.isAdded;
    data['count'] = this.count;
    data['is_available'] = this.isAvailable;
    data['type'] = this.type;
    data['description'] = this.description;

    return data;
  }
}
