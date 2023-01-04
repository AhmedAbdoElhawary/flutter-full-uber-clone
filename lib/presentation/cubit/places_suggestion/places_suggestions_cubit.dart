import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uber/core/functions/api_result.dart';
import 'package:uber/core/functions/network_exceptions.dart';
import 'package:uber/data/models/place_info/place_info.dart';
import 'package:uber/data/repositories_impl/google_map_apis_repo_impl.dart';

part 'places_suggestions_state.dart';
part 'places_suggestions_cubit.freezed.dart';

class PlacesSuggestionsCubit extends Cubit<PlacesSuggestionsState> {
  final GoogleMapAPIsRepoImpl _googleMapAPIsRepoImpl;

  PlacesSuggestionsCubit(this._googleMapAPIsRepoImpl) : super(const _Initial());

  static PlacesSuggestionsCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getPlacesSuggestions(String input) async {
    emit(const _Loading());
    ApiResult<PlaceInfo> result =
        await _googleMapAPIsRepoImpl.getPlacesSuggestions(input: input);
    result.when(
        success: (placeInfo) => emit(_Loaded(placeInfo)),
        failure: (exception) => emit(_Failed(exception)));
  }
}
