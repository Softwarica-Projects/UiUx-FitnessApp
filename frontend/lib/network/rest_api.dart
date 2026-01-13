import 'dart:convert';

import 'package:habit_tracker/extensions/extension_util/int_extensions.dart';
import 'package:habit_tracker/extensions/extension_util/string_extensions.dart';
import 'package:habit_tracker/languageConfiguration/ServerLanguageResponse.dart';
import 'package:habit_tracker/main.dart';
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
import 'package:habit_tracker/network/network_utils.dart';
import 'package:habit_tracker/utils/app_config.dart';
import 'package:http/http.dart';

import '../models/login_response.dart';

Future<LoginResponse> logInApi(request) async {
  Response response = await buildHttpResponse('login', request: request, method: HttpMethod.POST);
  if (!response.statusCode.isSuccessful()) {
    if (response.body.isJson()) {
      var json = jsonDecode(response.body);

      if (json.containsKey('code') && json['code'].toString().contains('invalid_username')) {
        throw 'invalid_username';
      }
    }
  }

  return await handleResponse(response).then((value) async {
    LoginResponse loginResponse = LoginResponse.fromJson(value);
    UserModel? userResponse = loginResponse.data;

    saveUserData(userResponse);
    await userStore.setLogin(true);
    return loginResponse;
  });
}

Future<void> saveUserData(UserModel? userModel) async {
  if (userModel!.apiToken.validate().isNotEmpty) await userStore.setToken(userModel.apiToken.validate());
  await userStore.setToken(userModel.apiToken.validate());
  await userStore.setUserID(userModel.id.validate());
  await userStore.setUserEmail(userModel.email.validate());
  await userStore.setFirstName(userModel.firstName.validate());
  await userStore.setLastName(userModel.lastName.validate());
  await userStore.setUsername(userModel.username.validate());
  await userStore.setUserImage(userModel.profileImage.validate());
  await userStore.setDisplayName(userModel.displayName.validate());
  await userStore.setPhoneNo(userModel.phoneNumber.validate());
  await userStore.setGender(userModel.gender.validate());
}

Future<FitnessBaseResponse> changePwdApi(Map req) async {
  return FitnessBaseResponse.fromJson(await handleResponse(await buildHttpResponse('change-password', request: req, method: HttpMethod.POST)));
}

Future<FitnessBaseResponse> forgotPwdApi(Map req) async {
  return FitnessBaseResponse.fromJson(await handleResponse(await buildHttpResponse('forget-password', request: req, method: HttpMethod.POST)));
}

Future<FitnessBaseResponse> deleteUserAccountApi() async {
  return FitnessBaseResponse.fromJson(await handleResponse(await buildHttpResponse('delete-user-account', method: HttpMethod.POST)));
}

Future<LoginResponse> registerApi(Map req) async {
  return LoginResponse.fromJson(await handleResponse(await buildHttpResponse('register', request: req, method: HttpMethod.POST)));
}

Future<LoginResponse> updateProfileApi(Map req) async {
  return LoginResponse.fromJson(await handleResponse(await buildHttpResponse('update-profile', request: req, method: HttpMethod.POST)));
}

Future<BodyPartResponse> getBodyPartApi(int? page) async {
  return BodyPartResponse.fromJson(await (handleResponse(await buildHttpResponse("bodypart-list?page=$page", method: HttpMethod.GET))));
}

Future<EquipmentResponse> getEquipmentListApi({int? page = 1}) async {
  return EquipmentResponse.fromJson(await (handleResponse(await buildHttpResponse("equipment-list?page=$page", method: HttpMethod.GET))));
}

Future<WorkoutResponse> getWorkoutListApi(bool? isFav, bool? isAssign, {int? page = 1}) async {
  if (isAssign == true) {
    return WorkoutResponse.fromJson(await handleResponse(await buildHttpResponse('assign-workout-list?page=$page', method: HttpMethod.GET)));
  } else {
    if (isFav != true) {
      return WorkoutResponse.fromJson(await (handleResponse(await buildHttpResponse("workout-list?page=$page", method: HttpMethod.GET))));
    } else {
      return WorkoutResponse.fromJson(await handleResponse(await buildHttpResponse('get-favourite-workout?page=$page', method: HttpMethod.GET)));
    }
  }
}

Future<WorkoutTypeResponse> getWorkoutTypeListApi({int mPerPage = WORKOUT_TYPE_PAGE}) async {
  return WorkoutTypeResponse.fromJson(await (handleResponse(await buildHttpResponse("workouttype-list", method: HttpMethod.GET))));
}

