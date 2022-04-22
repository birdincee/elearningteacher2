import 'dart:convert';
import 'dart:typed_data';

import 'package:elearningteacher2/cost/field.dart';
import 'package:elearningteacher2/model/model_user.dart';
import 'package:elearningteacher2/provider/account/account_head_provider.dart';
import 'package:elearningteacher2/utility/dialog_wait.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AccountEditProvider extends AccountProvider {
  final BuildContext context;
  final String sUID;

  AccountEditProvider({
    required this.context,
    required this.sUID,
  }) {
    init();
  }

  bool bFirst = true;

  FocusNode focusName = FocusNode();
  FocusNode focusPhone = FocusNode();

  String sImageBase64 = "";
  late ModelUser? md;
  late ScrollController scrollController;

  init() async {
    scrollController = ScrollController(initialScrollOffset: 0);
    await setDataEdit();
    bFirst = false;
    notifyListeners();
  }

  Future<void> setDataEdit() async {
    md = await getByUID(sUID);
    txtDisplay.text = md!.sName;
    // txtPhone.text = md!.sPhoneNumber;
    await onCreateFocusNode(controller: txtDisplay, focusNode: focusName);
    await onCreateFocusNode(controller: txtPhone, focusNode: focusPhone);
  }

  onCreateFocusNode({
    required TextEditingController controller,
    required FocusNode focusNode,
  }) {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        controller.selection =
            TextSelection(baseOffset: 0, extentOffset: controller.text.length);
      }
    });
  }

  pickImage() async {
    final ImagePicker _picker = ImagePicker();
    var resultChoice = await showChoicePickImage();
    XFile? image;
    if (resultChoice == 0) {
      image = await _picker.pickImage(
        source: ImageSource.camera,
        maxHeight: 150,
        maxWidth: 150,
      );
    } else if (resultChoice == 1) {
      image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 150,
        maxWidth: 150,
      );
    }
    if (image != null) {
      Uint8List fileContent = await image.readAsBytes();
      sImageBase64 = base64Encode(fileContent);
      notifyListeners();
    }
  }

  showChoicePickImage() async {
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
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
              onTap: () => Navigator.of(context).pop(0),
            ),
            ListTile(
              leading: const Icon(Icons.collections),
              title: const Text("Gallery"),
              onTap: () => Navigator.of(context).pop(1),
            ),
            ListTile(
              leading: const Icon(Icons.clear),
              title: const Text("Cancel"),
              onTap: () => Navigator.of(context).pop(2),
            ),
          ],
        );
      },
    );
  }

  void onSave() async {
    DialogWait(context: context).showDialog();
    String sImage = "";
    if (sImageBase64.isEmpty) {
      sImage = md!.sPhotoBase64;
    } else {
      sImage = sImageBase64;
    }
    Map<String, Object?> mapData = {
      FieldMaster.teacherPhoto: sImage,
      FieldMaster.teacherFullName: txtDisplay.text,
      // FieldMaster.fieldUserPhone: txtPhone.text.trim(),
    };
    await usersRef
        .doc(sUID)
        .update(mapData)
        .then((value) => print("Update Complete"));
    await Future.delayed(const Duration(milliseconds: 200), () {
      DialogWait(context: context).close();
    });
    Navigator.of(context).pop();
  }
}
