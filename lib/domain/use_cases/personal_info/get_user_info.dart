import 'package:uber/core/use_case/use_case.dart';
import 'package:uber/data/models/personal_info.dart';
import 'package:uber/domain/repositories/personal_info_repository.dart';

class GetUserInfoUseCase implements UseCase<PersonalInfo?, String> {
  final PersonalInfoRepository _personalInfoRepository;

  GetUserInfoUseCase(this._personalInfoRepository);

  @override
  Future<PersonalInfo?> call({required String params}) {
    return _personalInfoRepository.getUserInfo(params);
  }
}
