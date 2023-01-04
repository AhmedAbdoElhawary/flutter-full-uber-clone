import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_info.g.dart';

@JsonSerializable(includeIfNull: true)
class PlaceInfo {
  List<Predictions>? predictions;
  String? status;

  PlaceInfo({this.predictions, this.status});
  factory PlaceInfo.fromJson(Map<String, dynamic> json) =>
      _$PlaceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceInfoToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Predictions {
  String? description;
  @JsonKey(name: "place_id")
  String? placeId;
  String? reference;
  @JsonKey(name: "structured_formatting")
  StructuredFormatting? structuredFormatting;
  List<String>? types;

  Predictions(
      {this.description,
      this.placeId,
      this.reference,
      this.structuredFormatting,
      this.types});
  factory Predictions.fromJson(Map<String, dynamic> json) =>
      _$PredictionsFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionsToJson(this);
}

@JsonSerializable(includeIfNull: true)
class StructuredFormatting {
  @JsonKey(name: "main_text")
  String? mainText;
  @JsonKey(name: "secondary_text")
  String? secondaryText;

  StructuredFormatting({this.mainText, this.secondaryText});
  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredFormattingToJson(this);
}
