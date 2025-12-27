import 'package:habit_tracker/languageConfiguration/ServerLanguageResponse.dart';
import 'package:habit_tracker/models/base_response.dart';
import 'package:habit_tracker/models/level_response.dart';
import 'package:habit_tracker/utils/app_config.dart';

import '../demoData.dart';
import '../models/login_response.dart';

///[Auth]
Future<LoginResponse> logInApi(request) async {
  await demoDelay();
  return LoginResponse.fromJson(demoUser.toJson());
}

Future<LoginResponse> registerApi(Map req) async {
  await demoDelay();
  return LoginResponse.fromJson(demoUser.toJson());
}

Future<FitnessBaseResponse> forgotPwdApi(Map req) async {
  await demoDelay();
  return FitnessBaseResponse.fromJson({"message": "Password reset link sent"});
}

///[Localization]
Future<ServerLanguageResponse> getLanguageList(versionNo) async {
  await demoDelay();
  return ServerLanguageResponse.fromJson({
    "languages": ["en"]
  });
}

///[Settings]
Future<FitnessBaseResponse> changePwdApi(Map req) async {
  await demoDelay();
  return FitnessBaseResponse.fromJson({"message": "Password changed successfully"});
}

Future<FitnessBaseResponse> deleteUserAccountApi() async {
  await demoDelay();
  return FitnessBaseResponse.fromJson({"message": "User account deleted"});
}

Future<LoginResponse> updateProfileApi(Map req) async {
  await demoDelay();
  return LoginResponse.fromJson(demoUser.toJson());
}

///[Levels]
Future<LevelResponse> getLevelListApi({int? page = 1, int mPerPage = LEVEL_PER_PAGE}) async {
  return LevelResponse.fromJson(await fakePagination(data: demoLevels.map((e) => e.toJson()).toList(), page: page ?? 1));
}
