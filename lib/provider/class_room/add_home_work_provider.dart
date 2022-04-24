
import 'package:elearningteacher2/cost/field.dart';
import 'package:elearningteacher2/model/class_room/home_work_model.dart';
import 'package:elearningteacher2/provider/class_room/class_room_provider.dart';
import 'package:elearningteacher2/utility/snack_msg.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class AddHomeWorkProvider extends ClassRoomProvider{
  final BuildContext context;
  final String sUIDDoc;
  AddHomeWorkProvider({
    required this.context,
    required this.sUIDDoc,
  }){
    init();
  }

  List<PlatformFile> files = [];

  late ScrollController scrollList;
  TextEditingController textTitle = TextEditingController();

  DateTime dateFinal = DateTime.now();


  init()async{
    scrollList = ScrollController(initialScrollOffset: 0);
  }

  void pickFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['svg','png','doc','jpg','pdf'],
    );
    if (result != null) {
      files.clear();
      files = result.files;
    } else {
      // User canceled the picker
    }
    print(files.length);
    await FilePicker.platform.clearTemporaryFiles();
    notifyListeners();
  }

  String deletePathName(String sVal){
    String result = '';
    result = sVal.replaceAll('/', '')
        .replaceAll('data', '')
        .replaceAll('user', '')
        .replaceAll('0', '')
        .replaceAll('com.atswin.elearningteacher2', '')
        .replaceAll('cache', '')
        .replaceAll('file_picker', '');
    return result;
  }

  Future<void> selectItem({
    required int index,
  }) async {
    int result = await showChoiceFile();
    if(result == 0){
      files.removeAt(index);
      notifyListeners();
    }
    print(files.length);
  }

  showChoiceFile() async {
    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text("ลบไฟล์"),
              onTap: () => Navigator.of(context).pop(0),
            ),
          ],
        );
      },
    );
  }
  
  dataPicker()async{
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dateFinal,
      firstDate: DateTime(dateFinal.year - 1),
      lastDate: DateTime(dateFinal.year + 6),
    );
    if(pickedDate != null){
      dateFinal = pickedDate;
      notifyListeners();
    }
  }
  
  onUploadData()async{
    if(textTitle.text.isEmpty){
      ScaffoldMessenger.of(context).removeCurrentMaterialBanner();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBarMsg.snackBarMsg(sText: "โปรดระบุชื่อการบ้าน"),
      );
    }else{
      HomeWorkModel model = HomeWorkModel();
      String sUID = const Uuid().v4();
      model.sUID = sUID;
      model.listSimpleHW = await genDataFormInput();
      model.sNameTitle = textTitle.text.trim();
      DateTime dateTime = DateTime.now();
      model.sDateCreate = dateTime.toIso8601String();
      model.sDateFinal = dateFinal.toIso8601String();
      await createHomeWork(sUIDDoc: sUIDDoc, model: model);
      Navigator.pop(context,true);
    }
  }

  Future<List<Map<String, dynamic>>> genDataFormInput() async {
    List<Map<String,dynamic>> listSimpleHw = [];
    if(files.isNotEmpty){
      for(var hw in files){
        Map<String,dynamic> mData = {};
        mData[FieldMaster.sFileName] = hw.name;
        mData[FieldMaster.sFileByte] = hw.bytes;
        mData[FieldMaster.sFilePath] = hw.path;
        listSimpleHw.add(mData);
      }
    }
    return listSimpleHw;
  }

  close()async{
    Navigator.pop(context,false);
  }
}