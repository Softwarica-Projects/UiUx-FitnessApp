import 'package:habit_tracker/languageConfiguration/ServerLanguageResponse.dart';
import 'package:habit_tracker/models/base_response.dart';

import '../demoData.dart';
import '../models/login_response.dart';

Future<LoginResponse> logInApi(request) async {
  await demoDelay();
  return LoginResponse.fromJson(demoUser.toJson());
}

Future<LoginResponse> registerApi(Map req) async {
  await demoDelay();
  return LoginResponse.fromJson(demoUser.toJson());
}

Future<LoginResponse> updateProfileApi(Map req) async {
  await demoDelay();
  return LoginResponse.fromJson(demoUser.toJson());
}

Future<FitnessBaseResponse> forgotPwdApi(Map req) async {
  await demoDelay();
  return FitnessBaseResponse.fromJson({"message": "Password reset link sent"});
}

Future<ServerLanguageResponse> getLanguageList(versionNo) async {
  await demoDelay();
  return ServerLanguageResponse.fromJson({
    "languages": ["en"]
  });
}
