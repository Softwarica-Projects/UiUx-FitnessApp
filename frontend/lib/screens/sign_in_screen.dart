import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../extensions/extension_util/context_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/loader_widget.dart';
import '../../main.dart';
import '../../utils/app_images.dart';
import '../extensions/app_button.dart';
import '../extensions/app_text_field.dart';
import '../extensions/common.dart';
import '../extensions/constants.dart';
import '../extensions/decorations.dart';
import '../extensions/extension_util/string_extensions.dart';
import '../extensions/shared_pref.dart';
import '../extensions/text_styles.dart';
import '../utils/app_colors.dart';
import '../utils/app_common.dart';
import '../utils/app_constants.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GlobalKey<FormState> mFormKey = GlobalKey<FormState>();

  TextEditingController mEmailCont = TextEditingController();
  TextEditingController mPassCont = TextEditingController();

  FocusNode mEmailFocus = FocusNode();
  FocusNode mPassFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    if (getBoolAsync(IS_REMEMBER)) {
      mEmailCont.text = getStringAsync(EMAIL);
      mPassCont.text = getStringAsync(PASSWORD);
    }
    getCountryCodeFromLocale();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Future<void> save() async {
    hideKeyboard(context);
    Map<String, dynamic> req = {
      'email': mEmailCont.text.trim(),
      'user_type': LoginUser,
      'password': mPassCont.text.trim(),
      'player_id': getStringAsync(PLAYER_ID).validate(),
    };

    if (mFormKey.currentState!.validate()) {
      // todo
      // appStore.setLoading(true);

      setState(() {});
    }
  }

  Future<String?> getCountryCodeFromLocale() async {
    try {
      String localeName = Platform.localeName;

      if (localeName.contains('_')) {
        setValue(COUNTRY_CODE, localeName.split('_').last);
        return localeName.split('_').last;
      }
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        String locale = androidInfo.device;
        if (locale.contains('_')) {
          return locale.split('_').last;
        }
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        String locale = iosInfo.localizedModel;
        if (locale.contains('_')) {
          return locale.split('_').last;
        }
      }
    } catch (e) {
      print('Error getting country code: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(top: context.statusBarHeight + 16),
              child: Form(
                key: mFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(languages.lblWelcomeBack, style: boldTextStyle(size: 20)),
                        Text(languages.lblWelcomeBackDesc, style: secondaryTextStyle()),
                      ],
                    ).paddingOnly(left: mq.width * 0.040),
                    16.height,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        16.height,
                        Text(languages.lblEmail, style: secondaryTextStyle(color: textPrimaryColorGlobal)),
                        4.height,
                        AppTextField(
                          controller: mEmailCont,
                          focus: mEmailFocus,
                          textFieldType: TextFieldType.EMAIL,
                          nextFocus: mPassFocus,
                          suffix: mSuffixTextFieldIconWidget(ic_mail),
                          decoration: defaultInputDecoration(context, label: languages.lblEnterEmail),
                          isValidationRequired: true,
                        ),
                        16.height,
                        Text(languages.lblPassword, style: secondaryTextStyle(color: textPrimaryColorGlobal)),
                        4.height,
                        AppTextField(
                          controller: mPassCont,
                          focus: mPassFocus,
                          textFieldType: TextFieldType.PASSWORD,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: defaultInputDecoration(context, label: languages.lblEnterPassword),
                          onFieldSubmitted: (c) {
                            save();
                          },
                        ),
                        16.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: mq.height * 0.025,
                                  width: mq.width * 0.050,
                                  child: Checkbox(
                                    fillColor: WidgetStatePropertyAll(getBoolAsync(IS_REMEMBER) ? primaryColor : Colors.transparent),
                                    shape: RoundedRectangleBorder(borderRadius: radius(4)),
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    focusColor: primaryColor,
                                    side: BorderSide(color: primaryColor),
                                    activeColor: primaryColor,
                                    value: getBoolAsync(IS_REMEMBER),
                                    onChanged: (bool? value) async {
                                      await setValue(IS_REMEMBER, value);
                                      setState(() {});
                                    },
                                  ),
                                ),
                                6.width,
                                Text(languages.lblRememberMe, style: secondaryTextStyle(color: primaryColor)),
                              ],
                            ).expand(),
                            Text(languages.lblForgotPassword, style: secondaryTextStyle(color: primaryColor)).onTap(() {
                              //TODO forgot password screen
                            }, hoverColor: Colors.transparent, splashColor: Colors.transparent, highlightColor: Colors.transparent),
                          ],
                        ),
                        60.height,
                        Row(
                          children: [
                            Container(width: context.width() * 0.4, height: 1, color: context.dividerColor),
                            Text(languages.lblOr, style: secondaryTextStyle()).paddingSymmetric(horizontal: 10),
                            Container(width: context.width() * 0.4, height: 1, color: context.dividerColor),
                          ],
                        ),
                        24.height,
                        AppButton(
                          text: languages.lblLogin,
                          width: context.width(),
                          color: primaryColor,
                          onTap: () {
                            save();
                          },
                        ),
                        24.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(languages.lblNewUser, style: primaryTextStyle()),
                            GestureDetector(child: Text(languages.lblRegisterNow, style: primaryTextStyle(color: primaryColor)).paddingLeft(4), onTap: () {})
                          ],
                        ),
                        24.height,
                      ],
                    ).paddingSymmetric(horizontal: mq.height * 0.020, vertical: 4),
                  ],
                ),
              ),
            ),
            Observer(builder: (context) {
              return Loader().center().visible(appStore.isLoading);
            })
          ],
        ),
      ),
    );
  }
}
