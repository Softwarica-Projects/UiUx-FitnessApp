import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/service/local_notification_service.dart';
import 'package:habit_tracker/service/remote_notification_service.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../extensions/extension_util/duration_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../main.dart';
import '../../screens/dashboard_screen.dart';
import '../../utils/app_images.dart';
import '../extensions/shared_pref.dart';
import '../utils/app_constants.dart';
import 'sign_in_screen.dart';
import 'walk_through_screen.dart';

class SplashScreen extends StatefulWidget {
  static String tag = '/SplashScreen';

  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((val) {
      _checkNotifyPermission();
    });
  }

  init() async {
    await 1.seconds.delay;
    if (!getBoolAsync(IS_FIRST_TIME)) {
      WalkThroughScreen().launch(context, isNewTask: true);
    } else {
      if (userStore.isLoggedIn) {
        DashboardScreen().launch(context, isNewTask: true);
      } else {
        SignInScreen().launch(context, isNewTask: true);
      }
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _checkNotifyPermission() async {
    await RemoteNotificationService.init();
    await LocalNotificationService().init();
    if (await Permission.notification.isGranted) {
      init();
    } else {
      await Permission.notification.request();
      init();
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Image.asset(
          ic_splash,
          width: double.maxFinite,
          height: double.maxFinite,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
