import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/components/weight_widget.dart';

import '../../extensions/extension_util/context_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/string_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/loader_widget.dart';
import '../../main.dart';
import '../../screens/dashboard_screen.dart';
import '../extensions/app_button.dart';
import '../extensions/app_text_field.dart';
import '../extensions/common.dart';
import '../extensions/constants.dart';
import '../extensions/decorations.dart';
import '../extensions/shared_pref.dart';
import '../extensions/text_styles.dart';
import '../models/register_request.dart';
import '../network/rest_api.dart';
import '../utils/app_colors.dart';
import '../utils/app_common.dart';
import '../utils/app_constants.dart';

class SignUpStep4Component extends StatefulWidget {
  @override
  _SignUpStep4ComponentState createState() => _SignUpStep4ComponentState();
}

class _SignUpStep4ComponentState extends State<SignUpStep4Component> with TickerProviderStateMixin {
  GlobalKey<FormState> mFormKey = GlobalKey<FormState>();

  TextEditingController mWeightCont = TextEditingController();
  TextEditingController mHeightCont = TextEditingController();

  FocusNode mWeightFocus = FocusNode();
  FocusNode mHeightFocus = FocusNode();
  int height = 170;

  int? mHeight = 0;
  int? mWeight = 0;

  double? mFeetValue = 0.0328084;
  double? mCMValue = 30.48;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    super.dispose();
    mWeightCont.dispose();
    mHeightCont.dispose();
  }

  init() async {
    mWeightCont.text = userStore.weight.validate().isNotEmpty ? "${userStore.weight.validate()} ${userStore.weightUnit}" : "";
    mHeightCont.text = userStore.height.validate().isNotEmpty ? "${userStore.height.validate()} ${userStore.heightUnit}" : "";

    mWeight = userStore.weightUnit == LBS ? 0 : 1;
    mHeight = userStore.heightUnit == FEET ? 0 : 1;

    appStore.setLoading(false);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void convertFeetToCm() {
    double a = double.parse(mHeightCont.text.isEmptyOrNull ? "0.0" : mHeightCont.text.validate()) * 30.48;
    if (!mHeightCont.text.isEmptyOrNull) {
      mHeightCont.text = a.toStringAsFixed(2).toString();
    }
    mHeightCont.selection = TextSelection.fromPosition(TextPosition(offset: mHeightCont.text.length));
  }

  void convertCMToFeet() {
    double a = double.parse(mHeightCont.text.isEmptyOrNull ? "0.0" : mHeightCont.text.validate()) * 0.0328;
    if (!mHeightCont.text.isEmptyOrNull) {
      mHeightCont.text = a.toStringAsFixed(2).toString();
    }
    mHeightCont.selection = TextSelection.fromPosition(TextPosition(offset: mHeightCont.text.length));
  }

  void convertLbsToKg() {
    double a = double.parse(mWeightCont.text.isEmptyOrNull ? "0.0" : mWeightCont.text.validate()) * 0.45359237;
    if (!mWeightCont.text.isEmptyOrNull) {
      mWeightCont.text = a.toStringAsFixed(2).toString();
    }
    mWeightCont.selection = TextSelection.fromPosition(TextPosition(offset: mWeightCont.text.length));
  }

  void convertKgToLbs() {
    double a = double.parse(mWeightCont.text.isEmptyOrNull ? "0.0" : mWeightCont.text.validate()) * 2.2046;
    if (!mWeightCont.text.isEmptyOrNull) {
      mWeightCont.text = a.toStringAsFixed(2).toString();
    }
    mWeightCont.selection = TextSelection.fromPosition(TextPosition(offset: mWeightCont.text.length));
  }

  Future<void> saveData() async {
    hideKeyboard(context);
    UserProfile userProfile = UserProfile();
    userProfile.age = userStore.age.toInt();
    userProfile.heightUnit = userStore.heightUnit.validate();
    userProfile.height = userStore.height.validate();
    userProfile.weight = userStore.weight.validate();
    userProfile.weightUnit = userStore.weightUnit.validate();
    Map<String, dynamic> req;
    req = {
      'first_name': userStore.fName.validate(),
      'last_name': userStore.lName.validate(),
      'username': getBoolAsync(IS_OTP) != true ? userStore.email.validate() : userStore.phoneNo.validate(),
      'email': userStore.email.validate(),
      'password': userStore.password.validate(),
      'user_type': LoginUser,
      'status': "active",
      'phone_number': userStore.phoneNo.validate(),
      'gender': userStore.gender.validate().toLowerCase(),
      'user_profile': userProfile,
      "player_id": getStringAsync(PLAYER_ID).validate(),
      if (getBoolAsync(IS_OTP) != false) "login_type": LoginTypeOTP,
    };

    appStore.setLoading(true);
    await registerApi(req).then((value) async {
      appStore.setLoading(false);
      userStore.setLogin(true);
      userStore.setToken(value.data!.apiToken.validate());
      getUserDetail(context, value.data!.id).then((value) {
        toast(languages.lblRegistrationSuccessfully);
        DashboardScreen().launch(context, isNewTask: true);
      }).catchError((e) {});
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString());
    });
    setState(() {});
  }

  WeightType weightType = WeightType.kg;

  double weight = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Form(
            key: mFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(languages.lblLetUsKnowBetter, style: boldTextStyle(size: 22)),
                24.height,
                Text(languages.lblWeight, style: secondaryTextStyle(color: textPrimaryColorGlobal)),
                4.height,
                AppTextField(
                  readOnly: false,
                  onChanged: (value) {
                    setState(() => weight = double.parse(value.isEmptyOrNull ? "0.0" : value));
                  },
                  controller: mWeightCont,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textFieldType: TextFieldType.NUMBER,
                  isValidationRequired: true,
                  focus: mWeightFocus,
                  nextFocus: mHeightFocus,
                  decoration: defaultInputDecoration(
                    context,
                    label: languages.lblEnterWeight,
                    mSuffix: Text("KG"),
                  ),
                ),
                16.height,
                Text(languages.lblHeight, style: secondaryTextStyle(color: textPrimaryColorGlobal)),
                4.height,
                AppTextField(
                  onChanged: (v) {
                    setState(() {
                      mHeightCont.text = v;
                    });
                  },
                  controller: mHeightCont,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textFieldType: TextFieldType.NUMBER,
                  isValidationRequired: true,
                  focus: mHeightFocus,
                  decoration: defaultInputDecoration(
                    context,
                    label: languages.lblEnterHeight,
                    mSuffix: Text("CM"),
                  ),
                ),
                24.height,
                AppButton(
                  text: languages.lblDone,
                  width: context.width(),
                  color: primaryColor,
                  onTap: () async {
                    if (mFormKey.currentState!.validate()) {
                      userStore.setIsSTEP('newUser');
                      userStore.setWeight(mWeightCont.text.validate().split(' ')[0]);
                      saveData();
                      setState(() {});
                    }
                  },
                ),
              ],
            ).paddingSymmetric(horizontal: 16),
          ),
        ),
        Loader().visible(appStore.isLoading),
      ],
    );
  }
}
