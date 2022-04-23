import 'package:elearningteacher2/model/class_room/class_room_model.dart';
import 'package:elearningteacher2/provider/class_room/class_form_provider.dart';
import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassRoomFormPage extends StatelessWidget {
  final String sUIDDoc;
  final ClassRoomModel md;
  const ClassRoomFormPage({Key? key, required this.sUIDDoc, required this.md})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ClassFormProvider(
            context: context,
            sUIDDoc: sUIDDoc,
            md: md,
          ),
        ),
      ],
      builder: (context, _) {
        return Consumer<ClassFormProvider>(
          builder: (context, prov, _) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  prov.md.sName,
                  style: FontThai.text18WhiteNormal,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
