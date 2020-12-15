import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResAllReview extends BaseModel {
  int code;
  String message;
  List<AllReviews> reviews;

  ResAllReview({this.code, this.message, this.reviews});

  ResAllReview.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['result'] != null) {
      reviews = new List<AllReviews>();
      json['result'].forEach((v) {
        reviews.add(new AllReviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.reviews != null) {
      data['result'] = this.reviews.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllReviews {
  String review;
  String message;
  String userName;
  String city;
  String userImage;
  String date;

  AllReviews(
      {this.review,
      this.message,
      this.userName,
      this.city,
      this.userImage,
      this.date});

  AllReviews.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    message = json['message'];
    userName = json['user_name'];
    city = json['city'];
    userImage = json['user_image'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review'] = this.review;
    data['message'] = this.message;
    data['user_name'] = this.userName;
    data['city'] = this.city;
    data['user_image'] = this.userImage;
    data['date'] = this.date;
    return data;
  }
}
