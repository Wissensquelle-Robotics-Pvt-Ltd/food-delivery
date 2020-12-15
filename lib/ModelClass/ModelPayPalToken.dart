class ResPayPalToken {
  int code;
  String message;
  String result;

  ResPayPalToken({this.code, this.message, this.result});

  ResPayPalToken.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['result'] = this.result;
    return data;
  }
}
