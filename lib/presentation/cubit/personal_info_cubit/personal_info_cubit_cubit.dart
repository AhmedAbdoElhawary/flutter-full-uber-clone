import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/data/models/personal_info.dart';
import 'package:uber/domain/use_cases/personal_info/create_new_user.dart';
import 'package:uber/domain/use_cases/personal_info/get_user_info.dart';

part 'personal_info_cubit_state.dart';

class PersonalInfoCubitCubit extends Cubit<PersonalInfoCubitState> {
  final GetUserInfoUseCase _getUserInfoUseCase;
  final CreateUserUseCase _createUserUseCase;
  PersonalInfoCubitCubit(this._getUserInfoUseCase, this._createUserUseCase)
      : super(PersonalInfoInitial());

  static PersonalInfoCubitCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getUserInfo(String userId) async {
    emit(PersonalInfoLoading());
    await _getUserInfoUseCase(params: userId).then((personalInfo) {
      emit(PersonalInfoLoaded(personalInfo));
    }).catchError((e) {
      emit(PersonalInfoFailed(e.toString()));
    });
  }

  Future<void> createNewUser(PersonalInfo userInfo) async {
    emit(UserCreationLoading());
    await _createUserUseCase(params: userInfo).then((_) {
      emit(UserCreationLoaded(userInfo));
    }).catchError((e) {
      emit(PersonalInfoFailed(e.toString()));
    });
  }
}
