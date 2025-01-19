import 'package:geolocator/geolocator.dart';

//import 'package:map/core/widgets/my_snackBar.dart';

class GeoServices {
  Future handelPermissionAndServiceLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw "location_permissions_denied";
      }
    }
  }

  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw "location_permissions_denied";
      }
    }

    // Get current location
    Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.bestForNavigation,
        ),
    );
    bool isMockLocation = position.isMocked;
    if (isMockLocation) {
      throw "Mock_Location";
    }

    return position;
  }

// convert lat long to address
// static Future getAddressFromLatLng(double lat, double long) async {
//   try {
//     List<Placemark> placeMarks = await placemarkFromCoordinates(lat, long);
//     return placeMarks[0];
//   } catch (e) {
//     debugPrint(e.toString());
//   }
// }
}
