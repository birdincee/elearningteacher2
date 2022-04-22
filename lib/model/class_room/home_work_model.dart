import 'dart:typed_data';

class HomeWorkModel {
  final String sUID; // id ของการบ้าน
  final String sNameTitle; // ชื่อการบ้าน
  final Uint8List sSimpleHomeWork; // ตัวอย่างการบ้านของครู
  final String sDateCreate;
  final String sDateFinal;
  final Map<String, dynamic> homeworkStudent; // การบ้านนักเรียน

  HomeWorkModel({
    required this.sUID,
    required this.sNameTitle,
    required this.sSimpleHomeWork,
    required this.homeworkStudent,
    required this.sDateCreate,
    required this.sDateFinal,
  });
}
