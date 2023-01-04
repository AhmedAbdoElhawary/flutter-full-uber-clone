import 'package:uber/core/functions/api_result.dart';
import 'package:uber/data/models/place_info/place_info.dart';

abstract class GoogleMapAPIsRepo {
  Future<ApiResult<PlaceInfo>> getPlacesSuggestions({required String input});
}
