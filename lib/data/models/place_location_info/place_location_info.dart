import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uber/data/models/place_suggestion/places_suggestions.dart';

part 'place_location_info.g.dart';

@JsonSerializable(includeIfNull: true)
class PlaceLocationInfo {
  Result? result;
  String? status;

  /// I put the value of [placeSubTextInfo] manually from suggestion Place Info
  StructuredFormatting? placeSubTextInfo;
  String? placeId;
  PlaceLocationInfo({this.result, this.status, this.placeSubTextInfo,this.placeId});

  factory PlaceLocationInfo.fromJson(Map<String, dynamic> json) =>
      _$PlaceLocationInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceLocationInfoToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Result {
  Geometry? geometry;

  Result({this.geometry});

  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  factory Geometry.fromJson(Map<String, dynamic> json) =>
      _$GeometryFromJson(json);

  Map<String, dynamic> toJson() => _$GeometryToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  factory Viewport.fromJson(Map<String, dynamic> json) =>
      _$ViewportFromJson(json);

  Map<String, dynamic> toJson() => _$ViewportToJson(this);
}
