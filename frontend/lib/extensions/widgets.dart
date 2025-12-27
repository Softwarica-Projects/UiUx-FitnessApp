import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';
import '../extensions/shared_pref.dart';
import '../main.dart';
import '../utils/app_colors.dart';
import '../../extensions/extension_util/int_extensions.dart';
import '../../extensions/extension_util/string_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../extensions/system_utils.dart';
import '../../extensions/text_styles.dart';
import '../utils/app_constants.dart';
import 'common.dart';
import 'confirmation_dialog.dart';
import 'constants.dart';
import 'loader_widget.dart';

Future<bool?> showConfirmDialog<bool>(
  context,
  String title, {
  String positiveText = 'Yes',
  String negativeText = 'No',
  Color? buttonColor,
  Color? barrierColor,
  bool? barrierDismissible,
  Function? onAccept,
}) async {
  return showDialog(
    context: context,
    // barrierDismissible: barrierDismissible ?? false,
    builder: (_) => AlertDialog(
      title: Text(title.validate(), style: primaryTextStyle()),
      actions: <Widget>[
        SimpleDialogOption(
          child: Text(negativeText.validate(), style: secondaryTextStyle()),
          onPressed: () {
            finish(_, false);
          },
        ),
        SimpleDialogOption(
          onPressed: () {
            finish(_, true);

            onAccept?.call();
          },
          child: Text(
            positiveText.validate(),
            style: primaryTextStyle(color: buttonColor ?? Theme.of(_).primaryColor),
          ),
        ),
      ],
    ),
  );
}

/// show child widget in dialog
Future<T?> showInDialog<T>(
  BuildContext context, {
  Widget? title,
  Widget? Function(BuildContext)? builder,
  ShapeBorder? shape,
  TextStyle? titleTextStyle,
  EdgeInsetsGeometry? contentPadding,
  //bool scrollable = false,
  Color? backgroundColor,
  DialogAnimation dialogAnimation = DialogAnimation.DEFAULT,
  double? elevation,
  Color? barrierColor,
  //EdgeInsets insetPadding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  List<Widget>? actions,
  bool barrierDismissible = true,
  bool hideSoftKeyboard = true,
  Duration? transitionDuration,
  Curve curve = Curves.easeInBack,
}) async {
  if (hideSoftKeyboard) hideKeyboard(context);

  return await showGeneralDialog<T>(
    context: context,
    barrierColor: barrierColor ?? Colors.black54,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container();
    },
    barrierLabel: '',
    barrierDismissible: barrierDismissible,
    transitionDuration: transitionDuration ?? 400.milliseconds,
    transitionBuilder: (_, animation, secondaryAnimation, c) {
      return dialogAnimatedWrapperWidget(
        animation: animation,
        dialogAnimation: dialogAnimation,
        curve: curve,
        child: AlertDialog(
          content: builder != null ? builder.call(_) : null,
          shape: shape ?? defaultDialogShape,
          title: title,
          titleTextStyle: titleTextStyle,
          contentPadding: contentPadding ?? EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
          //scrollable: scrollable,
          backgroundColor: backgroundColor,
          elevation: elevation ?? defaultElevation.toDouble(),
          //insetPadding: insetPadding,
          actions: actions,
        ),
      );
    },
  );
}

/// Default AppBar
AppBar appBarWidget(String title,
    {Widget? titleWidget,
    List<Widget>? actions,
    Color? color,
    bool center = false,
    Color? textColor,
    int textSize = 18,
    double titleSpacing = 2,
    bool showBack = true,
    bool isBottom = true,
    Color? shadowColor,
    double? elevation,
    Widget? backWidget,
    SystemUiOverlayStyle? systemUiOverlayStyle,
    TextStyle? titleTextStyle,
    PreferredSizeWidget? bottom,
    Widget? flexibleSpace,
    required BuildContext context}) {
  return AppBar(
    centerTitle: center,
    title: titleWidget ??
        Text(
          title,
          style: titleTextStyle ?? (boldTextStyle(color: Colors.black, size: textSize)),
        ),
    actions: actions ?? [],
    automaticallyImplyLeading: showBack,
    backgroundColor: Colors.white,
    leading: showBack ? (backWidget ?? backIcon(context)) : null,
    shadowColor: shadowColor,
    elevation: elevation ?? defaultAppBarElevation,
    systemOverlayStyle: systemUiOverlayStyle ??
        SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
    bottom: bottom,
    titleSpacing: titleSpacing,
    flexibleSpace: flexibleSpace,
  );
}

Widget backIcon(
  BuildContext context,
) {
  return Icon(Octicons.chevron_left, color: primaryColor, size: 28).onTap(() {
    Navigator.pop(context);
  });
}

/// Handle error and loading widget when using FutureBuilder or StreamBuilder
Widget snapWidgetHelper<T>(
  AsyncSnapshot<T> snap, {
  Widget? errorWidget,
  Widget? loadingWidget,
  String? defaultErrorMessage,
  Widget Function(String)? errorBuilder,
}) {
  if (snap.hasError) {
    log(snap.error);
    if (errorBuilder != null) {
      return errorBuilder.call(defaultErrorMessage ?? snap.error.toString());
    }
    return errorWidget ??
        Text(
          defaultErrorMessage ?? snap.error.toString(),
          style: primaryTextStyle(),
        ).center();
  } else if (!snap.hasData) {
    return loadingWidget ?? Loader();
  } else {
    return SizedBox();
  }
}

/// Returns true is snapshot is loading
bool isSnapshotLoading(AsyncSnapshot snap, {bool checkHasData = false}) {
  return snap.connectionState == ConnectionState.active || snap.connectionState == ConnectionState.waiting;
}

backArrow(BuildContext context) {
  return Icon(
    Icons.arrow_back_ios_new,
    color: primaryColor,
  ).onTap(() {
    finish(context);
  });
}

class PriceWidget extends StatefulWidget {
  static String tag = '/PriceWidget';
  var price;
  double? size = 22.0;
  Color? color;
  TextStyle? textStyle;

  PriceWidget({Key? key, this.price, this.color, this.size, this.textStyle}) : super(key: key);

  @override
  PriceWidgetState createState() => PriceWidgetState();
}

class PriceWidgetState extends State<PriceWidget> {
  var currency = '₹';

  @override
  void initState() {
    super.initState();
    get();
  }

  get() async {
    setState(() {
      currency = getStringAsync(CurrencySymbol);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('$currency ${widget.price.toString().replaceAll(".00", "")}',
        style: widget.textStyle ?? GoogleFonts.inter(fontSize: widget.size, color: widget.color != null ? widget.color : primaryColor, fontWeight: FontWeight.w600));
  }
}

void openPhotoViewer(BuildContext context, ImageProvider imageProvider) {
  Scaffold(
    body: Stack(
      children: <Widget>[
        PhotoView(
          imageProvider: imageProvider,
          minScale: PhotoViewComputedScale.contained,
          maxScale: 1.0,
        ),
        Positioned(top: 35, left: 16, child: BackButton(color: Colors.white)),
      ],
    ),
  ).launch(context);
}
