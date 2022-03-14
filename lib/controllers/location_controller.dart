import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  var currentLat = 0.0.obs;
  var currentLng = 0.0.obs;
  var serviceEnabled = false.obs;

  Future<void> getCurrentLocation() async {
    Location location = Location();
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled.value = await location.serviceEnabled();
    if (!serviceEnabled.value) {
      serviceEnabled.value = await location.requestService();
      if (!serviceEnabled.value) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    currentLat.value = locationData.latitude!;
    currentLng.value = locationData.longitude!;

    // debugPrint('Location Controller: '+currentLat.value.toString());
    // debugPrint('Location Controller: '+currentLng.value.toString());
  }
}