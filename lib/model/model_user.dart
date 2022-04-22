import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearningteacher2/cost/field.dart';
import 'package:flutter/foundation.dart';

class ModelUser with DiagnosticableTreeMixin {
  ModelUser({
    required this.sUID,
    required this.sName,
    required this.sEmail,
    required this.sPhotoBase64,
    required this.sDateRegister,
    required this.sGCMToken,
    required this.sTeacherDoc,
    required this.sTeacherCreateRoom,
    required this.sType,
  });

  final String sUID;
  final String sName;
  final String sEmail;
  final String sPhotoBase64;
  final String sDateRegister;
  final String sGCMToken;
  final String sTeacherDoc;
  final String sTeacherCreateRoom;
  final int sType;

  factory ModelUser.formJson({required Map<String, Object?> json}) => ModelUser(
        sUID: json[FieldMaster.teacherUID] as String,
        sName: json[FieldMaster.teacherFullName] as String,
        sEmail: json[FieldMaster.teacherEmail] as String,
        sPhotoBase64: json[FieldMaster.teacherPhoto] as String,
        sDateRegister: json[FieldMaster.teacherDateRegister] as String,
        sGCMToken: json[FieldMaster.fieldUserGCM] as String,
        sTeacherDoc: json[FieldMaster.document] as String,
        sTeacherCreateRoom: json[FieldMaster.room] as String,
        sType: json[FieldMaster.type] as int,
      );

  Map<String, Object?> toJson() {
    return {
      FieldMaster.teacherUID: sUID,
      FieldMaster.teacherFullName: sName,
      FieldMaster.teacherEmail: sEmail,
      FieldMaster.teacherPhoto: sPhotoBase64,
      FieldMaster.teacherDateRegister: sDateRegister,
      FieldMaster.fieldUserGCM: sGCMToken,
      FieldMaster.document: sTeacherDoc,
      FieldMaster.room: sTeacherCreateRoom,
      FieldMaster.type: sType,
    };
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('sUID', sUID));
    properties.add(StringProperty('sName', sName));
    properties.add(StringProperty('sEmail', sEmail));
    properties.add(StringProperty('sPhotoBase64', sPhotoBase64));
    properties.add(StringProperty('sTeacherDoc', sTeacherDoc));
  }
}
