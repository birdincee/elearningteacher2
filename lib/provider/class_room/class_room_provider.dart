import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearningteacher2/model/class_room/class_room_model.dart';
import 'package:elearningteacher2/model/model_user.dart';
import 'package:elearningteacher2/utility/dialog_wait.dart';
import 'package:elearningteacher2/utility/snack_msg.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ClassRoomProvider with ChangeNotifier {
  final CollectionReference classRoom =
      FirebaseFirestore.instance.collection('classroom');

  final classRoomRef = FirebaseFirestore.instance
      .collection('classroom')
      .withConverter<ClassRoomModel>(
        fromFirestore: (snapshot, _) =>
            ClassRoomModel.formJson(json: snapshot.data()!),
        toFirestore: (child, _) => child.toJson(),
      );

  Future<void> crateClass({
    required ModelUser modelUser,
    required String sNameTitle,
    required BuildContext context,
  }) async {
    DateTime dateTime = DateTime.now();
    String sUIDDoc = const Uuid().v4();
    List<dynamic> listUidStudent = [];
    ClassRoomModel model = ClassRoomModel(
      sUID: sUIDDoc,
      sName: sNameTitle,
      sUIDTeach: modelUser.sUID,
      sUIDStudent: listUidStudent,
      sDateCreate: dateTime.toIso8601String(),
      listHomeWork: [],
    );
    await classRoomRef.doc(sUIDDoc).set(model).then((value) async {
      print("Crate ClassRoom Success");
      await DialogWait(context: context).close();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarMsg.snackBarMsgSignIN(sText: "สร้างรหัสการแชร์สำเร็จ"),
      );
    });
  }
}
