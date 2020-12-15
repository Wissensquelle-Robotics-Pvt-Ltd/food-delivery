import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResWalletAmount extends BaseModel {
  int code;
  String message;
  Amount amount;

  ResWalletAmount({this.code, this.message, this.amount});

  ResWalletAmount.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    amount =
        json['result'] != null ? new Amount.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.amount != null) {
      data['result'] = this.amount.toJson();
    }
    return data;
  }
}

class Amount {
  String userId;
  String walletAmount;

  Amount({this.userId, this.walletAmount});

  Amount.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    walletAmount = json['wallet_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['wallet_amount'] = this.walletAmount;
    return data;
  }
}
