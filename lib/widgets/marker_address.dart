import '../helpers/location_helper.dart';



Future<String> markerAdress(
  double lat,
  double lng,
) async {
  return await LocationHelper.getPlaceAddress(lat, lng);
}
