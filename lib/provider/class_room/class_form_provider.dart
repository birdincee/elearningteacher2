import 'dart:collection';

import 'package:elearningteacher2/model/class_room/class_room_model.dart';
import 'package:elearningteacher2/model/class_room/home_work_model.dart';
import 'package:elearningteacher2/page/class_room/add_home_work_dialog.dart';
import 'package:elearningteacher2/provider/class_room/class_room_provider.dart';
import 'package:elearningteacher2/utility/snack_msg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class ClassFormProvider extends ClassRoomProvider {
  final BuildContext context;
  final String sUIDDoc;
  ClassRoomModel md;

  ClassFormProvider({
    required this.context,
    required this.sUIDDoc,
    required this.md,
  }) {
    init();
  }

  bool bFirst = true;
  List<HomeWorkModel> listHw = [];

  TextEditingController textDes = TextEditingController();
  late ScrollController scrollList;

  init() async {
    if (bFirst) {
      scrollList = ScrollController(initialScrollOffset: 0);
      textDes.text = md.sDes;
      await checkHomeWork(md.listHomeWork);
      bFirst = false;
      notifyListeners();
    }
  }

  Future<void> checkHomeWork(List<dynamic> list) async {
    if (list.isNotEmpty) {
      for (var mData in list) {
        Map<String, dynamic> map = HashMap.from(mData);
        HomeWorkModel model = HomeWorkModel();
        model.formJson(json: map);
        if (model.sUID.isEmpty) {
          continue;
        } else {
          listHw.add(model);
        }
      }
    }
    print(listHw.length);
  }

  void onSubmitEditDes(String val)async{
    if(textDes.text.isNotEmpty){
      String sDes = textDes.text.trim();
      await upDateDes(sUIDDoc: sUIDDoc, sDes: sDes);
    }
    print('Complete ${textDes.text}');
  }

  void addHomework()async{
    var bResult = await showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AddHomeWork(sUIDDoc: sUIDDoc,);
        },
      animationType: DialogTransitionType.scale,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
    );
    if (bResult == true) {
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarMsg.snackBarMsg(sText: "สร้างการบ้านสำเร็จ"),
      );
      await reQueryData();
    }
  }

  reQueryData() async {
    md = (await getByID(sUIDDoc: sUIDDoc))!;
    listHw.clear();
    checkHomeWork(md.listHomeWork);
    notifyListeners();
  }
}
