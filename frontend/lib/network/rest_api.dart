import 'package:habit_tracker/languageConfiguration/ServerLanguageResponse.dart';
import 'package:habit_tracker/models/base_response.dart';
import 'package:habit_tracker/models/body_part_response.dart';
import 'package:habit_tracker/models/category_diet_response.dart';
import 'package:habit_tracker/models/dashboard_response.dart';
import 'package:habit_tracker/models/diet_response.dart';
import 'package:habit_tracker/models/equipment_response.dart';
import 'package:habit_tracker/models/exercise_response.dart';
import 'package:habit_tracker/models/get_setting_response.dart';
import 'package:habit_tracker/models/level_response.dart';
import 'package:habit_tracker/models/workout_response.dart';
import 'package:habit_tracker/models/workout_type_response.dart';
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

Future<GetSettingResponse> getSettingApi() async {
  await demoDelay();
  return GetSettingResponse.fromJson({"setting": "demo", "value": true});
}

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

///[Equipment]
Future<EquipmentResponse> getEquipmentListApi({int? page = 1}) async {
  return EquipmentResponse.fromJson(await fakePagination(data: demoEquipment.map((e) => e.toJson()).toList(), page: page ?? 1));
}

///[Dashboard]
Future<DashboardResponse> getDashboardApi() async {
  await demoDelay();
  return demoDashboard;
}

///[Diet]
Future<CategoryDietResponse> getDietCategoryApi({int? page}) async {
  final categoryList = demoDietCategories.map((e) => e.toJson()).toList();
  return CategoryDietResponse.fromJson(await fakePagination(data: categoryList, page: page ?? 1));
}

Future<DietResponse> getDietApi(String? isFeatured, bool? isCategory, {int? page = 1, bool? isAssign = false, bool? isFav = false, int? categoryId}) async {
  return DietResponse.fromJson(await fakePagination(data: demoDiets.map((e) => e.toJson()).toList(), page: page ?? 1));
}

Future<FitnessBaseResponse> setDietFavApi(Map req) async {
  await demoDelay();
  return FitnessBaseResponse.fromJson({"message": "Diet marked as favorite"});
}

Future<DietResponse> getDietFavApi() async {
  return DietResponse.fromJson(await fakePagination(data: demoDiets.map((x) => x.toJson()).toList(), page: 1));
}

Future<DietResponse> getSearchDietApi({String? mSearch = ""}) async {
  return DietResponse.fromJson(await fakePagination(data: demoDiets.map((x) => x.toJson()).toList(), page: 1));
}

Future<DietModel> getSearchDietListApi() async {
  return DietModel.fromJson(await fakePagination(data: demoDiets.map((x) => x.toJson()).toList(), page: 1));
}

///[Exercise]
Future<ExerciseResponse> getExerciseApi({
  int? page,
  String? mSearchValue = " ",
  bool? isBodyPart = false,
  int? id,
  bool? isLevel = false,
  bool? isEquipment = false,
  var ids,
  bool? isFilter = false,
}) async {
  return ExerciseResponse.fromJson(await fakePagination(data: demoExercises.map((e) => e.toJson()).toList(), page: page ?? 1));
}

Future<ExerciseResponse> getExerciseListApi({int? page}) async {
  return ExerciseResponse.fromJson(await fakePagination(data: demoWorkouts.map((x) => x.toJson()).toList(), page: page ?? 1));
}

///[Workout]

Future<WorkoutResponse> getWorkoutListApi(bool? isFav, bool? isAssign, {int? page = 1}) async {
  return WorkoutResponse.fromJson(await fakePagination(data: demoWorkouts.map((e) => e.toJson()).toList(), page: page ?? 1));
}

Future<WorkoutTypeResponse> getWorkoutTypeListApi({int mPerPage = WORKOUT_TYPE_PAGE}) async {
  return WorkoutTypeResponse.fromJson(await fakePagination(data: demoWorkouts, page: 1));
}

Future<FitnessBaseResponse> setWorkoutFavApi(Map req) async {
  await demoDelay();
  return FitnessBaseResponse.fromJson({"message": "Workout marked as favorite"});
}

Future<WorkoutResponse> getWorkoutFilterListApi({int? page = 1, int? id, bool? isFilter, var ids, bool? isLevel = false, bool? isType}) async {
  return WorkoutResponse.fromJson(await fakePagination(data: demoWorkouts.map((x) => x.toJson()).toList(), page: page ?? 1));
}

///[Body Part]
Future<BodyPartResponse> getBodyPartApi(int? page) async {
  return BodyPartResponse.fromJson(await fakePagination(data: demoBodyParts.map((e) => e.toJson()).toList(), page: page ?? 1));
}
