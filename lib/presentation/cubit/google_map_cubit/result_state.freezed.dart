// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'result_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ResultState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PlacesSuggestions placeInfo)
        placesSuggestionsLoaded,
    required TResult Function(List<PlaceLocationInfo> placesLocationInfo)
        placesLocationLoaded,
    required TResult Function(NetworkExceptions networkExceptions) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult? Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult? Function(NetworkExceptions networkExceptions)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult Function(NetworkExceptions networkExceptions)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(PlacesSuggestionsLoaded value)
        placesSuggestionsLoaded,
    required TResult Function(PlacesLocationLoaded value) placesLocationLoaded,
    required TResult Function(Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult? Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult? Function(Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultStateCopyWith<$Res> {
  factory $ResultStateCopyWith(
          ResultState value, $Res Function(ResultState) then) =
      _$ResultStateCopyWithImpl<$Res, ResultState>;
}

/// @nodoc
class _$ResultStateCopyWithImpl<$Res, $Val extends ResultState>
    implements $ResultStateCopyWith<$Res> {
  _$ResultStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$InitialCopyWith<$Res> {
  factory _$$InitialCopyWith(_$Initial value, $Res Function(_$Initial) then) =
      __$$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialCopyWithImpl<$Res>
    extends _$ResultStateCopyWithImpl<$Res, _$Initial>
    implements _$$InitialCopyWith<$Res> {
  __$$InitialCopyWithImpl(_$Initial _value, $Res Function(_$Initial) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Initial implements Initial {
  const _$Initial();

  @override
  String toString() {
    return 'ResultState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PlacesSuggestions placeInfo)
        placesSuggestionsLoaded,
    required TResult Function(List<PlaceLocationInfo> placesLocationInfo)
        placesLocationLoaded,
    required TResult Function(NetworkExceptions networkExceptions) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult? Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult? Function(NetworkExceptions networkExceptions)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult Function(NetworkExceptions networkExceptions)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(PlacesSuggestionsLoaded value)
        placesSuggestionsLoaded,
    required TResult Function(PlacesLocationLoaded value) placesLocationLoaded,
    required TResult Function(Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult? Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult? Function(Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class Initial implements ResultState {
  const factory Initial() = _$Initial;
}

/// @nodoc
abstract class _$$LoadingCopyWith<$Res> {
  factory _$$LoadingCopyWith(_$Loading value, $Res Function(_$Loading) then) =
      __$$LoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingCopyWithImpl<$Res>
    extends _$ResultStateCopyWithImpl<$Res, _$Loading>
    implements _$$LoadingCopyWith<$Res> {
  __$$LoadingCopyWithImpl(_$Loading _value, $Res Function(_$Loading) _then)
      : super(_value, _then);
}

/// @nodoc

class _$Loading implements Loading {
  const _$Loading();

  @override
  String toString() {
    return 'ResultState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$Loading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PlacesSuggestions placeInfo)
        placesSuggestionsLoaded,
    required TResult Function(List<PlaceLocationInfo> placesLocationInfo)
        placesLocationLoaded,
    required TResult Function(NetworkExceptions networkExceptions) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult? Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult? Function(NetworkExceptions networkExceptions)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult Function(NetworkExceptions networkExceptions)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(PlacesSuggestionsLoaded value)
        placesSuggestionsLoaded,
    required TResult Function(PlacesLocationLoaded value) placesLocationLoaded,
    required TResult Function(Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult? Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult? Function(Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class Loading implements ResultState {
  const factory Loading() = _$Loading;
}

/// @nodoc
abstract class _$$PlacesSuggestionsLoadedCopyWith<$Res> {
  factory _$$PlacesSuggestionsLoadedCopyWith(_$PlacesSuggestionsLoaded value,
          $Res Function(_$PlacesSuggestionsLoaded) then) =
      __$$PlacesSuggestionsLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({PlacesSuggestions placeInfo});
}

/// @nodoc
class __$$PlacesSuggestionsLoadedCopyWithImpl<$Res>
    extends _$ResultStateCopyWithImpl<$Res, _$PlacesSuggestionsLoaded>
    implements _$$PlacesSuggestionsLoadedCopyWith<$Res> {
  __$$PlacesSuggestionsLoadedCopyWithImpl(_$PlacesSuggestionsLoaded _value,
      $Res Function(_$PlacesSuggestionsLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeInfo = null,
  }) {
    return _then(_$PlacesSuggestionsLoaded(
      null == placeInfo
          ? _value.placeInfo
          : placeInfo // ignore: cast_nullable_to_non_nullable
              as PlacesSuggestions,
    ));
  }
}

/// @nodoc

class _$PlacesSuggestionsLoaded implements PlacesSuggestionsLoaded {
  const _$PlacesSuggestionsLoaded(this.placeInfo);

  @override
  final PlacesSuggestions placeInfo;

  @override
  String toString() {
    return 'ResultState.placesSuggestionsLoaded(placeInfo: $placeInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlacesSuggestionsLoaded &&
            (identical(other.placeInfo, placeInfo) ||
                other.placeInfo == placeInfo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, placeInfo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlacesSuggestionsLoadedCopyWith<_$PlacesSuggestionsLoaded> get copyWith =>
      __$$PlacesSuggestionsLoadedCopyWithImpl<_$PlacesSuggestionsLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PlacesSuggestions placeInfo)
        placesSuggestionsLoaded,
    required TResult Function(List<PlaceLocationInfo> placesLocationInfo)
        placesLocationLoaded,
    required TResult Function(NetworkExceptions networkExceptions) error,
  }) {
    return placesSuggestionsLoaded(placeInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult? Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult? Function(NetworkExceptions networkExceptions)? error,
  }) {
    return placesSuggestionsLoaded?.call(placeInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult Function(NetworkExceptions networkExceptions)? error,
    required TResult orElse(),
  }) {
    if (placesSuggestionsLoaded != null) {
      return placesSuggestionsLoaded(placeInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(PlacesSuggestionsLoaded value)
        placesSuggestionsLoaded,
    required TResult Function(PlacesLocationLoaded value) placesLocationLoaded,
    required TResult Function(Error value) error,
  }) {
    return placesSuggestionsLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult? Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult? Function(Error value)? error,
  }) {
    return placesSuggestionsLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (placesSuggestionsLoaded != null) {
      return placesSuggestionsLoaded(this);
    }
    return orElse();
  }
}

abstract class PlacesSuggestionsLoaded implements ResultState {
  const factory PlacesSuggestionsLoaded(final PlacesSuggestions placeInfo) =
      _$PlacesSuggestionsLoaded;

  PlacesSuggestions get placeInfo;
  @JsonKey(ignore: true)
  _$$PlacesSuggestionsLoadedCopyWith<_$PlacesSuggestionsLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PlacesLocationLoadedCopyWith<$Res> {
  factory _$$PlacesLocationLoadedCopyWith(_$PlacesLocationLoaded value,
          $Res Function(_$PlacesLocationLoaded) then) =
      __$$PlacesLocationLoadedCopyWithImpl<$Res>;
  @useResult
  $Res call({List<PlaceLocationInfo> placesLocationInfo});
}

/// @nodoc
class __$$PlacesLocationLoadedCopyWithImpl<$Res>
    extends _$ResultStateCopyWithImpl<$Res, _$PlacesLocationLoaded>
    implements _$$PlacesLocationLoadedCopyWith<$Res> {
  __$$PlacesLocationLoadedCopyWithImpl(_$PlacesLocationLoaded _value,
      $Res Function(_$PlacesLocationLoaded) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placesLocationInfo = null,
  }) {
    return _then(_$PlacesLocationLoaded(
      null == placesLocationInfo
          ? _value._placesLocationInfo
          : placesLocationInfo // ignore: cast_nullable_to_non_nullable
              as List<PlaceLocationInfo>,
    ));
  }
}

/// @nodoc

class _$PlacesLocationLoaded implements PlacesLocationLoaded {
  const _$PlacesLocationLoaded(final List<PlaceLocationInfo> placesLocationInfo)
      : _placesLocationInfo = placesLocationInfo;

  final List<PlaceLocationInfo> _placesLocationInfo;
  @override
  List<PlaceLocationInfo> get placesLocationInfo {
    if (_placesLocationInfo is EqualUnmodifiableListView)
      return _placesLocationInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_placesLocationInfo);
  }

  @override
  String toString() {
    return 'ResultState.placesLocationLoaded(placesLocationInfo: $placesLocationInfo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlacesLocationLoaded &&
            const DeepCollectionEquality()
                .equals(other._placesLocationInfo, _placesLocationInfo));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_placesLocationInfo));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlacesLocationLoadedCopyWith<_$PlacesLocationLoaded> get copyWith =>
      __$$PlacesLocationLoadedCopyWithImpl<_$PlacesLocationLoaded>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PlacesSuggestions placeInfo)
        placesSuggestionsLoaded,
    required TResult Function(List<PlaceLocationInfo> placesLocationInfo)
        placesLocationLoaded,
    required TResult Function(NetworkExceptions networkExceptions) error,
  }) {
    return placesLocationLoaded(placesLocationInfo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult? Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult? Function(NetworkExceptions networkExceptions)? error,
  }) {
    return placesLocationLoaded?.call(placesLocationInfo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult Function(NetworkExceptions networkExceptions)? error,
    required TResult orElse(),
  }) {
    if (placesLocationLoaded != null) {
      return placesLocationLoaded(placesLocationInfo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(PlacesSuggestionsLoaded value)
        placesSuggestionsLoaded,
    required TResult Function(PlacesLocationLoaded value) placesLocationLoaded,
    required TResult Function(Error value) error,
  }) {
    return placesLocationLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult? Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult? Function(Error value)? error,
  }) {
    return placesLocationLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (placesLocationLoaded != null) {
      return placesLocationLoaded(this);
    }
    return orElse();
  }
}

abstract class PlacesLocationLoaded implements ResultState {
  const factory PlacesLocationLoaded(
          final List<PlaceLocationInfo> placesLocationInfo) =
      _$PlacesLocationLoaded;

  List<PlaceLocationInfo> get placesLocationInfo;
  @JsonKey(ignore: true)
  _$$PlacesLocationLoadedCopyWith<_$PlacesLocationLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorCopyWith<$Res> {
  factory _$$ErrorCopyWith(_$Error value, $Res Function(_$Error) then) =
      __$$ErrorCopyWithImpl<$Res>;
  @useResult
  $Res call({NetworkExceptions networkExceptions});

  $NetworkExceptionsCopyWith<$Res> get networkExceptions;
}

/// @nodoc
class __$$ErrorCopyWithImpl<$Res>
    extends _$ResultStateCopyWithImpl<$Res, _$Error>
    implements _$$ErrorCopyWith<$Res> {
  __$$ErrorCopyWithImpl(_$Error _value, $Res Function(_$Error) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? networkExceptions = null,
  }) {
    return _then(_$Error(
      null == networkExceptions
          ? _value.networkExceptions
          : networkExceptions // ignore: cast_nullable_to_non_nullable
              as NetworkExceptions,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $NetworkExceptionsCopyWith<$Res> get networkExceptions {
    return $NetworkExceptionsCopyWith<$Res>(_value.networkExceptions, (value) {
      return _then(_value.copyWith(networkExceptions: value));
    });
  }
}

/// @nodoc

class _$Error implements Error {
  const _$Error(this.networkExceptions);

  @override
  final NetworkExceptions networkExceptions;

  @override
  String toString() {
    return 'ResultState.error(networkExceptions: $networkExceptions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Error &&
            (identical(other.networkExceptions, networkExceptions) ||
                other.networkExceptions == networkExceptions));
  }

  @override
  int get hashCode => Object.hash(runtimeType, networkExceptions);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorCopyWith<_$Error> get copyWith =>
      __$$ErrorCopyWithImpl<_$Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PlacesSuggestions placeInfo)
        placesSuggestionsLoaded,
    required TResult Function(List<PlaceLocationInfo> placesLocationInfo)
        placesLocationLoaded,
    required TResult Function(NetworkExceptions networkExceptions) error,
  }) {
    return error(networkExceptions);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult? Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult? Function(NetworkExceptions networkExceptions)? error,
  }) {
    return error?.call(networkExceptions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PlacesSuggestions placeInfo)? placesSuggestionsLoaded,
    TResult Function(List<PlaceLocationInfo> placesLocationInfo)?
        placesLocationLoaded,
    TResult Function(NetworkExceptions networkExceptions)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(networkExceptions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Initial value) initial,
    required TResult Function(Loading value) loading,
    required TResult Function(PlacesSuggestionsLoaded value)
        placesSuggestionsLoaded,
    required TResult Function(PlacesLocationLoaded value) placesLocationLoaded,
    required TResult Function(Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(Initial value)? initial,
    TResult? Function(Loading value)? loading,
    TResult? Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult? Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult? Function(Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Initial value)? initial,
    TResult Function(Loading value)? loading,
    TResult Function(PlacesSuggestionsLoaded value)? placesSuggestionsLoaded,
    TResult Function(PlacesLocationLoaded value)? placesLocationLoaded,
    TResult Function(Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class Error implements ResultState {
  const factory Error(final NetworkExceptions networkExceptions) = _$Error;

  NetworkExceptions get networkExceptions;
  @JsonKey(ignore: true)
  _$$ErrorCopyWith<_$Error> get copyWith => throw _privateConstructorUsedError;
}
