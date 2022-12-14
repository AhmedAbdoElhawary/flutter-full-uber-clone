import 'package:uber/core/functions/api_result.dart';
import 'package:uber/core/functions/network_exceptions.dart';
import 'package:uber/data/data_sources/remote/api/google_map_apis.dart';
import 'package:uber/data/models/place_suggestion/places_suggestions.dart';
import 'package:uber/data/models/place_location_info/place_location_info.dart';
import 'package:uber/domain/repositories/google_map_apis_repo.dart';
import 'package:uuid/uuid.dart';

class GoogleMapAPIsRepoImpl implements GoogleMapAPIsRepo {
  final GoogleMapAPIs _googleMapAPIs;
  GoogleMapAPIsRepoImpl(this._googleMapAPIs);

  @override
  Future<ApiResult<PlacesSuggestions>> getPlacesSuggestions(
      {required String input}) async {
    try {
      PlacesSuggestions data = await _googleMapAPIs.getPlacesSuggestions(
          input: input, sessionToken: const Uuid().v4());

      return ApiResult.success(data);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<PlaceLocationInfo>> getPlacesLocation(
      {required String placeId}) async {
    try {
      PlaceLocationInfo data = await _googleMapAPIs.getPlacesLocation(
          placeId: placeId, sessionToken: const Uuid().v4());

      return ApiResult.success(data);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
