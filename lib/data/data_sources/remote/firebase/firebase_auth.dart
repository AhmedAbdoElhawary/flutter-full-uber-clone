import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthentication {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String? userUid;
  static late String verificationId;

  static Future<String?> submitPhoneNumber(String mobilePhone) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+2$mobilePhone',
      timeout: const Duration(seconds: 120),
      verificationCompleted: _verificationCompleted,
      verificationFailed: _verificationFailed,
      codeSent: _codeSent,
      codeAutoRetrievalTimeout: _codeAutoRetrievalTimeout,
    );
    return userUid;
  }

  static Future<String> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpCode);

    return await _signIn(credential);
  }

  static Future<void> logOut() async => await _firebaseAuth.signOut();

  static void _verificationCompleted(PhoneAuthCredential credential) async {
    await _signIn(credential);
  }

  static void _verificationFailed(FirebaseAuthException error) {
    throw error.toString();
  }

  static void _codeSent(String verifyId, int? resendToken) {
    verificationId = verifyId;
  }

  static void _codeAutoRetrievalTimeout(String verificationId) {}

  static Future<String> _signIn(PhoneAuthCredential credential) async {
    UserCredential user = await _firebaseAuth.signInWithCredential(credential);
    String? uid = user.user?.uid;
    if (uid == null) return "There is something wrong!";
    userUid = uid;
    return uid;
  }
}
