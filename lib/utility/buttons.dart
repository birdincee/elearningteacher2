import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:flutter/material.dart';

class Buttons {
  static Widget btnSignIN({
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        "SignIN",
        style: FontThai.text16WhiteNormal,
      ),
    );
  }

  static Widget btnSignUP2({
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        "สมัครบัญชีผู้ใช้งาน",
        style: FontThai.text16WhiteNormal,
      ),
    );
  }

  static Widget btnSignUP({
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        "สร้างบัญชีผู้ใช้ใหม่",
        style: FontThai.text14DeepOrangeNormal,
      ),
    );
  }

  static Widget btnTextClose({
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        "ปิด",
        style: FontThai.text14GrayNormal,
      ),
    );
  }

  static Widget btnConfirm({
    required VoidCallback onPressed,
  }) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        "ตกลง",
        style: FontThai.text14GreenNormal,
      ),
    );
    // return ElevatedButton(
    //   onPressed: onPressed,
    //   style: ElevatedButton.styleFrom(
    //     primary: Colors.green,
    //   ),
    //   child: Text(
    //     "ตกลง",
    //     style: FontThai.text16WhiteNormal,
    //   ),
    // );
  }

  static Widget btnExitApps({
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        "ออก",
        style: FontThai.text16WhiteNormal,
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
      ),
    );
  }

  static Widget btnTextCreateShare({
    required VoidCallback onPressed,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      label: Text(
        "เพิ่มการแชร์",
        style: FontThai.text16PinkNormal,
      ),
      icon: const Icon(Icons.add),
    );
  }

  static Widget iconCopy({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 28,
      alignment: Alignment.center,
      iconSize: 26,
      tooltip: "copied",
      padding: const EdgeInsets.all(5),
      icon: const Icon(
        Icons.copy,
        color: Colors.pink,
      ),
    );
  }

  static Widget iconUpdate({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 28,
      alignment: Alignment.center,
      iconSize: 26,
      padding: const EdgeInsets.all(5),
      icon: const Icon(
        Icons.cloud_upload,
        color: Colors.green,
      ),
    );
  }

  static Widget iconDelete({required VoidCallback onPressed}) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 28,
      alignment: Alignment.center,
      iconSize: 26,
      padding: const EdgeInsets.all(5),
      icon: const Icon(
        Icons.delete,
        color: Colors.red,
      ),
    );
  }

  static Widget btnSave({
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        "บันทึก",
        style: FontThai.text16WhiteNormal,
      ),
    );
  }
}
