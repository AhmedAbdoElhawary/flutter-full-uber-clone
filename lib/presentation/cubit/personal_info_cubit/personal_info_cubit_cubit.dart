import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uber/data/models/personal_info.dart';
import 'package:uber/domain/repositories/personal_info_repository.dart';

part 'personal_info_cubit_state.dart';

class PersonalInfoCubitCubit extends Cubit<PersonalInfoCubitState> {
  final PersonalInfoRepository _personalInfoRepository;
  PersonalInfoCubitCubit(this._personalInfoRepository)
      : super(PersonalInfoInitial());

  static PersonalInfoCubitCubit get(BuildContext context) =>
      BlocProvider.of(context);

  Future<void> getUserInfo(String userId) async {
    emit(PersonalInfoLoading());
    await _personalInfoRepository.getUserInfo(userId).then((personalInfo) {
      emit(PersonalInfoLoaded(personalInfo));
    }).catchError((e) {
      emit(PersonalInfoFailed(e.toString()));
    });
  }

  Future<void> createNewUser(PersonalInfo userInfo) async {
    emit(UserCreationLoading());
    await _personalInfoRepository.createNewUser( userInfo).then((_) {
      emit(UserCreationLoaded(userInfo));
    }).catchError((e) {
      emit(PersonalInfoFailed(e.toString()));
    });
  }
}
