import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearningteacher2/model/model_user.dart';
import 'package:flutter/material.dart';

class AccountProvider with ChangeNotifier {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('account');

  final usersRef =
      FirebaseFirestore.instance.collection('account').withConverter<ModelUser>(
            fromFirestore: (snapshot, _) =>
                ModelUser.formJson(json: snapshot.data()!),
            toFirestore: (user, _) => user.toJson(),
          );

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtDisplay = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController teacherCreateRoom = TextEditingController();

  Future<int> createUser({
    required String sUID,
    required ModelUser model,
  }) async {
    int iResult = 0;
    await usersRef.doc(sUID).set(model).then((value) {
      print("UserAdded");
      iResult = 1;
    });
    return iResult;
  }

  Future<ModelUser?> getByUID(String sUID) async {
    return await usersRef.doc(sUID).get().then((value) => value.data());
  }
}
