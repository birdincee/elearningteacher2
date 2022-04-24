import 'package:elearningteacher2/cost/field.dart';
import 'package:elearningteacher2/model/class_room/home_work_model.dart';

class ClassRoomModel {
  final String sUID;
  final String sName;
  final String sDes;
  final String sUIDTeach;
  final List<dynamic> sUIDStudent;
  final String sDateCreate;
  final List<dynamic> listHomeWork;

  ClassRoomModel({
    required this.sUID,
    required this.sName,
    required this.sDes,
    required this.sUIDTeach,
    required this.sUIDStudent,
    required this.sDateCreate,
    required this.listHomeWork,
  });

  factory ClassRoomModel.formJson({required Map<String, Object?> json}) =>
      ClassRoomModel(
        sUID: json[FieldMaster.sClassUID] as String,
        sName: json[FieldMaster.sClassName] as String,
        sDes: json[FieldMaster.sClassDes] as String,
        sDateCreate: json[FieldMaster.sClassDateCreate] as String,
        sUIDTeach: json[FieldMaster.sClassUIDTeach] as String,
        sUIDStudent: json[FieldMaster.sClassUIDStudent] as List<dynamic>,
        listHomeWork: json[FieldMaster.sClassHomeWork] as List<dynamic>,
      );

  Map<String, Object?> toJson() {
    return {
      FieldMaster.sClassUID: sUID,
      FieldMaster.sClassName: sName,
      FieldMaster.sClassDes: sDes,
      FieldMaster.sClassDateCreate: sDateCreate,
      FieldMaster.sClassUIDTeach: sUIDTeach,
      FieldMaster.sClassUIDStudent: sUIDStudent,
      FieldMaster.sClassHomeWork: listHomeWork,
    };
  }
}
