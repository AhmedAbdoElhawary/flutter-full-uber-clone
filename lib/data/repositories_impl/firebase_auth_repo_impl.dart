import 'package:uber/data/data_sources/firebase_auth.dart';
import 'package:uber/domain/repositories/auth_repository.dart';

class FirebaseAuthRepositoryImpl implements FirebaseAuthRepository {
  @override
  Future<String?> submitPhoneNumber(String mobilePhone) async {
    try {
      return await FirebaseAuthentication.submitPhoneNumber(mobilePhone);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<String> submitOTP(String otpCode) async {
    try {
      return await FirebaseAuthentication.submitOTP(otpCode);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      return await FirebaseAuthentication.logOut();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
