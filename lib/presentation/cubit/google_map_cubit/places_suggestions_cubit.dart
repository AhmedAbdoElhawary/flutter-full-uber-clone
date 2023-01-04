import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/core/functions/api_result.dart';
import 'package:uber/data/models/place_info/place_info.dart';
import 'package:uber/domain/repositories/google_map_apis_repo.dart';
import 'package:uber/presentation/cubit/result_state.dart';

class GoogleMapCubit extends Cubit<ResultState<PlaceInfo>> {
  final GoogleMapAPIsRepo _googleMapAPIsRepo;

  GoogleMapCubit(this._googleMapAPIsRepo)
      : super(const ResultState.initial());

  static GoogleMapCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getPlacesSuggestions(String input) async {
    if (input.isEmpty) return emit(const ResultState.initial());
    emit(const ResultState.loading());
    ApiResult<PlaceInfo> result =
        await _googleMapAPIsRepo.getPlacesSuggestions(input: input);
    result.when(
        success: (placeInfo) => emit(ResultState<PlaceInfo>.success(placeInfo)),
        failure: (exception) => emit(ResultState.error(exception)));
  }
}
