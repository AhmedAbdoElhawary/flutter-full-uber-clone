import 'package:uber/core/use_case/use_case.dart';
import 'package:uber/data/models/personal_info.dart';
import 'package:uber/domain/repositories/personal_info_repository.dart';

class CreateUserUseCase implements UseCase<void, PersonalInfo> {
  final PersonalInfoRepository _personalInfoRepository;

  CreateUserUseCase(this._personalInfoRepository);

  @override
  Future<void> call({required PersonalInfo params}) {
    return _personalInfoRepository.createNewUser(params);
  }
}
