import 'package:uber/core/use_case/use_case.dart';
import '../../repositories/auth_repository.dart';

class LogOutUseCase implements UseCase<void, void> {
  final FirebaseAuthRepository _firebaseAuthRepository;

  LogOutUseCase(this._firebaseAuthRepository);

  @override
  Future<void> call({required void params}) {
    return _firebaseAuthRepository.logOut();
  }
}
