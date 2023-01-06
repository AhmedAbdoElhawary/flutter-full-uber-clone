import 'package:freezed_annotation/freezed_annotation.dart';

part 'places_suggestions.g.dart';

@JsonSerializable(includeIfNull: true)
class PlacesSuggestions {
  List<Prediction>? predictions;
  String? status;

  PlacesSuggestions({this.predictions, this.status});
  factory PlacesSuggestions.fromJson(Map<String, dynamic> json) =>
      _$PlacesSuggestionsFromJson(json);

  Map<String, dynamic> toJson() => _$PlacesSuggestionsToJson(this);
}

@JsonSerializable(includeIfNull: true)
class Prediction {
  String? description;
  @JsonKey(name: "place_id")
  String? placeId;
  String? reference;
  @JsonKey(name: "structured_formatting")
  StructuredFormatting? structuredFormatting;
  List<String>? types;

  Prediction(
      {this.description,
      this.placeId,
      this.reference,
      this.structuredFormatting,
      this.types});
  factory Prediction.fromJson(Map<String, dynamic> json) =>
      _$PredictionFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionToJson(this);
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