Future<LevelResponse> getLevelListApi({int? page = 1, int mPerPage = LEVEL_PER_PAGE}) async {
  return LevelResponse.fromJson(await (handleResponse(await buildHttpResponse("level-list?page=$page", method: HttpMethod.GET))));
}

Future<ScheduledResponse> getClassSchedule({int? page = 1, String? selectedDate}) async {
  return ScheduledResponse.fromJson(await (handleResponse(await buildHttpResponse("class-schedule-list?page=$page&date=$selectedDate", method: HttpMethod.GET))));
}

Future<FitnessBaseResponse> getClassSchedulePlan(Map req) async {
  return FitnessBaseResponse.fromJson(await (handleResponse(await buildHttpResponse("class-schedule-plan-save", request: req, method: HttpMethod.POST))));
}

Future<ServerLanguageResponse> getLanguageList(versionNo) async {
  return ServerLanguageResponse.fromJson(await handleResponse(await buildHttpResponse('language-table-list?version_no=$versionNo', method: HttpMethod.GET)).then((value) => value));
}

Future<BlogDetailResponse> setExerciseHistory(Map req) async {
  return BlogDetailResponse.fromJson(await (handleResponse(await buildHttpResponse("store-user-exercise", request: req, method: HttpMethod.POST))));
}

Future<DietResponse> getDietApi(String? isFeatured, bool? isCategory, {int? page = 1, bool? isAssign = false, bool? isFav = false, int? categoryId}) async {
  if (isFav == true) {
    return DietResponse.fromJson(await (handleResponse(await buildHttpResponse("get-favourite-diet?page=$page", method: HttpMethod.GET))));
  } else if (isAssign == true) {
    return DietResponse.fromJson(await (handleResponse(await buildHttpResponse("assign-diet-list?page=$page", method: HttpMethod.GET))));
  } else if (isCategory == true) {
    return DietResponse.fromJson(await (handleResponse(await buildHttpResponse("diet-list?categorydiet_id=$categoryId&page=$page", method: HttpMethod.GET))));
  } else {
    return DietResponse.fromJson(await (handleResponse(await buildHttpResponse("diet-list?is_featured=$isFeatured&page=$page", method: HttpMethod.GET))));
  }
}

Future<CategoryDietResponse> getDietCategoryApi({int? page}) async {
  return CategoryDietResponse.fromJson(await (handleResponse(await buildHttpResponse("categorydiet-list?page=$page", method: HttpMethod.GET))));
}

Future<DashboardResponse> getDashboardApi() async {
  return DashboardResponse.fromJson(await handleResponse(await buildHttpResponse('dashboard-detail', method: HttpMethod.GET)));
}

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
  if (mSearchValue.isEmptyOrNull) {
    if (isBodyPart == true) {
      return ExerciseResponse.fromJson(await handleResponse(await buildHttpResponse('exercise-list?bodypart_id=$id&page=$page', method: HttpMethod.GET)));
    } else if (isEquipment == true) {
      return ExerciseResponse.fromJson(await handleResponse(await buildHttpResponse('exercise-list?equipment_id=${isFilter == true ? ids : id}&page=$page', method: HttpMethod.GET)));
    } else if (isLevel == true) {
      return ExerciseResponse.fromJson(await handleResponse(await buildHttpResponse('exercise-list?level_ids=${isFilter == true ? ids : id}&page=$page', method: HttpMethod.GET)));
    } else {
      return ExerciseResponse.fromJson(await handleResponse(await buildHttpResponse('exercise-list?page=$page', method: HttpMethod.GET)));
    }
  } else {
    if (isBodyPart == true) {
      return ExerciseResponse.fromJson(await handleResponse(await buildHttpResponse('exercise-list?bodypart_id=$id&title=$mSearchValue', method: HttpMethod.GET)));
    } else if (isEquipment == true) {
      return ExerciseResponse.fromJson(await handleResponse(await buildHttpResponse('exercise-list?equipment_id=${isFilter == true ? ids : id}&title=$mSearchValue', method: HttpMethod.GET)));
    } else if (isLevel == true) {
      return ExerciseResponse.fromJson(await handleResponse(await buildHttpResponse('exercise-list?level_ids=${isFilter == true ? ids : id}&title=$mSearchValue', method: HttpMethod.GET)));
    } else {
      return ExerciseResponse.fromJson(await handleResponse(await buildHttpResponse('exercise-list?title=$mSearchValue', method: HttpMethod.GET)));
    }
  }
}

