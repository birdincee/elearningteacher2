import 'package:elearningteacher2/model/class_room/class_room_model.dart';
import 'package:elearningteacher2/provider/class_room/class_room_provider.dart';
import 'package:flutter/material.dart';

class ClassFormProvider extends ClassRoomProvider{
  final BuildContext context;
  final String sUIDDoc;
  final ClassRoomModel md;

  ClassFormProvider({
    required this.context,
    required this.sUIDDoc,
    required this.md,
  }){
    init();
  }

  init()async{

  }
}