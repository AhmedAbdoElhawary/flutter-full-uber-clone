abstract class FirebaseAuthRepository {
  Future<String?> submitPhoneNumber(String mobilePhone);
  Future<String> submitOTP(String otpCode);
  Future<void> logOut();
}
