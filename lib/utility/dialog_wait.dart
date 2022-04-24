import 'package:elearningteacher2/cost/var_ui.dart';
import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DialogWait {
  final BuildContext context;

  DialogWait({required this.context});

  Future<dynamic> showDialog() async {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            "กรุณารอสักครู่",
            style: FontThai.text16BlackNormal,
            textAlign: TextAlign.center,
          ),
          titlePadding: const EdgeInsets.all(10),
          contentPadding: const EdgeInsets.all(10),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                VarUI.h10,
                CircularProgressIndicator(
                  color: Colors.deepOrange,
                  backgroundColor: Colors.orange.shade300,
                ),
                VarUI.h10,
              ],
            ),
          ),
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
