import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearningteacher2/cost/field.dart';
import 'package:elearningteacher2/model/class_room/class_room_model.dart';
import 'package:elearningteacher2/model/model_user.dart';
import 'package:elearningteacher2/page/account_edit_page.dart';
import 'package:elearningteacher2/page/class_room/class_room_form_page.dart';
import 'package:elearningteacher2/provider/account/account_head_provider.dart';
import 'package:elearningteacher2/provider/class_room/class_room_provider.dart';
import 'package:elearningteacher2/utility/dialog_create.dart';
import 'package:elearningteacher2/utility/dialog_msg.dart';
import 'package:elearningteacher2/utility/dialog_wait.dart';
import 'package:elearningteacher2/utility/snack_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:page_transition/page_transition.dart';

class HomeProvider extends ClassRoomProvider {
  final BuildContext context;
  final String sUID;

  HomeProvider({
    required this.context,
    required this.sUID,
  });

  late ModelUser? modelUser;
  bool bFirst = true;

  Stream<QuerySnapshot<ClassRoomModel>> get getData => classRoomRef
      .where(FieldMaster.sClassUIDTeach, isEqualTo: sUID)
      .orderBy(FieldMaster.sClassDateCreate)
      .snapshots();

  Future<void> closeApp() async {
    SystemNavigator.pop();
  }

  TextEditingController textTitleName = TextEditingController();

  void goToEditUser() async {
    await Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          curve: Curves.fastOutSlowIn,
          child: AccountEditPage(
            sUID: sUID,
          ),
        ));
  }

  onPressedOpenCreate({
    required AccountProvider account,
  }) {
    return showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return DialogCreateUI.dialog(
          controller: textTitleName,
          onChanged: (String? value) {
            textTitleName.text = value!;
            notifyListeners();
          },
          close: () => Navigator.pop(context),
          crate: () => createClassRoom(
            account: account,
          ),
        );
      },
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
    );
  }

  void createClassRoom({
    required AccountProvider account,
  }) async {
    DialogWait(context: context).showDialog();
    if (textTitleName.text.isEmpty) {
      await DialogWait(context: context).close();
      await DialogMsg(context: context)
          .showDialog(sMsg: "กรุณาระบุรหัสเข้าร่วม");
    } else {
      modelUser = await account.getByUID(sUID);
      if (modelUser!.sType == 0) {
        await crateClass(
          modelUser: modelUser!,
          context: context,
          sNameTitle: textTitleName.text.trim(),
        );
      }
    }
  }

  copyUidToClipBord({required String sUidDoc}) async {
    await FlutterClipboard.copy(sUidDoc).then((value) async {
      print('copied');
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarMsg.snackBarMsgSignIN(sText: "Copied สำเร็จ"),
      );
    });
  }

  onTapGotoClass(ClassRoomModel md) async {
    await Navigator.push(context, PageTransition(
      type: PageTransitionType.fade,
      curve: Curves.fastOutSlowIn,
      child: ClassRoomFormPage(
        sUIDDoc: md.sUID, md: md,),
    ));
  }
}
