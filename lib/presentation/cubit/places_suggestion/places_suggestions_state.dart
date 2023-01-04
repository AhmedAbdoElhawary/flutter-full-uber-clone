part of 'places_suggestions_cubit.dart';

@freezed
class PlacesSuggestionsState with _$PlacesSuggestionsState {
  const factory PlacesSuggestionsState.initial() = _Initial;
  const factory PlacesSuggestionsState.loading() = _Loading;
  const factory PlacesSuggestionsState.loaded(PlaceInfo placeInfo) = _Loaded;
  const factory PlacesSuggestionsState.failed(NetworkExceptions networkExceptions) = _Failed;
}
