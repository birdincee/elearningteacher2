import 'package:elearningteacher2/cost/var_ui.dart';
import 'package:elearningteacher2/provider/account/account_register_provider.dart';
import 'package:elearningteacher2/provider/auth_provider.dart';
import 'package:elearningteacher2/utility/buttons.dart';
import 'package:elearningteacher2/utility/text_fied.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(context: context),
        ),
        ChangeNotifierProvider(
          create: (_) => AccountRegister(context: context),
        ),
      ],
      builder: (context, _) {
        return Consumer2<Auth, AccountRegister>(
          builder: (context, auth, accProv, _) {
            ScrollController scrollController = ScrollController();
            return Scaffold(
              backgroundColor: const Color(0xffFFC0CB),
              appBar: AppBar(
                title: const Text(
                  "สร้างบัญชีผู้ใช้ใหม่",
                ),
              ),
              body: Scrollbar(
                controller: scrollController,
                child: SingleChildScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  child: Card(
                    margin: const EdgeInsets.only(
                        top: 20, right: 20, left: 20, bottom: 20),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _logoApp(),
                          VarUI.h10,
                          Row(
                            children: [
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                  flex: 8,
                                  child: TextFields.textFieldSignIN(
                                    controller: accProv.txtEmail,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.emailAddress,
                                    icon: Icons.email,
                                    hint: "",
                                  )),
                              const Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                          VarUI.h10,
                          Row(
                            children: [
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                  flex: 8,
                                  child: TextFields.textFieldSignIN(
                                    controller: accProv.txtDisplay,
                                    textInputAction: TextInputAction.next,
                                    keyboardType: TextInputType.text,
                                    icon: Icons.badge,
                                    hint: "Display Name",
                                  )),
                              const Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                          VarUI.h10,
                          // Row(
                          //   children: [
                          //     const Spacer(
                          //       flex: 1,
                          //     ),
                          //     Expanded(
                          //       flex: 8,
                          //       child: TextFields.textFieldSignIN(
                          //         controller: accProv.txtPhone,
                          //         textInputAction: TextInputAction.next,
                          //         keyboardType: TextInputType.phone,
                          //         icon: Icons.phone,
                          //         inputFormatters: [
                          //           FilteringTextInputFormatter.digitsOnly,
                          //           LengthLimitingTextInputFormatter(10),
                          //         ],
                          //       ),
                          //     ),
                          //     const Spacer(
                          //       flex: 1,
                          //     ),
                          //   ],
                          // ),
                          VarUI.h10,
                          Row(
                            children: [
                              const Spacer(
                                flex: 1,
                              ),
                              Expanded(
                                flex: 8,
                                child: TextFields.textFieldSignIN(
                                  controller: accProv.txtPassword,
                                  obscureText: true,
                                  icon: Icons.password,
                                  hint: "You Password",
                                ),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                            ],
                          ),
                          VarUI.h10,
                          Buttons.btnSignUP2(
                            onPressed: () => accProv.onClickSigUp(
                              auth: auth,
                            ),
                          ),
                        ],
                      ),
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

  Widget _logoApp() {
    return SizedBox(
      width: 150,
      height: 150,
      child: Image.asset(
        "assets/images/logolearning.jpg",
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
