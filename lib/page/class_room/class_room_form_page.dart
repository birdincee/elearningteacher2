import 'package:elearningteacher2/cost/var_ui.dart';
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
            if(prov.bFirst){
              return Scaffold(
                backgroundColor: Colors.grey.shade200,
                body: Center(
                  child:CircularProgressIndicator(
                    color: Colors.deepOrange,
                    backgroundColor: Colors.orange.shade300,
                  ),
                ),
              );
            }else{
              return Scaffold(
                backgroundColor: Colors.grey.shade200,
                appBar: AppBar(
                  title: Text(
                    prov.md.sName,
                    style: FontThai.text18WhiteNormal,
                  ),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _description(prov),
                    _homework(prov),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }

  Widget _description(ClassFormProvider prov){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5),
      margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
      decoration: BoxDecoration(
        color: Colors.orange.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child:Text('คำอธิบายรายวิชา',
                    style: FontThai.text18BlackBold,),
                ),
              ],
            ),
          ),
          VarUI.h10,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: prov.textDes,
                    style: FontThai.text16BlackBold,
                    enabled: true,
                    maxLines: 4,
                    onSubmitted: (val)=> prov.onSubmitEditDes(val),
                    decoration: const InputDecoration(
                      isDense: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      hintText: '(แตะ)เพิ่มคำอธิบายรายวิชา',
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          VarUI.h10,
        ],
      ),
    );
  }

  Widget _homework(ClassFormProvider prov){
    if(prov.listHw.isEmpty){
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 5,horizontal: 3),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _buttonAddHw(prov),
            VarUI.h10,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
              child: Text('ยังไม่มีการบ้านในขณะนี้',
                style: FontThai.text16BlackBold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            VarUI.h10,
          ],
        ),
      );
    }else{
      return Container();
    }
  }

  Widget _buttonAddHw(ClassFormProvider prov){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: ()=> prov.addHomework(),
            child: Text(
              'เพิ่มการบ้าน',
              style: FontThai.text16BlackBold,
            ),
          ),
        ],
      ),
    );
  }
}
