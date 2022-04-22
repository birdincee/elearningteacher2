import 'package:elearningteacher2/cost/var_ui.dart';
import 'package:elearningteacher2/utility/buttons.dart';
import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DialogMsg {
  final BuildContext context;

  DialogMsg({required this.context});

  Future<dynamic> showDialog({required String sMsg}) async {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            "ข้อความจากระบบ",
            style: FontThai.text16BlackNormal,
            textAlign: TextAlign.center,
          ),
          titlePadding: const EdgeInsets.all(10),
          contentPadding: const EdgeInsets.all(10),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VarUI.h10,
                Text(
                  sMsg,
                  style: FontThai.text14RedNormal,
                ),
                VarUI.h10,
              ],
            ),
          ),
          actions: [
            Buttons.btnTextClose(onPressed: () => close()),
          ],
        );
      },
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
    );
  }

  Future<void> close() async {
    Navigator.pop(context);
  }
}
