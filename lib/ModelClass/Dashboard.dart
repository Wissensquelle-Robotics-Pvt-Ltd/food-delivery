import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class Dashboard extends BaseModel {
  int code;
  String message;
  RestaurantLists result;

  Dashboard({this.code, this.message, this.result});

  Dashboard.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result = json['result'] != null
        ? new RestaurantLists.fromJson(json['result'])
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

class RestaurantLists {
  List<CouponCodes> couponCodes;
  List<Categories> categories;
  List<BannerRestaurent> bannerRestaurents;
  List<TopRestaurents> topRestaurents;
  List<PopularRestaurents> popularRestaurents;
  List<MealDeal> mealDeal;

  RestaurantLists(
      {this.couponCodes,
      this.categories,
      this.bannerRestaurents,
      this.topRestaurents,
      this.popularRestaurents,
      this.mealDeal});

  RestaurantLists.fromJson(Map<String, dynamic> json) {
    if (json['coupon_codes'] != null) {
      couponCodes = new List<CouponCodes>();
      json['coupon_codes'].forEach((v) {
        couponCodes.add(new CouponCodes.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    if (json['bannerRestaurents'] != null) {
      bannerRestaurents = new List<BannerRestaurent>();
      json['bannerRestaurents'].forEach((v) {
        bannerRestaurents.add(new BannerRestaurent.fromJson(v));
      });
    }
    if (json['topRestaurents'] != null) {
      topRestaurents = new List<TopRestaurents>();
      json['topRestaurents'].forEach((v) {
        topRestaurents.add(new TopRestaurents.fromJson(v));
      });
    }
    if (json['popularRestaurents'] != null) {
      popularRestaurents = new List<PopularRestaurents>();
      json['popularRestaurents'].forEach((v) {
        popularRestaurents.add(new PopularRestaurents.fromJson(v));
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
    if (this.couponCodes != null) {
      data['coupon_codes'] = this.couponCodes.map((v) => v.toJson()).toList();
    }
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    if (this.bannerRestaurents != null) {
      data['bannerRestaurents'] =
          this.bannerRestaurents.map((v) => v.toJson()).toList();
    }
    if (this.topRestaurents != null) {
      data['topRestaurents'] =
          this.topRestaurents.map((v) => v.toJson()).toList();
    }
    if (this.popularRestaurents != null) {
      data['popularRestaurents'] =
          this.popularRestaurents.map((v) => v.toJson()).toList();
    }
    if (this.mealDeal != null) {
      data['mealDeal'] = this.mealDeal.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CouponCodes {
  String couponCode;
  String image;
  String id;
  String description;
  String startDate;
  String endDate;
  String discount;
  String discountType;

  CouponCodes(
      {this.couponCode,
      this.image,
      this.id,
      this.description,
      this.startDate,
      this.endDate,
      this.discount,
      this.discountType});

  CouponCodes.fromJson(Map<String, dynamic> json) {
    couponCode = json['coupon_code'];
    image = json['image'];
    id = json['id'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    discount = json['discount'];
    discountType = json['discount_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coupon_code'] = this.couponCode;
    data['image'] = this.image;
    data['id'] = this.id;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    return data;
  }
}

class Categories {
  String categoryName;
  String image;
  String categoryId;
  String totalCount;

  Categories({this.categoryName, this.image, this.categoryId, this.totalCount});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    image = json['image'];
    categoryId = json['category_id'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_name'] = this.categoryName;
    data['image'] = this.image;
    data['category_id'] = this.categoryId;
    data['total_count'] = this.totalCount;
    return data;
  }
}

class BannerRestaurent {
  String id;
  String review;
  String isAvailable;
  String name;
  String image;
  String address;
  String discount;
  String latitude;
  String longitude;
  String discountType;

  BannerRestaurent(
      {this.id,
      this.review,
      this.isAvailable,
      this.name,
      this.image,
      this.address,
      this.discount,
      this.latitude,
      this.longitude,
      this.discountType});

  BannerRestaurent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    isAvailable = json['is_available'];
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
    data['review'] = this.review;
    data['is_available'] = this.isAvailable;
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

class TopRestaurents {
  String id;
  String review;
  String isAvailable;
  String image;
  String latitude;
  String longitude;
  String name;
  String address;

  TopRestaurents(
      {this.id,
      this.review,
      this.isAvailable,
      this.name,
      this.image,
      this.address,
      this.latitude,
      this.longitude});

  TopRestaurents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    isAvailable = json['is_available'];
    name = json['name'];
    image = json['image'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['review'] = this.review;
    data['is_available'] = this.isAvailable;
    data['name'] = this.name;
    data['image'] = this.image;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class PopularRestaurents {
  String id;
  String review;
  String isAvailable;
  String name;
  String image;
  String address;
  String discount;
  String latitude;
  String longitude;
  String discountType;

  PopularRestaurents(
      {this.id,
      this.review,
      this.isAvailable,
      this.name,
      this.image,
      this.address,
      this.discount,
      this.latitude,
      this.longitude,
      this.discountType});

  PopularRestaurents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    isAvailable = json['is_available'];
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
    data['review'] = this.review;
    data['is_available'] = this.isAvailable;
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
  String status;
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
      this.status,
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
    status = json['status'];
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
    data['status'] = this.status;
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
