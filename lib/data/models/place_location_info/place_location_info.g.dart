// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_location_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceLocationInfo _$PlaceLocationInfoFromJson(Map<String, dynamic> json) =>
    PlaceLocationInfo(
      result: json['result'] == null
          ? null
          : Result.fromJson(json['result'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PlaceLocationInfoToJson(PlaceLocationInfo instance) =>
    <String, dynamic>{
      'result': instance.result,
      'status': instance.status,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      geometry: json['geometry'] == null
          ? null
          : Geometry.fromJson(json['geometry'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'geometry': instance.geometry,
    };

Geometry _$GeometryFromJson(Map<String, dynamic> json) => Geometry(
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      viewport: json['viewport'] == null
          ? null
          : Viewport.fromJson(json['viewport'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GeometryToJson(Geometry instance) => <String, dynamic>{
      'location': instance.location,
      'viewport': instance.viewport,
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Viewport _$ViewportFromJson(Map<String, dynamic> json) => Viewport(
      northeast: json['northeast'] == null
          ? null
          : Location.fromJson(json['northeast'] as Map<String, dynamic>),
      southwest: json['southwest'] == null
          ? null
          : Location.fromJson(json['southwest'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ViewportToJson(Viewport instance) => <String, dynamic>{
      'northeast': instance.northeast,
      'southwest': instance.southwest,
    };
