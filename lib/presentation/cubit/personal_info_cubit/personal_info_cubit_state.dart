part of 'personal_info_cubit_cubit.dart';

abstract class PersonalInfoCubitState extends Equatable {
  const PersonalInfoCubitState();

  @override
  List<Object> get props => [];
}

class PersonalInfoInitial extends PersonalInfoCubitState {}

class PersonalInfoLoading extends PersonalInfoCubitState {}

class PersonalInfoLoaded extends PersonalInfoCubitState {
  final PersonalInfo? personalInfo;

  const PersonalInfoLoaded(this.personalInfo);
}
class UserCreationLoading extends PersonalInfoCubitState {}

class UserCreationLoaded extends PersonalInfoCubitState {
  final PersonalInfo personalInfo;

  const UserCreationLoaded(this.personalInfo);
}
class PersonalInfoFailed extends PersonalInfoCubitState {
  final String error;
  const PersonalInfoFailed(this.error);
}
