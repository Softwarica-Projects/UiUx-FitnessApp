import 'package:flutter/material.dart';
import 'package:habit_tracker/components/exercise_component.dart';
import 'package:habit_tracker/extensions/animatedList/animated_list_view.dart';
import 'package:habit_tracker/extensions/extension_util/widget_extensions.dart';
import 'package:habit_tracker/extensions/loader_widget.dart';
import 'package:habit_tracker/main.dart';
import 'package:habit_tracker/models/exercise_response.dart';
import 'package:habit_tracker/network/rest_api.dart';
import 'package:habit_tracker/screens/no_data_screen.dart';
import '../../extensions/widgets.dart';

class WorkoutHistoryScreen extends StatefulWidget {
  static String tag = '/WorkoutHistoryScreen';

  @override
  WorkoutHistoryScreenState createState() => WorkoutHistoryScreenState();
}

class WorkoutHistoryScreenState extends State<WorkoutHistoryScreen> {
  List<ExerciseModel> mExerciseList = [];
  ScrollController scrollController = ScrollController();

  int page = 1;
  int? numPage;

  bool isLastPage = false;
  @override
  void initState() {
    super.initState();
    init();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !appStore.isLoading) {
        if (page < numPage!) {
          page++;
          init();
        }
      }
    });
  }

  void init() async {
    getExerciseData();
  }

  Future<void> getExerciseData() async {
    appStore.setLoading(true);
    await getExerciseListApi(page: page)
        .then((value) {
          appStore.setLoading(false);
          numPage = value.pagination!.totalPages;
          isLastPage = false;
          if (page == 1) {
            mExerciseList.clear();
          }
          Iterable it = value.data!;
          it.map((e) => mExerciseList.add(e)).toList();
          setState(() {});
        })
        .catchError((e) {
          isLastPage = true;
          appStore.setLoading(false);
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget('Workout History', context: context),
      body: Stack(
        children: [
          mExerciseList.isNotEmpty
              ? AnimatedListView(
                  controller: scrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  itemCount: mExerciseList.length,
                  itemBuilder: (context, index) {
                    print("---------->>>${mExerciseList[index].id}");
                    return ExerciseComponent(mExerciseModel: mExerciseList[index]);
                  },
                )
              : NoDataScreen(mTitle: languages.lblExerciseNoFound).visible(!appStore.isLoading),
          Loader().center().visible(appStore.isLoading),
        ],
      ),
    );
  }
}
