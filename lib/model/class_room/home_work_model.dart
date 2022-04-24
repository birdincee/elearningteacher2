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
    listSimpleHW = json[FieldMaster.sHWSimpleHw] ?? [];
    sDateCreate = json[FieldMaster.sHWDateCrate] ?? '';
    sDateFinal = json[FieldMaster.sHWDateFinal] ?? '';
    listStudentHw = json[FieldMaster.sHWStudent] ?? [];
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
