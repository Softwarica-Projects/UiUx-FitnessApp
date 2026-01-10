import 'package:flutter/material.dart';
import 'package:habit_tracker/service/remote_notification_service.dart';

import '../extensions/shared_pref.dart';
import '../main.dart';
import '../utils/app_constants.dart';

Future<void> logout(BuildContext context, {Function? onLogout}) async {
  await removeKey(IS_LOGIN);
  await removeKey(USER_ID);
  await removeKey(FIRSTNAME);
  await removeKey(LASTNAME);
  await removeKey(USER_PROFILE_IMG);
  await removeKey(DISPLAY_NAME);
  await removeKey(PHONE_NUMBER);
  await removeKey(GENDER);
  await removeKey(AGE);
  await removeKey(HEIGHT);
  await removeKey(HEIGHT_UNIT);
  await removeKey(IS_OTP);
  await removeKey(WEIGHT);
  await removeKey(WEIGHT_UNIT);
  userStore.clearUserData();
  if (!getBoolAsync(IS_REMEMBER) || getBoolAsync(IS_OTP) == true) {
    await removeKey(PASSWORD);
    await removeKey(EMAIL);
  }
  await RemoteNotificationService.clearToken();
  userStore.setLogin(false);
  onLogout?.call();
}
