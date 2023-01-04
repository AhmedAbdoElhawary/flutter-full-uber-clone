// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceInfo _$PlaceInfoFromJson(Map<String, dynamic> json) => PlaceInfo(
      predictions: (json['predictions'] as List<dynamic>?)
          ?.map((e) => Predictions.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PlaceInfoToJson(PlaceInfo instance) => <String, dynamic>{
      'predictions': instance.predictions,
      'status': instance.status,
    };

Predictions _$PredictionsFromJson(Map<String, dynamic> json) => Predictions(
      description: json['description'] as String?,
      matchedSubstrings: (json['matchedSubstrings'] as List<dynamic>?)
          ?.map((e) => MatchedSubstrings.fromJson(e as Map<String, dynamic>))
          .toList(),
      placeId: json['placeId'] as String?,
      reference: json['reference'] as String?,
      structuredFormatting: json['structuredFormatting'] == null
          ? null
          : StructuredFormatting.fromJson(
              json['structuredFormatting'] as Map<String, dynamic>),
      terms: (json['terms'] as List<dynamic>?)
          ?.map((e) => Terms.fromJson(e as Map<String, dynamic>))
          .toList(),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PredictionsToJson(Predictions instance) =>
    <String, dynamic>{
      'description': instance.description,
      'matchedSubstrings': instance.matchedSubstrings,
      'placeId': instance.placeId,
      'reference': instance.reference,
      'structuredFormatting': instance.structuredFormatting,
      'terms': instance.terms,
      'types': instance.types,
    };

MatchedSubstrings _$MatchedSubstringsFromJson(Map<String, dynamic> json) =>
    MatchedSubstrings(
      length: json['length'] as int?,
      offset: json['offset'] as int?,
    );

Map<String, dynamic> _$MatchedSubstringsToJson(MatchedSubstrings instance) =>
    <String, dynamic>{
      'length': instance.length,
      'offset': instance.offset,
    };

StructuredFormatting _$StructuredFormattingFromJson(
        Map<String, dynamic> json) =>
    StructuredFormatting(
      mainText: json['mainText'] as String?,
      mainTextMatchedSubstrings: (json['mainTextMatchedSubstrings']
              as List<dynamic>?)
          ?.map((e) => MatchedSubstrings.fromJson(e as Map<String, dynamic>))
          .toList(),
      secondaryText: json['secondaryText'] as String?,
    );

Map<String, dynamic> _$StructuredFormattingToJson(
        StructuredFormatting instance) =>
    <String, dynamic>{
      'mainText': instance.mainText,
      'mainTextMatchedSubstrings': instance.mainTextMatchedSubstrings,
      'secondaryText': instance.secondaryText,
    };

Terms _$TermsFromJson(Map<String, dynamic> json) => Terms(
      offset: json['offset'] as int?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$TermsToJson(Terms instance) => <String, dynamic>{
      'offset': instance.offset,
      'value': instance.value,
    };
