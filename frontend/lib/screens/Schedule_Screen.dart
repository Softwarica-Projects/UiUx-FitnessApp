import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:habit_tracker/components/scheduled_component.dart';
import 'package:habit_tracker/extensions/animatedList/animated_list_view.dart';
import 'package:habit_tracker/extensions/extension_util/widget_extensions.dart';
import 'package:habit_tracker/extensions/loader_widget.dart';
import 'package:habit_tracker/extensions/text_styles.dart';
import 'package:habit_tracker/extensions/widgets.dart';
import 'package:habit_tracker/main.dart';
import 'package:habit_tracker/models/ScheduledResponse.dart';
import 'package:habit_tracker/network/rest_api.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleScreen extends StatefulWidget {
  ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => ScheduleScreenState();
}

class ScheduleScreenState extends State<ScheduleScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  CalendarFormat calendarFormat = CalendarFormat.week;
  DateTime focusedDay = DateTime.now();
  List<ScheduledModelData> scheduledWorkoutList = [];
  List<DateTime> _selectedDays = [];
  ScrollController scrollController = ScrollController();
  int page = 1;
  int? numPage;
  bool isLastPage = false;
  double? height = 300;
  int? numberOfWeeksInView = 6;

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    callScheduleApi();
    _selectedDays.add(DateTime.now());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.addListener(() {
        if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !appStore.isLoading) {
          if (page < numPage!) {
            page++;
            callScheduleApi();
          }
        }
      });
    });
  }

  Future<void> callScheduleApi() async {
    String commaSeparatedValues = _selectedDays.map((date) => DateFormat('yyyy-MM-dd').format(date)).join(',');
    appStore.setLoading(true);
    var dataSet = commaSeparatedValues.isNotEmpty
        ? commaSeparatedValues
        : _selectedDays.length == 0
            ? ''
            : DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
    await getClassSchedule(selectedDate: dataSet, page: page).then((value) {
      Iterable it = value.data!;
      numPage = value.pagination!.totalPages;
      isLastPage = false;

      if (page == 1) {
        scheduledWorkoutList.clear();
      }

      it.map((e) => scheduledWorkoutList.add(e)).toList();

      appStore.setLoading(false);
      setState(() {});
    }).catchError((e) {
      isLastPage = true;
      appStore.setLoading(false);
      setState(() {});
    }).whenComplete(() {
      appStore.setLoading(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: appBarWidget(
        languages.lblSchedule,
        context: context,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(languages.lblChangeView, style: primaryTextStyle()),
                  IconButton(
                    icon: Icon(height == 300 ? Icons.calendar_view_month : Icons.calendar_view_week),
                    onPressed: () {
                      setState(() {
                        height = height == 300 ? 100 : 300;
                        numberOfWeeksInView = numberOfWeeksInView == 6 ? 1 : 6;
                      });
                    },
                  ),
                ],
              ).paddingSymmetric(horizontal: 10),
              SizedBox(
                height: height,
                child: SfDateRangePicker(
                  initialDisplayDate: height == 300 ? DateTime.now() : DateTime.now(),
                  monthViewSettings: DateRangePickerMonthViewSettings(
                    numberOfWeeksInView: numberOfWeeksInView ?? 6,
                    //  firstDayOfWeek: 1
                  ),
                  initialSelectedDates: _selectedDays,
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    if (args.value is List<DateTime>) {
                      _selectedDays = List<DateTime>.from(args.value);
                    }
                    callScheduleApi();
                    setState(() {});
                  },
                  selectionMode: DateRangePickerSelectionMode.multiple,
                  initialSelectedRange: PickerDateRange(DateTime.now().subtract(const Duration(days: 4)), DateTime.now().add(const Duration(days: 3))),
                ),
              ),
              Expanded(
                child: AnimatedListView(
                  controller: scrollController,
                  itemCount: scheduledWorkoutList.length,
                  itemBuilder: (context, index) {
                    return ScheduledComponent(
                      scheduledWorkoutList: scheduledWorkoutList[index],
                      myCallback: (String price, String id) async {
                        callScheduleApi();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Observer(
            builder: (context) {
              return Container(color: Colors.transparent, width: double.infinity, height: double.infinity, child: Loader().center()).visible(appStore.isLoading);
            },
          ),
        ],
      ),
    );
  }
}
