import 'package:habit_tracker/languageConfiguration/ServerLanguageResponse.dart';
import 'package:habit_tracker/models/ScheduledResponse.dart';
import 'package:habit_tracker/models/app_setting_response.dart';
import 'package:habit_tracker/models/base_response.dart';
import 'package:habit_tracker/models/blog_detail_response.dart';
import 'package:habit_tracker/models/body_part_response.dart';
import 'package:habit_tracker/models/category_diet_response.dart';
import 'package:habit_tracker/models/dashboard_response.dart';
import 'package:habit_tracker/models/day_exercise_response.dart';
import 'package:habit_tracker/models/diet_response.dart';
import 'package:habit_tracker/models/equipment_response.dart';
import 'package:habit_tracker/models/exercise_detail_response.dart' hide Data;
import 'package:habit_tracker/models/exercise_response.dart';
import 'package:habit_tracker/models/get_setting_response.dart';
import 'package:habit_tracker/models/graph_response.dart';
import 'package:habit_tracker/models/level_response.dart';
import 'package:habit_tracker/models/notification_response.dart';
import 'package:habit_tracker/models/user_response.dart';
import 'package:habit_tracker/models/workout_detail_response.dart';
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

Future<DayExerciseResponse> getDayExerciseApi(int? id) async {
  return DayExerciseResponse.fromJson(await fakePagination(data: demoDayExercises.map((x) => x.toJson()).toList(), page: 1));
}

Future<ExerciseDetailResponse> geExerciseDetailApi(int? id) async {
  await demoDelay();
  return ExerciseDetailResponse.fromJson(demoExercises.isNotEmpty ? {"data": demoExercises.first.toJson()} : {});
}

Future<BlogDetailResponse> setExerciseHistory(Map req) async {
  await demoDelay();
  return BlogDetailResponse.fromJson({"id": 1, "title": "Demo Exercise History", "content": "This is a fake exercise history entry."});
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

Future<WorkoutDetailResponse> getWorkoutDetailApi(int? id) async {
  await demoDelay();
  return WorkoutDetailResponse.fromJson(demoWorkouts.isNotEmpty ? {"data": demoWorkouts.first.toJson(), "workoutday": demoWorkoutDays.map((e) => e.toJson()).toList()} : {});
}

///[Body Part]
Future<BodyPartResponse> getBodyPartApi(int? page) async {
  return BodyPartResponse.fromJson(await fakePagination(data: demoBodyParts.map((e) => e.toJson()).toList(), page: page ?? 1));
}

///[Progress]

Future<FitnessBaseResponse> setProgressApi(Map req) async {
  await demoDelay();
  return FitnessBaseResponse.fromJson({"message": "Progress updated"});
}

Future<FitnessBaseResponse> deleteProgressApi(Map req) async {
  await demoDelay();
  return FitnessBaseResponse.fromJson({"message": "Progress deleted"});
}

Future<GraphResponse> getProgressApi(String? type, {int? page = 1, String? isFilterType, bool? isFilter = false}) async {
  return GraphResponse.fromJson(await fakePagination(data: demoProgress.map((e) => e.toJson()).toList(), page: page ?? 1));
}

///[Notifications]
Future<NotificationResponse> notificationApi() async {
  return NotificationResponse.fromJson(await fakePagination(data: notifications.map((x) => x.toJson()).toList(), page: 1));
}

Future<NotificationResponse> notificationStatusApi(String? id) async {
  await demoDelay();
  return demoNotificationDetails;
}

///[Class Schedule]
Future<ScheduledResponse> getClassSchedule({int? page = 1, String? selectedDate}) async {
  return ScheduledResponse.fromJson(await fakePagination(data: demoScheduleList.map((e) => e.toJson()).toList(), page: page ?? 1));
}

Future<FitnessBaseResponse> getClassSchedulePlan(Map req) async {
  await demoDelay();
  return FitnessBaseResponse.fromJson({"message": "Class schedule plan set"});
}

Future<AppSettingResponse> getAppSettingApi() async {
  await demoDelay();
  return AppSettingResponse.fromJson({"theme": "light", "notifications": true});
}

Future<UserResponse> getUserDataApi({int? id}) async {
  await demoDelay();
  return UserResponse(
      data: Data.fromJson(
    demoUser.data!.toJson(),
  ));
}
