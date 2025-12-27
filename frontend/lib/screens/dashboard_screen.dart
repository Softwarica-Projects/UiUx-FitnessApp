import 'package:flutter/material.dart';
import 'package:habit_tracker/components/double_back_to_close_app.dart';
import 'package:habit_tracker/components/permission.dart';
import 'package:habit_tracker/screens/diet_screen.dart';
import 'package:habit_tracker/utils/app_constants.dart';

import '../../extensions/extension_util/context_extensions.dart';
import '../extensions/LiveStream.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../models/bottom_bar_item_model.dart';
import '../network/rest_api.dart';
import '../utils/app_colors.dart';
import '../utils/app_common.dart';
import '../utils/app_images.dart';
import 'home_screen.dart';

bool? isFirstTime = false;

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  int mCurrentIndex = 0;
  int mCounter = 0;

  late AnimationController _controller;
  late Animation<double> _animation;

  final tab = [HomeScreen(), DietScreen(), SizedBox(), SizedBox(), SizedBox()];

  List<BottomBarItemModel> bottomItemList = [
    BottomBarItemModel(iconData: ic_home_outline, selectedIconData: ic_home_fill, labelText: languages.lblHome),
    BottomBarItemModel(iconData: ic_diet_outline, selectedIconData: ic_diet_fill, labelText: languages.lblDiet),
    BottomBarItemModel(iconData: ic_report_outline, selectedIconData: ic_report_fill, labelText: languages.lblReport),
    BottomBarItemModel(iconData: ic_schedule, selectedIconData: ic_fill_schedule, labelText: languages.lblSchedule),
    BottomBarItemModel(iconData: ic_user, selectedIconData: ic_user_fill_icon, labelText: languages.lblProfile),
  ];

  @override
  void initState() {
    super.initState();
    init();
    LiveStream().on("LANGUAGE", (s) {
      setState(() {});
    });
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  init() async {
    await getSettingList();
    Permissions.activityPermissionsGranted();

    LiveStream().on(CHANGE_LANGUAGE, (p0) {
      setState(() {});
    });
  }

  Future<void> getSettingList() async {
    await getSettingApi().then((value) {
      getSettingData().whenComplete(() {});
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DoubleBackToCloseApp(
            snackBar: SnackBar(
              elevation: 4,
              backgroundColor: primaryOpacity,
              content: Text(languages.lblTapBackAgainToLeave, style: primaryTextStyle()),
            ),
            child: AnimatedContainer(color: context.cardColor, duration: const Duration(seconds: 1), child: tab[mCurrentIndex]),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        enableFeedback: false,
        selectedLabelStyle: secondaryTextStyle(size: 13),
        unselectedLabelStyle: secondaryTextStyle(size: 12),
        backgroundColor: context.cardColor,
        currentIndex: mCurrentIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: primaryColor,
        onTap: (index) {
          mCurrentIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
            tooltip: languages.lblHome,
            icon: Image.asset(ic_home_outline, color: Colors.grey, height: 24),
            activeIcon: Image.asset(ic_home_fill, color: primaryColor, height: 24),
            label: languages.lblHome,
          ),
          BottomNavigationBarItem(
            tooltip: languages.lblDiet,
            icon: Image.asset(ic_diet_outline, color: Colors.grey, height: 24),
            activeIcon: Image.asset(ic_diet_fill, color: primaryColor, height: 24),
            label: languages.lblDiet,
          ),
          BottomNavigationBarItem(
            tooltip: languages.lblReport,
            icon: Image.asset(ic_report_outline, color: Colors.grey, height: 24),
            activeIcon: Image.asset(ic_report_fill, color: primaryColor, height: 24),
            label: languages.lblReport,
          ),
          BottomNavigationBarItem(
            tooltip: languages.lblSchedule,
            icon: Image.asset(ic_schedule, color: Colors.grey, height: 22),
            activeIcon: Image.asset(ic_fill_schedule, color: primaryColor, height: 24),
            label: languages.lblSchedule,
          ),
          BottomNavigationBarItem(
            tooltip: languages.lblProfile,
            icon: Image.asset(ic_user, color: Colors.grey, height: 24),
            activeIcon: Image.asset(ic_user_fill_icon, color: primaryColor, height: 24),
            label: languages.lblProfile,
          ),
        ],
      ),
    );
  }
}
