import 'package:uber/data/models/personal_info.dart';

abstract class PersonalInfoRepository {
  Future<PersonalInfo?> getUserInfo(String userId);
  Future<void> createNewUser(PersonalInfo userInfo);
}
