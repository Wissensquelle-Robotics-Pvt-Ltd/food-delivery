import 'package:product/BlocClass/CommonBlocClass/BaseMode.dart';

class ResDriverLocation extends BaseModel {
  int code;
  String message;
  DriverData result;

  ResDriverLocation({this.code, this.message, this.result});

  ResDriverLocation.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result =
        json['result'] != null ? new DriverData.fromJson(json['result']) : null;
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

class DriverData {
  String driverId;
  String latitude;
  String longitude;

  DriverData({this.driverId, this.latitude, this.longitude});

  DriverData.fromJson(Map<String, dynamic> json) {
    driverId = json['driver_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_id'] = this.driverId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
