import 'package:elearningteacher2/page/home_page.dart';
import 'package:elearningteacher2/page/sign_in_sign_up/sign_in_page.dart';
import 'package:elearningteacher2/page/sign_in_sign_up/sign_up_page.dart';
import 'package:elearningteacher2/utility/dialog_wait.dart';
import 'package:elearningteacher2/utility/snack_msg.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Auth with ChangeNotifier {
  final BuildContext context;

  Auth({
    required this.context,
  });

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  void gotoRegis() async {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: const SignUpPage(),
        ));
  }

  Future<String> register({
    required String sEmail,
    required String sPassword,
  }) async {
    String sUID = "";
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: sEmail,
        password: sPassword,
      );
      sUID = userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        String sMsg = "The password provided is too weak.";
        removeSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarMsg.snackBarMsgSignIN(sText: sMsg),
        );
      } else if (e.code == 'email-already-in-use') {
        String sMsg = "The account already exists for that email.";
        removeSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarMsg.snackBarMsgSignIN(sText: sMsg),
        );
      }
    } catch (e) {
      print(e);
    }
    return sUID;
  }

  Future<bool> validate() async {
    String msg = "";
    bool result = true;
    if (txtEmail.text.isEmpty) {
      String sMsg = "กรุณาระบุ Email เพื่อเข้าใช้งาน";
      msg = sMsg;
    } else {
      bool result = EmailValidator.validate(txtEmail.text.trim());
      if (!result) {
        String sMsg = "กรุณาระบุ รูปแบบ Email ให้ถูกต้อง";
        msg = sMsg;
      }
    }
    if (txtPassword.text.isEmpty) {
      String sMsg = "กรุณาระบุ Password เพื่อเข้าใช้งาน";
      msg = sMsg;
    } else {
      if (txtPassword.text.length < 6) {
        String sMsg = "กรุณาระบุ Password ความยาว 6 ตัวขึ้นไป";
        msg = sMsg;
      }
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

  void onClickSignIn() async {
    bool result = await validate();
    if (!result) {
      DialogWait(context: context).showDialog();
      String sUID = await signIn();
      if (sUID.isNotEmpty) {
        await DialogWait(context: context).close();
        Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: HomePage(sUID: sUID),
            ),
            (route) => false);
      }
    }
  }

  Future<String> signIn() async {
    String sUID = "";
    try {
      String sEmail = txtEmail.text.trim();
      String sPassword = txtPassword.text.trim();
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: sEmail,
        password: sPassword,
      );
      sUID = userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        String sMsg = "ไม่มี Email นี้ในระบบ";
        removeSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarMsg.snackBarMsgSignIN(sText: sMsg),
        );
      } else if (e.code == 'wrong-password') {
        String sMsg = "รหัสผ่านไม่ถูกต้อง";
        removeSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBarMsg.snackBarMsgSignIN(sText: sMsg),
        );
      }
    }
    return sUID;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut().then((value) {
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: const SignInPage(),
          ),
          (route) => false);
    });
  }

  void removeSnackBar() {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }

  @override
  void dispose() {
    txtEmail.dispose();
    txtPassword.dispose();
    super.dispose();
  }
}
