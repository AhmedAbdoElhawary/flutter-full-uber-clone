import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/core/functions/api_result.dart';
import 'package:uber/data/models/place_suggestion/places_suggestions.dart';
import 'package:uber/data/models/place_location_info/place_location_info.dart';
import 'package:uber/domain/repositories/google_map_apis_repo.dart';
import 'package:uber/presentation/cubit/google_map_cubit/result_state.dart';

class GoogleMapCubit extends Cubit<ResultState> {
  final GoogleMapAPIsRepo _googleMapAPIsRepo;

  GoogleMapCubit(this._googleMapAPIsRepo) : super(const ResultState.initial());

  static GoogleMapCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getPlacesSuggestions(String input) async {
    if (input.isEmpty) return emit(const ResultState.initial());
    emit(const ResultState.loading());
    ApiResult<PlacesSuggestions> result =
        await _googleMapAPIsRepo.getPlacesSuggestions(input: input);
    result.when(
        success: (placeInfo) =>
            emit(ResultState.placesSuggestionsLoaded(placeInfo)),
        failure: (exception) => emit(ResultState.error(exception)));
  }

  Future<void> getPlaceLocation(List<String> placesIds) async {
    if (placesIds.isEmpty) return emit(const ResultState.initial());
    emit(const ResultState.loading());
    ApiResult<List<PlaceLocationInfo>> result =
        await _googleMapAPIsRepo.getPlacesLocation(placesIds: placesIds);
    result.when(
        success: (location) => emit(ResultState.placesLocationLoaded(location)),
        failure: (exception) => emit(ResultState.error(exception)));
  }
}
