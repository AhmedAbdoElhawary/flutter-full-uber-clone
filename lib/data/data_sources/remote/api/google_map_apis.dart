import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uber/core/utility/constant.dart';
import 'package:uber/core/utility/private_keys.dart';
import 'package:uber/data/models/place_info/place_info.dart';
part 'google_map_apis.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class GoogleMapAPIs {
  factory GoogleMapAPIs(Dio dio, {String baseUrl}) = _GoogleMapAPIs;

  @GET("autocomplete/json?type=address&components=country:eg")
  Future<PlaceInfo> getPlacesSuggestions({
    @Query("input") required String input,
    @Query("key") final String apiKey = mapApiKey,
    @Query("sessiontoken") required String sessionToken,
  });
}
