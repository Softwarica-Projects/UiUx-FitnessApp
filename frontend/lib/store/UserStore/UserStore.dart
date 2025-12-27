import 'dart:convert';
import '../../models/progress_setting_model.dart';
import 'package:mobx/mobx.dart';
import '../../extensions/shared_pref.dart';
import '../../models/user_response.dart';
import '../../utils/app_constants.dart';

part 'UserStore.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  @observable
  bool isLoggedIn = false;

  @observable
  int chatNotificationCount = 0;

  @observable
  int userId = 0;

  @observable
  String isStep = '';

  @observable
  String email = '';

  @observable
  String password = '';

  @observable
  String fName = '';

  @observable
  String lName = '';

  @observable
  String profileImage = '';

  @observable
  String token = '';

  @observable
  String username = '';

  @observable
  String displayName = '';

  @observable
  String phoneNo = '';

  @observable
  String gender = '';

  @observable
  String age = '';

  @observable
  String height = '';

  @observable
  String weight = '';

  @observable
  String weightId = '';

  @observable
  String weightStoreGraph = '';

  @observable
  String weightUnit = 'kg';

  @observable
  String heightUnit = 'cm';

  @observable
  double idealWeight = 0.0;

  @observable
  bool isPlaying = false;

  @action
  Future<void> setPlaying(bool val, {bool isInitializing = false}) async {
    isPlaying = val;
    if (!isInitializing) await setValue(IS_PLAYING, val);
  }

  @observable
  List<ProgressSettingModel> mProgressList = ObservableList<ProgressSettingModel>();

  @action
  Future<void> updateProgress(ProgressSettingModel data) async {
    if (mProgressList.any((element) => element.id == data.id)) {
      mProgressList.removeWhere((element) => element.id == data.id);
      mProgressList.add(data);
    } else {
      mProgressList.add(data);
    }

    await setValue(PROGRESS_SETTINGS_DETAIL, jsonEncode(mProgressList));
  }

  @action
  Future<void> setIdealWeight(double val) async {
    idealWeight = val;
    await setValue(IdealWeight, val);
  }

  @action
  Future<void> addAllProgressSettingsListItem(List<ProgressSettingModel> mProgress) async {
    mProgressList.addAll(mProgress);
  }

  @action
  Future<void> setWeight(String val, {bool isInitialization = false}) async {
    weight = val;
    if (!isInitialization) await setValue(WEIGHT, val);
  }

  @action
  Future<void> setWeightId(String val, {bool isInitialization = false}) async {
    weightId = val;
    if (!isInitialization) await setValue(WEIGHT_ID, val);
  }

  @action
  Future<void> setWeightGraph(String val, {bool isInitialization = false}) async {
    weightStoreGraph = val;
    if (!isInitialization) await setValue(WEIGHT_GRAPH, val);
  }

  @action
  Future<void> setHeight(String val, {bool isInitialization = false}) async {
    height = val;
    if (!isInitialization) await setValue(HEIGHT, val);
  }

  @action
  Future<void> setAge(String val, {bool isInitialization = false}) async {
    age = val;
    if (!isInitialization) await setValue(AGE, val);
  }

  @action
  Future<void> setGender(String val, {bool isInitialization = false}) async {
    gender = val;
    if (!isInitialization) await setValue(GENDER, val);
  }

  @action
  Future<void> setPhoneNo(String val, {bool isInitialization = false}) async {
    phoneNo = val;
    if (!isInitialization) await setValue(PHONE_NUMBER, val);
  }

  @action
  Future<void> setDisplayName(String val, {bool isInitialization = false}) async {
    displayName = val;
    if (!isInitialization) await setValue(DISPLAY_NAME, val);
  }

  @action
  Future<void> setUsername(String val, {bool isInitialization = false}) async {
    username = val;
    if (!isInitialization) await setValue(USERNAME, val);
  }

  @action
  Future<void> setToken(String val, {bool isInitialization = false}) async {
    token = val;
    if (!isInitialization) await setValue(TOKEN, val);
  }

  @action
  Future<void> setUserImage(String val, {bool isInitialization = false}) async {
    profileImage = val;
    if (!isInitialization) await setValue(USER_PROFILE_IMG, val);
  }

  @action
  Future<void> setUserID(int val, {bool isInitialization = false}) async {
    userId = val;
    if (!isInitialization) await setValue(USER_ID, val);
  }

  @action
  Future<void> setLogin(bool val, {bool isInitializing = false}) async {
    isLoggedIn = val;
    if (!isInitializing) await setValue(IS_LOGIN, val);
  }

  @action
  Future<void> setFirstName(String val, {bool isInitialization = false}) async {
    fName = val;
    if (!isInitialization) await setValue(FIRSTNAME, val);
  }

  @action
  Future<void> setIsSTEP(String val, {bool isInitialization = false}) async {
    isStep = val;
    if (!isInitialization) await setValue(ISSTEP, val);
  }

  @action
  Future<void> setLastName(String val, {bool isInitialization = false}) async {
    lName = val;
    if (!isInitialization) await setValue(LASTNAME, val);
  }

  @action
  Future<void> setUserEmail(String val, {bool isInitialization = false}) async {
    email = val;
    if (!isInitialization) await setValue(EMAIL, val);
  }

  @action
  Future<void> setUserPassword(String val, {bool isInitialization = false}) async {
    password = val;
    if (!isInitialization) await setValue(PASSWORD, val);
  }

  @action
  Future<void> clearUserData() async {
    fName = '';
    lName = '';
    profileImage = '';
    token = '';
    username = '';
    displayName = '';
    phoneNo = '';
    gender = '';
    age = '';
    height = '';
    weight = '';
    weightUnit = '';
    heightUnit = '';
  }
}
