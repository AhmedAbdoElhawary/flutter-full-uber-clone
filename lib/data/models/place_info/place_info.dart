import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_info.g.dart';

@JsonSerializable()
class PlaceInfo {
  List<Predictions>? predictions;
  String? status;

  PlaceInfo({this.predictions, this.status});

  factory PlaceInfo.fromJson(Map<String, dynamic> json) =>
      _$PlaceInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceInfoToJson(this);
}

@JsonSerializable()
class Predictions {
  String? description;
  List<MatchedSubstrings>? matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormatting? structuredFormatting;
  List<Terms>? terms;
  List<String>? types;

  Predictions(
      {this.description,
      this.matchedSubstrings,
      this.placeId,
      this.reference,
      this.structuredFormatting,
      this.terms,
      this.types});
  factory Predictions.fromJson(Map<String, dynamic> json) =>
      _$PredictionsFromJson(json);

  Map<String, dynamic> toJson() => _$PredictionsToJson(this);
}

@JsonSerializable()
class MatchedSubstrings {
  int? length;
  int? offset;

  MatchedSubstrings({this.length, this.offset});
  factory MatchedSubstrings.fromJson(Map<String, dynamic> json) =>
      _$MatchedSubstringsFromJson(json);

  Map<String, dynamic> toJson() => _$MatchedSubstringsToJson(this);
}

@JsonSerializable()
class StructuredFormatting {
  String? mainText;
  List<MatchedSubstrings>? mainTextMatchedSubstrings;
  String? secondaryText;

  StructuredFormatting(
      {this.mainText, this.mainTextMatchedSubstrings, this.secondaryText});
  factory StructuredFormatting.fromJson(Map<String, dynamic> json) =>
      _$StructuredFormattingFromJson(json);

  Map<String, dynamic> toJson() => _$StructuredFormattingToJson(this);
}

@JsonSerializable()
class Terms {
  int? offset;
  String? value;

  Terms({this.offset, this.value});
  factory Terms.fromJson(Map<String, dynamic> json) => _$TermsFromJson(json);

  Map<String, dynamic> toJson() => _$TermsToJson(this);
}
