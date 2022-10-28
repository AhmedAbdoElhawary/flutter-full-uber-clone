import 'package:uber/core/use_case/use_case.dart';
import '../../repositories/auth_repository.dart';

class SubmitOtpPhoneUseCase implements UseCase<String, String> {
  final FirebaseAuthRepository _firebaseAuthRepository;

  SubmitOtpPhoneUseCase(this._firebaseAuthRepository);

  @override
  Future<String> call({required String params}) {
    return _firebaseAuthRepository.submitOTP(params);
  }
}
