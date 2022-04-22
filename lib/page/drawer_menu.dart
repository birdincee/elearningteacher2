import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearningteacher2/model/model_user.dart';
import 'package:elearningteacher2/provider/account/account_head_provider.dart';
import 'package:elearningteacher2/provider/auth_provider.dart';
import 'package:elearningteacher2/provider/home_provider.dart';
import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:flutter/material.dart';

class DrawerMenu {
  final HomeProvider home;
  final AccountProvider accProv;
  final Auth auth;

  DrawerMenu({
    required this.home,
    required this.accProv,
    required this.auth,
  });

  Drawer drawer() {
    return Drawer(
      elevation: 5,
      child: ListView(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        children: [
          StreamBuilder(
            stream: accProv.usersRef.doc(home.sUID).snapshots(),
            builder: (_, AsyncSnapshot<DocumentSnapshot<ModelUser>> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  return _contentHeader(md: data.data()!);
                } else {
                  return const Text('Error in loading data');
                }
              } else {
                return SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.pink,
                      backgroundColor: Colors.pink.shade300,
                    ),
                  ),
                );
              }
            },
          ),
          Divider(
            height: 10,
            color: Colors.grey.shade800,
            thickness: 10,
          ),
          _menu(
            sText: "หน้าหลัก",
            iconData: Icons.home,
            onTap: () => Navigator.pop(home.context),
          ),
          _menu(
            sText: "แก้ไขข้อมูลผู้ใช้งาน",
            iconData: Icons.edit,
            onTap: () => home.goToEditUser(),
          ),
          _menu(
            sText: "ออกจากระบบ",
            iconData: Icons.exit_to_app,
            onTap: () => auth.signOut(),
          ),
        ],
      ),
    );
  }

  Widget _menu({
    required String sText,
    IconData? iconData,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(
        iconData,
        size: 26,
        color: Colors.pink,
      ),
      title: Text(
        sText,
        style: FontThai.text14BlackBold,
      ),
      onTap: onTap,
    );
  }

  Widget _contentHeader({required ModelUser md}) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.pink.shade600,
            Colors.pink.shade800,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
            child: Container(
              width: 80,
              height: 80,
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.memory(
                  base64Decode(md.sPhotoBase64),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            md.sName,
            style: FontThai.text16WhiteNormal,
          ),
          Text(
            md.sEmail,
            style: FontThai.text14BlackNormal,
          ),
        ],
      ),
    );
  }
}
