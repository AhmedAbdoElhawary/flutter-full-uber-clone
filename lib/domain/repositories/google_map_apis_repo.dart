import 'package:uber/core/functions/api_result.dart';
import 'package:uber/data/models/place_suggestion/places_suggestions.dart';
import 'package:uber/data/models/place_location_info/place_location_info.dart';

abstract class GoogleMapAPIsRepo {
  Future<ApiResult<PlacesSuggestions>> getPlacesSuggestions(
      {required String input});
  Future<ApiResult<List<PlaceLocationInfo>>> getPlacesLocation(
      {required List<String> placesIds});
}
