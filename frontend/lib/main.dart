import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';

import 'service/local_notification_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/languageConfiguration/AppLocalizations.dart';
import 'package:habit_tracker/languageConfiguration/BaseLanguage.dart';
import 'package:habit_tracker/languageConfiguration/LanguageDataConstant.dart';
import 'package:habit_tracker/languageConfiguration/ServerLanguageResponse.dart';
import 'package:habit_tracker/store/app_store.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../extensions/extension_util/string_extensions.dart';
import '../../extensions/system_utils.dart';
import '../store/NotificationStore/NotificationStore.dart';
import '../utils/app_colors.dart';
import 'app_theme.dart';
import 'extensions/common.dart';
import 'extensions/constants.dart';
import 'extensions/decorations.dart';
import 'extensions/shared_pref.dart';
import 'models/progress_setting_model.dart';
import 'network/rest_api.dart';
import 'screens/no_internet_screen.dart';
import 'screens/splash_screen.dart';
import 'store/UserStore/UserStore.dart';
import 'utils/app_common.dart';
import 'utils/app_config.dart';
import 'utils/app_constants.dart';

AppStore appStore = AppStore();
UserStore userStore = UserStore();
NotificationStore notificationStore = NotificationStore();
LanguageJsonData? selectedServerLanguageData;
List<LanguageJsonData>? defaultServerLanguageData = [];
late Size mq;
late SharedPreferences sharedPreferences;
final navigatorKey = GlobalKey<NavigatorState>();
late BaseLanguage languages;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  setDefaultLocate();
  await Firebase.initializeApp();
  languages = (await AppLocalizations().load(Locale("EN")));
  initJsonFile();
  setLogInValue();
  defaultAppButtonShapeBorder = RoundedRectangleBorder(borderRadius: radius(defaultAppButtonRadius));
  if (!getStringAsync(PROGRESS_SETTINGS_DETAIL).isEmptyOrNull) {
    userStore.addAllProgressSettingsListItem(jsonDecode(getStringAsync(PROGRESS_SETTINGS_DETAIL)).map<ProgressSettingModel>((e) => ProgressSettingModel.fromJson(e)).toList());
  } else {
    userStore.addAllProgressSettingsListItem(progressSettingList());
  }

  runApp(MyApp());
}

Future<void> updatePlayerId() async {
  Map req = {"player_id": getStringAsync(PLAYER_ID), "username": getStringAsync(USERNAME), "email": getStringAsync(EMAIL)};
  await updateProfileApi(req).then((value) {
    //
  }).catchError((error) {
    //
  });
}

class MyApp extends StatefulWidget {
  static String tag = '/MyApp';

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  bool isCurrentlyOnNoInternet = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((e) {
      if (e.contains(ConnectivityResult.none)) {
        log('not connected');
        isCurrentlyOnNoInternet = true;
        push(NoInternetScreen());
      } else {
        if (isCurrentlyOnNoInternet) {
          pop();
          isCurrentlyOnNoInternet = false;
          toast(languages.lblInternetIsConnected);
        }
        log('connected');
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      scrollBehavior: SBehavior(),
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
    );
  }
}
