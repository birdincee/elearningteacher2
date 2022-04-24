import 'dart:collection';
import 'dart:typed_data';

import 'package:elearningteacher2/cost/field.dart';

class HomeWorkModel {
  String sUID = ''; // id ของการบ้าน
  String sNameTitle = ''; // ชื่อการบ้าน
  List<Map<String,dynamic>> listSimpleHW = []; // ตัวอย่างการบ้านของครู
  String sDateCreate = '';
  String sDateFinal = '';
  List<Map<String,dynamic>> listStudentHw = []; // การบ้านนักเรียน

  formJson({required Map<String, dynamic> json})async{
    sUID = json[FieldMaster.sHWUID] ?? '';
    sNameTitle = json[FieldMaster.sHWName] ?? '';
    sDateCreate = json[FieldMaster.sHWDateCrate] ?? '';
    sDateFinal = json[FieldMaster.sHWDateFinal] ?? '';
    dynamic tempSimpleHw = json[FieldMaster.sHWSimpleHw];
    if (tempSimpleHw != null) {
      for (var simple in tempSimpleHw) {
        listSimpleHW.add(HashMap.from(simple));
      }
    }
    dynamic tempStudentHw = json[FieldMaster.sHWStudent];
    if (tempStudentHw != null) {
      for (var student in tempStudentHw) {
        listStudentHw.add(HashMap.from(student));
      }
    }
  }

  Map<String,dynamic> toJson() {
    Map<String,dynamic> data = {};
    data[FieldMaster.sHWUID] = sUID;
    data[FieldMaster.sHWName] = sNameTitle;
    data[FieldMaster.sHWSimpleHw] = listSimpleHW;
    data[FieldMaster.sHWDateCrate] = sDateCreate;
    data[FieldMaster.sHWDateFinal] = sDateFinal;
    data[FieldMaster.sHWStudent] = listStudentHw;
    return data;
  }
}
