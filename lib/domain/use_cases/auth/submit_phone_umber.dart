import 'package:uber/core/use_case/use_case.dart';
import '../../repositories/auth_repository.dart';

class VerifyMobilePhoneUseCase implements UseCase<String?, String> {
  final FirebaseAuthRepository _firebaseAuthRepository;

  VerifyMobilePhoneUseCase(this._firebaseAuthRepository);

  @override
  Future<String?> call({required String params}) {
    return _firebaseAuthRepository.submitPhoneNumber(params);
  }
}
