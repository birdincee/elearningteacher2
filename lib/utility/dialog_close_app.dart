import 'package:elearningteacher2/utility/buttons.dart';
import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DialogCloseApp {
  static dialog({
    required BuildContext context,
    VoidCallback? close,
    VoidCallback? exit,
  }) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          titlePadding: const EdgeInsets.all(10),
          title: Text(
            "คุณต้องการออกจากแอพพลิเคชั่น",
            style: FontThai.text16BlackNormal,
            textAlign: TextAlign.center,
          ),
          actions: [
            Buttons.btnTextClose(onPressed: close!),
            Buttons.btnExitApps(onPressed: exit!),
          ],
        );
      },
    );
  }
}
