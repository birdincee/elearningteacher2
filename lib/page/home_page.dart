import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elearningteacher2/cost/var_ui.dart';
import 'package:elearningteacher2/model/class_room/class_room_model.dart';
import 'package:elearningteacher2/page/drawer_menu.dart';
import 'package:elearningteacher2/provider/account/account_head_provider.dart';
import 'package:elearningteacher2/provider/auth_provider.dart';
import 'package:elearningteacher2/provider/home_provider.dart';
import 'package:elearningteacher2/utility/buttons.dart';
import 'package:elearningteacher2/utility/dialog_close_app.dart';
import 'package:elearningteacher2/utility/dialog_create.dart';
import 'package:elearningteacher2/utility/error_widget.dart';
import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String sUID;

  const HomePage({
    Key? key,
    required this.sUID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AccountProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(
            context: context,
            sUID: sUID,
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => Auth(
            context: context,
          ),
        ),
      ],
      builder: (context, _) {
        return Consumer3<AccountProvider, HomeProvider, Auth>(
          builder: (context, account, home, auth, _) {
            return WillPopScope(
              onWillPop: () async => DialogCloseApp.dialog(
                context: home.context,
                close: () => Navigator.pop(home.context),
                exit: () => home.closeApp(),
              ),
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    'สร้างชั้นเรียน',
                    style: FontThai.text18WhiteNormal,
                  ),
                ),
                drawer: DrawerMenu(
                  home: home,
                  accProv: account,
                  auth: auth,
                ).drawer(),
                body: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        StreamBuilder(
                          stream: home.getData,
                          builder: (_,
                              AsyncSnapshot<QuerySnapshot<ClassRoomModel>>
                                  snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.active) {
                              if (snapshot.hasData) {
                                var data = snapshot.data!;
                                if (data.size == 0) {
                                  // return Errors.noDataChildren();
                                  return Errors
                                      .noDataChildren(); // return const Text("NO DATA");
                                } else {
                                  return ListView.builder(
                                    itemCount: data.size,
                                    scrollDirection: Axis.vertical,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return _buildItem(
                                        md: data.docs[index].data(),
                                        sUidDoc: data.docs[index].id,
                                        index: index,
                                        home: home,
                                      );
                                    },
                                  );
                                }
                              } else {
                                return const Text('Error in loading data');
                              }
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        ),
                        VarUI.h10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  border: Border.all(
                                    color: Colors.green.shade200,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () => home.onPressedOpenCreate(
                                        account: account,
                                      ),
                                      label: Text(
                                        "รายชื่อห้องเรียน",
                                        style: FontThai.text16BlackNormal,
                                      ),
                                      icon: const Icon(Icons.add,
                                          color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(),
                            ),
                            // Flexible(
                            //   child: Buttons.btnTextCreateShare(
                            //     // onPressed: () => home.onTapCreateChildren(
                            //     //   accProv: account,
                            //     // ),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildItem({
    required ClassRoomModel md,
    required String sUidDoc,
    required int index,
    required HomeProvider home,
  }) {
    int i = index;
    var formatDate = DateFormat.yMd().add_jm();
    DateTime dateTime = DateTime.parse(md.sDateCreate);
    String date = formatDate.format(dateTime);
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () => home.onTapGotoClass(md),
        highlightColor: Colors.green.shade300,
        splashColor: Colors.green.shade200,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
                flex: 1,
                child: Text(
                  "${++i}",
                  style: FontThai.text16BlackNormal,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                )),
            VarUI.w10,
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          md.sName,
                          style: FontThai.text14GreenNormal,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          sUidDoc,
                          style: FontThai.text14GrayNormal,
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          date,
                          style: FontThai.text14GrayNormal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Buttons.iconCopy(
                  onPressed: () => home.copyUidToClipBord(sUidDoc: sUidDoc)),
            ),
          ],
        ),
      ),
    );
  }
}
