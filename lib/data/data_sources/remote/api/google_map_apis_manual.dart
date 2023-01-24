import 'package:dio/dio.dart';
import 'package:uber/core/utility/private_keys.dart';
import 'package:uber/data/models/places_direction/places_direction.dart';

/// I made [GoogleMapAPIsManual] because i faced some issues with retrofit
class GoogleMapAPIsManual {
  final Dio _dio;
  GoogleMapAPIsManual(this._dio);

  Future<dynamic> getPlacesDirection({
    required String origin,
    required String destination,
  }) async {
    try {
      Response response = await _dio.get(
        'https://maps.googleapis.com/maps/api/directions/json',
        queryParameters: {
          'origin': origin,
          'destination': destination,
          'key': mapApiKey,
        },
      );
      return PlacesDirection.fromJson(response.data);
    } catch (error) {
      return Future.error("Place location error");
    }
  }
}
