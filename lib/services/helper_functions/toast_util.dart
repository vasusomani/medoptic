import 'package:fluttertoast/fluttertoast.dart';

import '../../../Constants/colors.dart';

class ToastWidget {
  static void bottomToast(String msg) async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: CustomColors.toastColor,
      textColor: CustomColors.fontColor2,
      timeInSecForIosWeb: 3,
      fontSize: 14.0,
    );
  }
}
