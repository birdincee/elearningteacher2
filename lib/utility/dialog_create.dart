import 'package:elearningteacher2/cost/var_ui.dart';
import 'package:elearningteacher2/utility/buttons.dart';
import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:elearningteacher2/utility/text_fied.dart';
import 'package:flutter/material.dart';

class DialogCreateUI {
  static AlertDialog dialog({
    required TextEditingController controller,
    Function(String)? onChanged,
    VoidCallback? close,
    VoidCallback? crate,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        "ชื่อวิชา",
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
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextFields.textFieldCreate(
                      controller: controller,
                      onChanged: onChanged,
                      hint: "",
                    ),
                  ),
                ),
              ],
            ),
            VarUI.h10,
          ],
        ),
      ),
      actions: [
        Buttons.btnTextClose(onPressed: close!),
        Buttons.btnConfirm(
          onPressed: crate!,
        ),
      ],
    );
  }

  static AlertDialog cancelDialog({
    VoidCallback? close,
    VoidCallback? cancel,
  }) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      title: Text(
        "คุณต้องการยกเลิกการติดตาม",
        style: FontThai.text16BlackNormal,
        textAlign: TextAlign.center,
      ),
      titlePadding: const EdgeInsets.all(10),
      actions: [
        Buttons.btnTextClose(onPressed: close!),
        // Buttons.btnConfirmCancelJoin(onPressed: cancel!),
      ],
    );
  }
}
