import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:news_project/models/country_model.dart';

class LocationUtils {
  static handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied, we cannot request permissions.';
    }
  }

  static Future<Position> getLocation() async {
    Position userPosition;
    try {
      await handleLocationPermission();
      userPosition = await Geolocator.getCurrentPosition();
      return userPosition;
    } catch (e) {
      rethrow;
    }
  }

  static Future<CountryModel> getPlacemark() async {
    try {
      Position userPosition = await getLocation();
      List<Placemark> placemarks =
      await placemarkFromCoordinates(
          userPosition.latitude, userPosition.longitude);
      return CountryModel(
          name: placemarks.first.country ?? "",
          isoCountryCode: placemarks.first.isoCountryCode ?? "");
    } catch (e) {
      return CountryModel(name: "India", isoCountryCode: "IN");
    }
  }
}
