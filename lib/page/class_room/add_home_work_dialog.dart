import 'dart:io';

import 'package:elearningteacher2/cost/var_ui.dart';
import 'package:elearningteacher2/provider/class_room/add_home_work_provider.dart';
import 'package:elearningteacher2/utility/buttons.dart';
import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:elearningteacher2/utility/text_fied.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddHomeWork extends StatelessWidget {
  final String sUIDDoc;
  const AddHomeWork({
    Key? key,
    required this.sUIDDoc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AddHomeWorkProvider(
            sUIDDoc: sUIDDoc,
            context: context,
          ),
        ),
      ],
      builder: (context, _) {
        return Consumer<AddHomeWorkProvider>(
          builder: (context, prov, _) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              titlePadding: const EdgeInsets.all(10),
              contentPadding: const EdgeInsets.all(5),
              title: Text(
                "เพิ่มการบ้าน",
                style: FontThai.text18BlackBold,
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                width: MediaQuery.of(prov.context).size.width,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFields.textFieldEdit(
                        controller: prov.textTitle,
                        hint: 'ชื่อการบ้าน'
                      ),
                      pickFile(prov),
                    ],
                  ),
                ),
              ),
              actions: [
                _btnUpload(prov),
                Buttons.btnTextClose(
                  onPressed: ()=>prov.close(),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget pickFile(AddHomeWorkProvider prov){
    if(prov.files.isEmpty){
      return _buttonAddFile(prov);
    }else{
      return Column(
        children: [
          _buttonAddFile(prov),
          SizedBox(
            width: double.infinity,
            height: 100,
            child: Scrollbar(
              controller: prov.scrollList,
              child: ListView.builder(
                itemCount: prov.files.length,
                shrinkWrap: true,
                controller: prov.scrollList,
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(vertical: 5),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_,int index){
                  return _item(
                    file: prov.files[index],
                    index: index,
                    prov: prov,
                  );
                },
              ),
            ),
          ),
        ],
      );
    }
  }

  Widget _buttonAddFile(AddHomeWorkProvider prov){
    var formatDate = DateFormat("dd/MM/yyyy");
    String date = formatDate.format(prov.dateFinal);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                flex: 2,
                child: ElevatedButton(
                  onPressed: ()=> prov.pickFile(),
                  child: Text(
                    'เลือกไฟล์',
                    style: FontThai.text16BlackBold,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Text('วันที่ส่งงาน',
                  style: FontThai.text14BlackNormal,
                  textAlign: TextAlign.end,
                ),
              ),
              Expanded(
                flex: 2,
                child: TextButton.icon(
                    onPressed: ()=>prov.dataPicker(),
                    icon: const Icon(Icons.calendar_today),
                    label: Text(date,
                      style: FontThai.text14BlackNormal,
                    ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item({
    required PlatformFile file,
    required int index,
    required AddHomeWorkProvider prov,
  }){
    int i = index;
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 2,vertical: 2),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.amber.shade200,
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: ()=> prov.selectItem(
            index: index,
          ),
          child: Column(
            children: [
              Expanded(
                child: Text(
                  file.name,
                  style: FontThai.text14BlackNormal,
                  overflow: TextOverflow.fade,
                  softWrap: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnUpload(AddHomeWorkProvider prov){
    return ElevatedButton.icon(
      onPressed: ()=>prov.onUploadData(),
      icon: const Icon(Icons.cloud_upload),
      label: const Text('เพิ่มการบ้าน'),
    );
  }

}
