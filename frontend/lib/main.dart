import 'dart:async';

import 'package:flutter/material.dart';
import 'package:habit_tracker/app_theme.dart';
import 'package:habit_tracker/extensions/constants.dart';
import 'package:habit_tracker/extensions/decorations.dart';
import 'package:habit_tracker/extensions/system_utils.dart';
import 'package:habit_tracker/languageConfiguration/AppLocalizations.dart';
import 'package:habit_tracker/languageConfiguration/BaseLanguage.dart';
import 'package:habit_tracker/languageConfiguration/LanguageDataConstant.dart';
import 'package:habit_tracker/languageConfiguration/ServerLanguageResponse.dart';
import 'package:habit_tracker/store/NotificationStore/NotificationStore.dart';
import 'package:habit_tracker/store/UserStore/UserStore.dart';
import 'package:habit_tracker/store/app_store.dart';
import 'package:habit_tracker/utils/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  languages = (await AppLocalizations().load(Locale("EN")));
  initJsonFile();
  defaultAppButtonShapeBorder = RoundedRectangleBorder(borderRadius: radius(defaultAppButtonRadius));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static String tag = '/MyApp';

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      scrollBehavior: SBehavior(),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
