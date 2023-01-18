import 'package:freezed_annotation/freezed_annotation.dart';

part 'places_direction.g.dart';

@JsonSerializable(includeIfNull: true)
class PlacesDirection {
  @JsonKey(name: "geocoded_waypoints")
  List<GeocodedWaypoints>? geocodedWaypoints;
  List<Routes>? routes;
  String? status;

  PlacesDirection({this.geocodedWaypoints, this.routes, this.status});

  factory PlacesDirection.fromJson(Map<String, dynamic> json) =>
      _$PlacesDirectionFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesDirectionToJson(this);
}

@JsonSerializable(includeIfNull: true)
class GeocodedWaypoints {
  @JsonKey(name: "geocoder_status")
  String? geocoderStatus;
  @JsonKey(name: "partial_match")
  bool? partialMatch;
  @JsonKey(name: "place_id")
  String? placeId;
  List<String>? types;

  GeocodedWaypoints(
      {this.geocoderStatus, this.partialMatch, this.placeId, this.types});

  factory GeocodedWaypoints.fromJson(Map<String, dynamic> json) =>
      _$GeocodedWaypointsFromJson(json);

  Map<String, dynamic> toJson() => _$GeocodedWaypointsToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Routes {
  Bounds? bounds;
  String? copyrights;
  List<Legs>? legs;
  @JsonKey(name: "overview_polyline")
  Polyline? overviewPolyline;
  String? summary;

  Routes({
    this.bounds,
    this.copyrights,
    this.legs,
    this.overviewPolyline,
    this.summary,
  });
  factory Routes.fromJson(Map<String, dynamic> json) => _$RoutesFromJson(json);

  Map<String, dynamic> toJson() => _$RoutesToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Bounds {
  Northeast? northeast;
  Northeast? southwest;

  Bounds({this.northeast, this.southwest});
  factory Bounds.fromJson(Map<String, dynamic> json) => _$BoundsFromJson(json);

  Map<String, dynamic> toJson() => _$BoundsToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Northeast {
  double? lat;
  double? lng;

  Northeast({this.lat, this.lng});

  factory Northeast.fromJson(Map<String, dynamic> json) =>
      _$NortheastFromJson(json);

  Map<String, dynamic> toJson() => _$NortheastToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Legs {
  Distance? distance;
  Distance? duration;
  @JsonKey(name: "end_address")
  String? endAddress;
  @JsonKey(name: "end_location")
  Northeast? endLocation;
  @JsonKey(name: "start_address")
  String? startAddress;
  @JsonKey(name: "start_location")
  Northeast? startLocation;
  List<Steps>? steps;

  Legs({
    this.distance,
    this.duration,
    this.endAddress,
    this.endLocation,
    this.startAddress,
    this.startLocation,
    this.steps,
  });
  factory Legs.fromJson(Map<String, dynamic> json) => _$LegsFromJson(json);

  Map<String, dynamic> toJson() => _$LegsToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Distance {
  String? text;
  int? value;

  Distance({this.text, this.value});

  factory Distance.fromJson(Map<String, dynamic> json) =>
      _$DistanceFromJson(json);

  Map<String, dynamic> toJson() => _$DistanceToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Steps {
  Distance? distance;
  Distance? duration;
  @JsonKey(name: "end_location")
  Northeast? endLocation;
  @JsonKey(name: "html_instructions")
  String? htmlInstructions;
  Polyline? polyline;
  @JsonKey(name: "start_location")
  Northeast? startLocation;
  @JsonKey(name: "travel_mode")
  String? travelMode;
  String? maneuver;

  Steps(
      {this.distance,
      this.duration,
      this.endLocation,
      this.htmlInstructions,
      this.polyline,
      this.startLocation,
      this.travelMode,
      this.maneuver});

  factory Steps.fromJson(Map<String, dynamic> json) => _$StepsFromJson(json);

  Map<String, dynamic> toJson() => _$StepsToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Polyline {
  String? points;

  Polyline({this.points});
  factory Polyline.fromJson(Map<String, dynamic> json) =>
      _$PolylineFromJson(json);

  Map<String, dynamic> toJson() => _$PolylineToJson(this);
}
