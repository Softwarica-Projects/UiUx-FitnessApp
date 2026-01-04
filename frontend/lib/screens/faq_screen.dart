import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/extensions/widgets.dart';

import '../extensions/extension_util/context_extensions.dart';
import '../extensions/extension_util/int_extensions.dart';
import '../extensions/extension_util/widget_extensions.dart';
import '../extensions/text_styles.dart';
import '../main.dart';
import '../utils/app_colors.dart';
import '../utils/app_common.dart';
import '../utils/app_images.dart';

class FaqScreen extends StatefulWidget {
  @override
  _FaqScreenState createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  List<FaqItem> faqItems = [];

  @override
  void initState() {
    super.initState();
    initializeFaqItems();
  }

  void initializeFaqItems() {
    faqItems = [
      FaqItem(
        question: 'How to add to favourite',
        answer: 'Press the heart icon to add or remove items from your favourites.\n\n'
            '• Filled colored heart icon means the item is already in your favourites\n'
            '• Outline (no-colored) heart icon means the item is not in favourites\n\n'
            'To view only your favourite diets and workouts, go to the Profile section and tap on "Favourite Workout and Nutritions".',
        isExpanded: false,
      ),
      FaqItem(
        question: 'How to start exercise',
        answer: 'To start an exercise:\n\n'
            '1. Navigate to the exercise detail page\n'
            '2. You will see a button to start the exercise\n'
            '3. When you are ready to do the exercise, press the start button\n'
            '4. The exercise timer will automatically start and guide you through the workout\n\n'
            'Make sure you are prepared and have enough space before starting the exercise timer.',
        isExpanded: false,
      ),
    ];
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
        appBar: appBarWidget(
          languages.lblFaq,
          context: context,
          color: context.cardColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                languages.lblFaqTitle,
                style: boldTextStyle(size: 24, color: primaryColor),
              ),
              8.height,
              Text(
                languages.lblFaqHeader,
                style: secondaryTextStyle(size: 14),
              ),
              24.height,
              ExpansionPanelList(
                elevation: 1,
                expandedHeaderPadding: EdgeInsets.zero,
                expansionCallback: (int index, bool isExpanded) {
                  setState(() {
                    faqItems[index].isExpanded = !isExpanded;
                  });
                },
                children: faqItems.map<ExpansionPanel>((FaqItem item) {
                  return ExpansionPanel(
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return InkWell(
                          onTap: () {
                            setState(() {
                              item.isExpanded = !item.isExpanded;
                            });
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.help_outline,
                                color: primaryColor,
                                size: 24,
                              ),
                            ),
                            title: Text(
                              item.question,
                              style: boldTextStyle(size: 16),
                            ),
                          ));
                    },
                    body: Container(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(height: 1, color: Colors.grey.shade300),
                          12.height,
                          Text(
                            item.answer,
                            style: secondaryTextStyle(size: 14, height: 1.5),
                          ),
                        ],
                      ),
                    ),
                    isExpanded: item.isExpanded,
                    canTapOnHeader: true,
                  );
                }).toList(),
              ),
              24.height,
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: primaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: primaryColor.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: primaryColor, size: 24),
                    16.width,
                    Expanded(
                      child: Text(
                        languages.lblFaqFooter,
                        style: secondaryTextStyle(size: 13, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FaqItem {
  FaqItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });

  String question;
  String answer;
  bool isExpanded;
}
