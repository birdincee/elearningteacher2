import 'dart:convert';
import 'package:elearningteacher2/cost/var_ui.dart';
import 'package:elearningteacher2/provider/account_edit_provider.dart';
import 'package:elearningteacher2/utility/buttons.dart';
import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:elearningteacher2/utility/text_fied.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AccountEditPage extends StatelessWidget {
  final String sUID;

  const AccountEditPage({
    Key? key,
    required this.sUID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AccountEditProvider(
                  context: context,
                  sUID: sUID,
                )),
      ],
      builder: (_, child) {
        return Consumer<AccountEditProvider>(
          builder: (context, acc, _) {
            if (acc.bFirst) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.pink,
                    backgroundColor: Colors.pink.shade300,
                  ),
                ),
              );
            } else {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    'แก้ไขข้อมูลผู้ใช้งาน',
                    style: FontThai.text18WhiteNormal,
                  ),
                ),
                body: Scrollbar(
                  controller: acc.scrollController,
                  child: SingleChildScrollView(
                    controller: acc.scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      width: MediaQuery.of(acc.context).size.width,
                      height: MediaQuery.of(acc.context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: 150.0,
                              height: 150.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.pink, width: 2.0),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                radius: 30,
                                borderRadius: BorderRadius.circular(30),
                                onTap: () => acc.pickImage(),
                                child: ClipOval(
                                  child: Image(
                                    image: MemoryImage(
                                      acc.sImageBase64.isNotEmpty
                                          ? base64Decode(acc.sImageBase64)
                                          : base64Decode(acc.md!.sPhotoBase64),
                                    ),
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          VarUI.h25,
                          Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 8,
                                child: TextFields.textFieldEdit(
                                  controller: acc.txtDisplay,
                                  focusNode: acc.focusName,
                                  textInputAction: TextInputAction.next,
                                  iconData: Icons.badge,
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                          VarUI.h10,
                          Buttons.btnSave(onPressed: () => acc.onSave()),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
