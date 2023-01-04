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
      placeId: json['place_id'] as String?,
      reference: json['reference'] as String?,
      structuredFormatting: json['structured_formatting'] == null
          ? null
          : StructuredFormatting.fromJson(
              json['structured_formatting'] as Map<String, dynamic>),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PredictionsToJson(Predictions instance) =>
    <String, dynamic>{
      'description': instance.description,
      'place_id': instance.placeId,
      'reference': instance.reference,
      'structured_formatting': instance.structuredFormatting,
      'types': instance.types,
    };

StructuredFormatting _$StructuredFormattingFromJson(
        Map<String, dynamic> json) =>
    StructuredFormatting(
      mainText: json['main_text'] as String?,
      secondaryText: json['secondary_text'] as String?,
    );

Map<String, dynamic> _$StructuredFormattingToJson(
        StructuredFormatting instance) =>
    <String, dynamic>{
      'main_text': instance.mainText,
      'secondary_text': instance.secondaryText,
    };