Future<ExerciseResponse> getExerciseListApi({int? page}) async {
  return ExerciseResponse.fromJson(await handleResponse(await buildHttpResponse('get-user-exercise?page=$page', method: HttpMethod.GET)));
}

Future<ExerciseDetailResponse> geExerciseDetailApi(int? id) async {
  return ExerciseDetailResponse.fromJson(await handleResponse(await buildHttpResponse('exercise-detail?id=$id', method: HttpMethod.GET)));
}

Future<FitnessBaseResponse> setDietFavApi(Map req) async {
  return FitnessBaseResponse.fromJson(await handleResponse(await buildHttpResponse('set-favourite-diet', request: req, method: HttpMethod.POST)));
}

Future<UserResponse> getUserDataApi({int? id}) async {
  return UserResponse.fromJson(await (handleResponse(await buildHttpResponse("user-detail?id=$id", method: HttpMethod.GET))));
}

Future<WorkoutDetailResponse> getWorkoutDetailApi(int? id) async {
  return WorkoutDetailResponse.fromJson(await (handleResponse(await buildHttpResponse("workout-detail?id=$id", method: HttpMethod.GET))));
}

Future<WorkoutResponse> getWorkoutFilterListApi({int? page = 1, int? id, bool? isFilter, var ids, bool? isLevel = false, bool? isType}) async {
  if (isType == true) {
    return WorkoutResponse.fromJson(await handleResponse(await buildHttpResponse('workout-list?workout_type_id=${isFilter == true ? ids : id}', method: HttpMethod.GET)));
  } else if (isLevel == true) {
    return WorkoutResponse.fromJson(await handleResponse(await buildHttpResponse('workout-list?level_ids=${isFilter == true ? ids : id}', method: HttpMethod.GET)));
  } else {
    return WorkoutResponse.fromJson(await (handleResponse(await buildHttpResponse('workout-list?page=$page', method: HttpMethod.GET))));
  }
}

Future<DayExerciseResponse> getDayExerciseApi(int? id) async {
  return DayExerciseResponse.fromJson(await (handleResponse(await buildHttpResponse("workoutday-exercise-list?workout_day_id=$id", method: HttpMethod.GET))));
}

Future<FitnessBaseResponse> setWorkoutFavApi(Map req) async {
  return FitnessBaseResponse.fromJson(await handleResponse(await buildHttpResponse('set-favourite-workout', request: req, method: HttpMethod.POST)));
}

Future<DietResponse> getDietFavApi() async {
  return DietResponse.fromJson(await handleResponse(await buildHttpResponse('get-favourite-workout', method: HttpMethod.GET)));
}

Future<FitnessBaseResponse> setProgressApi(Map req) async {
  return FitnessBaseResponse.fromJson(await handleResponse(await buildHttpResponse('usergraph-save', request: req, method: HttpMethod.POST)));
}

Future<FitnessBaseResponse> deleteProgressApi(Map req) async {
  return FitnessBaseResponse.fromJson(await handleResponse(await buildHttpResponse('usergraph-delete', request: req, method: HttpMethod.POST)));
}

Future<GraphResponse> getProgressApi(String? type, {int? page = 1, String? isFilterType, bool? isFilter = false}) async {
  if (isFilter == true) {
    return GraphResponse.fromJson(await handleResponse(await buildHttpResponse('usergraph-list?type=$type&page=$page&duration=$isFilterType', method: HttpMethod.GET)));
  } else {
    return GraphResponse.fromJson(await handleResponse(await buildHttpResponse('usergraph-list?type=$type&page=$page', method: HttpMethod.GET)));
  }
}

Future<DietResponse> getSearchDietApi({String? mSearch = ""}) async {
  return DietResponse.fromJson(await (handleResponse(await buildHttpResponse("diet-list?title=$mSearch", method: HttpMethod.GET))));
}

Future<DietModel> getSearchDietListApi() async {
  return DietModel.fromJson(await (handleResponse(await buildHttpResponse("diet-list", method: HttpMethod.GET))));
}

Future<NotificationResponse> notificationApi() async {
  return NotificationResponse.fromJson(await handleResponse(await buildHttpResponse('notification-list', method: HttpMethod.POST)));
}

Future<NotificationResponse> notificationStatusApi(String? id) async {
  return NotificationResponse.fromJson(await handleResponse(await buildHttpResponse('notification-detail?id=$id', method: HttpMethod.GET)));
}
