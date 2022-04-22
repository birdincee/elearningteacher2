import 'dart:convert';
import 'dart:typed_data';

import 'package:elearningteacher2/model/model_user.dart';
import 'package:elearningteacher2/page/home_page.dart';
import 'package:elearningteacher2/provider/account/account_head_provider.dart';
import 'package:elearningteacher2/provider/auth_provider.dart';
import 'package:elearningteacher2/utility/dialog_wait.dart';
import 'package:elearningteacher2/utility/snack_msg.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class AccountRegister extends AccountProvider {
  final BuildContext context;

  AccountRegister({
    required this.context,
  });

  Future<bool> validate() async {
    String msg = "";
    bool result = true;
    if (txtEmail.text.isEmpty) {
      String sMsg = "กรุณาระบุ Email";
      msg = sMsg;
    } else {
      bool result = EmailValidator.validate(txtEmail.text.trim());
      if (!result) {
        String sMsg = "กรุณาระบุ รูปแบบ Email ให้ถูกต้อง";
        msg = sMsg;
      }
    }
    if (txtPassword.text.isEmpty) {
      String sMsg = "กรุณาระบุ รหัสผ่าน";
      msg = sMsg;
    } else {
      if (txtPassword.text.length < 6) {
        String sMsg = "Password ความยาว 6 ตัวขึ้นไป";
        msg = sMsg;
      }
    }
    if (txtPhone.text.isEmpty) {
      String sMsg = "กรุณาระบุ เบอร์โทรศัพท์";
      msg = sMsg;
    } else {
      if (txtPhone.text.length < 10) {
        String sMsg = "กรุณา ระบุ เบอร์โทรศัพท์ ให้ครบ 10 หลัก";
        msg = sMsg;
      }
    }
    if (txtDisplay.text.isEmpty) {
      String sMsg = "กรุณาระบุ ชื่อที่ใช้แสดง";
      msg = sMsg;
    }
    if (msg.isNotEmpty) {
      print(msg);
      removeSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarMsg.snackBarMsgSignIN(sText: msg),
      );
    } else {
      removeSnackBar();
      result = false;
    }
    return result;
  }

  void onClickSigUp({
    required Auth auth,
  }) async {
    // await getLocation();
    bool result = await validate();
    if (!result) {
      DialogWait(context: context).showDialog();
      String sEmail = txtEmail.text.trim();
      String sPassword = txtPassword.text.trim();
      String sUID = await auth.register(
        sEmail: sEmail,
        sPassword: sPassword,
      );
      await DialogWait(context: context).close();
      if (sUID.isNotEmpty) {
        final ByteData bytes =
            await rootBundle.load('assets/images/logolearning.jpg');
        final Uint8List list = bytes.buffer.asUint8List();
        String sImageBase64 = base64Encode(list);
        DateTime dateTime = DateTime.now();
        ModelUser md = ModelUser(
          sUID: sUID,
          sName: txtDisplay.text.trim(),
          sEmail: sEmail,
          sPhotoBase64: sImageBase64,
          sTeacherDoc: '',
          sTeacherCreateRoom: teacherCreateRoom.text,
          sDateRegister: dateTime.toIso8601String(),
          sType: 0,
          sGCMToken: "",
        );
        int iResult = await createUser(sUID: sUID, model: md);
        if (iResult == 1) {
          ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
          Navigator.pushAndRemoveUntil(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                child: HomePage(
                  sUID: sUID,
                ),
              ),
              (route) => false);
        }
      }
    }
  }

  void removeSnackBar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  @override
  void dispose() {
    txtEmail.dispose();
    txtPassword.dispose();
    txtDisplay.dispose();
    txtPhone.dispose();
    super.dispose();
  }
}
