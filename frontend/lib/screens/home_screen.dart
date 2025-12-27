import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:habit_tracker/components/equipment_component.dart';
import 'package:habit_tracker/extensions/horizontal_list.dart';
import 'package:habit_tracker/network/rest_api.dart';
import 'package:habit_tracker/screens/view_equipment_screen.dart';

import '../../components/level_component.dart';
import '../../extensions/decorations.dart';
import '../../extensions/extension_util/context_extensions.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/string_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/widgets.dart';
import '../../main.dart';
import '../../screens/view_level_screen.dart';
import '../../utils/app_colors.dart';
import '../extensions/app_text_field.dart';
import '../extensions/common.dart';
import '../extensions/loader_widget.dart';
import '../extensions/text_styles.dart';
import '../models/dashboard_response.dart';
import '../utils/app_common.dart';
import '../utils/app_images.dart';

bool? isFirstTimeGraph = false;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController mScrollController = ScrollController();
  TextEditingController mSearchCont = TextEditingController();
  String? mSearchValue = "";
  bool _showClearButton = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((val) {
      getUserDetailsApiCall();
    });

    super.initState();
  }

  getUserDetailsApiCall() async {
    await getUSerDetail(context, userStore.userId).whenComplete(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget mHeading(String? title, {bool? isSeeAll = false, Function? onCall}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title ?? '', style: boldTextStyle(size: 18)).paddingSymmetric(horizontal: 16),
        IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: const Icon(Feather.chevron_right, color: primaryColor),
          onPressed: () {
            onCall!.call();
          },
        ).paddingRight(2),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Observer(
                  builder: (context) {
                    return Container(
                      decoration: boxDecorationWithRoundedCorners(
                        boxShape: BoxShape.circle,
                        border: Border.all(color: primaryColor, width: 1),
                      ),
                      child: cachedImage(userStore.profileImage.validate(), width: 42, height: 42, fit: BoxFit.cover).cornerRadiusWithClipRRect(100).paddingAll(1),
                    ).onTap(() {
                      //todo
                    });
                  },
                ),
                10.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${userStore.fName.validate().capitalizeFirstLetter()} ${userStore.lName.capitalizeFirstLetter()}",
                      style: boldTextStyle(size: 18),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(userStore.email, style: secondaryTextStyle()),
                  ],
                ).expand(),
              ],
            ).expand(),
            Container(
              decoration: boxDecorationWithRoundedCorners(
                borderRadius: radius(16),
                border: Border.all(color: context.dividerColor.withOpacity(0.9), width: 0.6),
                backgroundColor: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Image.asset(ic_notification, width: 24, height: 24, color: Colors.grey),
            ).onTap(() {
              //todo
            }),
          ],
        ).paddingOnly(top: context.statusBarHeight + 16, left: 16, right: 16, bottom: 6),
      ),
      body: RefreshIndicator(
        backgroundColor: context.scaffoldBackgroundColor,
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1), () {
            setState(() {});
          });
        },
        child: FutureBuilder(
          future: getDashboardApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              DashboardResponse? mDashboardResponse = snapshot.data;
              if (mDashboardResponse == null) return const SizedBox();
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    16.height,
                    AppTextField(
                      controller: mSearchCont,
                      textFieldType: TextFieldType.OTHER,
                      isValidationRequired: false,
                      autoFocus: false,
                      suffix: _getClearButton(),
                      decoration: defaultInputDecoration(context, label: languages.lblSearch, isFocusTExtField: true),
                      onTap: () {
                        hideKeyboard(context);
                        //todo
                      },
                    ).paddingSymmetric(horizontal: 16),
                    16.height,
                    //todo body part
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.height,
                        mHeading(
                          languages.lblEquipmentsExercise,
                          onCall: () {
                            ViewEquipmentScreen().launch(context);
                          },
                        ),
                        HorizontalList(
                          physics:const BouncingScrollPhysics(),
                          itemCount: mDashboardResponse.equipment!.length,
                          padding: const. EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          spacing: 16,
                          itemBuilder: (context, index) {
                            return EquipmentComponent(mEquipmentModel: mDashboardResponse.equipment![index]);
                          },
                        ),
                      ],
                    ).visible(mDashboardResponse.equipment!.isNotEmpty),
                    //todo workouts
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.height,
                        mHeading(
                          languages.lblLevels,
                          onCall: () {
                            ViewLevelScreen().launch(context);
                          },
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: mDashboardResponse.level!.length,
                          itemBuilder: (context, index) {
                            return LevelComponent(mLevelModel: mDashboardResponse.level![index]);
                          },
                        ),
                        16.height,
                      ],
                    ).visible(mDashboardResponse.level!.isNotEmpty),
                  ],
                ),
              );
            }
            return snapWidgetHelper(
              snapshot,
              loadingWidget: Container(height: mq.height, width: mq.width, color: Colors.transparent, child: Loader()),
            );
          },
        ),
      ),
    );
  }

  Widget _getClearButton() {
    if (!_showClearButton) {
      return mSuffixTextFieldIconWidget(ic_search);
    }

    return IconButton(onPressed: () => mSearchCont.clear(), icon: const Icon(Icons.clear));
  }
}
