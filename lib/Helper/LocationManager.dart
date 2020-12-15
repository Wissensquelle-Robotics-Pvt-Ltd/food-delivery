import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:product/Helper/SharedManaged.dart';

class LocationManager {
  static final LocationManager shared = LocationManager._internal();

  factory LocationManager() {
    return shared;
  }

  LocationManager._internal();

   var latitude = 0.00;
   var longitude = 0.00;

getCurrentLocation()async{

var location = new Location();

// Platform messages may fail, so we use a try/catch PlatformException.
      try {
        var currentLocation = await location.getLocation();
        print("Location data:${currentLocation.longitude}");
        this.latitude = currentLocation.latitude;
        this.longitude = currentLocation.longitude;
      }  catch (e) {
        if (e.code == 'PERMISSION_DENIED') {
          print("error occured");
          return;
        }
      }
     location.onLocationChanged.listen((LocationData currentLocation) {
        print("Updated Latitude--->:${currentLocation.latitude}");
        print("Updated Longitude--->:${currentLocation.longitude}");

        this.latitude = currentLocation.latitude;
        this.longitude = currentLocation.longitude;
        if(this.latitude != 0 && this.longitude != 0){
           var coordinate = LatLng(this.latitude, this.longitude);
           SharedManager.shared.storeLocationCoordinate(coordinate);
        }
      });
  }

}