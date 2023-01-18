import 'package:uber/core/functions/api_result.dart';
import 'package:uber/core/functions/network_exceptions.dart';
import 'package:uber/data/data_sources/remote/api/google_map_apis.dart';
import 'package:uber/data/models/place_suggestion/places_suggestions.dart';
import 'package:uber/data/models/place_location_info/place_location_info.dart';
import 'package:uber/data/models/places_direction/places_direction.dart';
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
  Future<ApiResult<List<PlaceLocationInfo>>> getPlacesLocation(
      {required List<Prediction> places}) async {
    try {
      List<PlaceLocationInfo> result = [];

      for (final id in places) {
        if (id.placeId == null) throw "there is place id empty";
        PlaceLocationInfo data = await _googleMapAPIs.getPlacesLocation(
            placeId: id.placeId!, sessionToken: const Uuid().v4());
        data.placeSubTextInfo = id.structuredFormatting;
        result.add(data);
      }

      return ApiResult.success(result);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }

  @override
  Future<ApiResult<PlacesDirection>> getPlacesDirection(
      {required String startPoint, required String endPoint}) async {
    try {
      PlacesDirection data = await _googleMapAPIs.getPlacesDirection(
          origin: startPoint, destination: endPoint);
      return ApiResult.success(data);
    } catch (e) {
      return ApiResult.failure(NetworkExceptions.getDioException(e));
    }
  }
}
