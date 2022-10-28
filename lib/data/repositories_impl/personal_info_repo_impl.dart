import 'package:uber/data/data_sources/firebase_user_info.dart';
import 'package:uber/data/models/personal_info.dart';
import 'package:uber/domain/repositories/personal_info_repository.dart';

class PersonalInfoRepoImpl implements PersonalInfoRepository {
  @override
  Future<PersonalInfo?> getUserInfo(String userId) async {
    try {
      return await FireStoreUser.getUserInfo(userId);
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  @override
  Future<void> createNewUser(PersonalInfo userInfo) async {
    try {
      return await FireStoreUser.createNewUser(userInfo);
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
