import 'package:elearningteacher2/cost/var_ui.dart';
import 'package:elearningteacher2/provider/auth_provider.dart';
import 'package:elearningteacher2/utility/buttons.dart';
import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:elearningteacher2/utility/text_fied.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Auth(context: context),
      builder: (context, _) {
        return Consumer<Auth>(
          builder: (context, auth, _) {
            Size size = MediaQuery.of(context).size;
            return Scaffold(
              body: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage("assets/images/learningbg.jpg"),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.pink.withOpacity(0.5), BlendMode.hue),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    _signINContent(
                      context: context,
                      auth: auth,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _signINContent({
    required BuildContext context,
    required Auth auth,
  }) {
    return Card(
      margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _logoApp(),
            VarUI.h10,
            FittedBox(
              child: Text(
                "E-learning Teacher",
                style: FontThai.text18BlackBold,
              ),
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
                      controller: auth.txtEmail,
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
                      controller: auth.txtPassword,
                      obscureText: true,
                      icon: Icons.password,
                    )),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
            VarUI.h10,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Buttons.btnSignIN(
                  onPressed: () => auth.onClickSignIn(),
                ),
                Buttons.btnSignUP(
                  onPressed: () => auth.gotoRegis(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _logoApp() {
    return SizedBox(
      width: 150,
      height: 150,
      child: Image.asset(
        "assets/images/logoName.png",
        fit: BoxFit.cover,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}
