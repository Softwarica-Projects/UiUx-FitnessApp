import 'package:habit_tracker/main.dart';

// BoxDecoration bottomSheetDecoration = const BoxDecoration(
//   color: Color(0xffD9D9D9),
//   borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
// );

enum WeightType { kg, lb }

extension WeightTypeExtension on WeightType {
  String get name {
    switch (this) {
      case WeightType.kg:
        return languages.lblLbs;
      case WeightType.lb:
        return languages.lblKg;
    }
  }
}
