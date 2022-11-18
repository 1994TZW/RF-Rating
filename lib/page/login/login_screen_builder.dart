import 'package:car_service/widget/local_text.dart';
import 'package:flutter/material.dart';
import 'package:car_service/helper/theme.dart';
import 'package:provider/provider.dart';
import '../../model/main_model.dart';
import '../../widget/local_progress.dart';
import '../../widget/screen_layout_builder.dart';
import '../../widget/tablet_page.dart';
import '../util.dart';
import 'signin_page.dart';

class LoginScreenBuilder extends StatefulWidget {
  const LoginScreenBuilder({Key? key}) : super(key: key);

  @override
  State<LoginScreenBuilder> createState() => _LoginScreenBuilderState();
}

class _LoginScreenBuilderState extends State<LoginScreenBuilder> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return LocalProgress(
      inAsyncCall: _isLoading,
      child: SafeArea(
        child: Scaffold(
          body: ScreenLayoutBuilder(
            screenBuilder: (context, isMobile) => isMobile
                ? SignInPage(
                    onSignEmail: (String email, String password) =>
                        _loginEmail(email, password),
                  )
                : Scaffold(
                    body: TabletPage(
                        leftWidget: Container(
                            width: width,
                            color: primaryColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "assets/logo1.png",
                                  height: 130,
                                  filterQuality: FilterQuality.medium,
                                ),
                                const SizedBox(height: 20),
                                Center(
                                    child: LocalText(
                                        context, "login.instruction",
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal))
                              ],
                            )),
                        rightWidget: Padding(
                          padding: EdgeInsets.only(
                              left: 70, right: 70, top: height / 4),
                          child: SignInPage(
                            showLogo: false,
                            onSignEmail: (String email, String password) =>
                                _loginEmail(email, password),
                          ),
                        )),
                  ),
          ),
        ),
      ),
    );
  }

  _loginEmail(String email, String password) async {
    setState(() {
      _isLoading = true;
    });

    try {
      context.read<MainModel>().signinWithEmail(email, password);
      await Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
    } catch (e) {
      showMsgDialog(context, "Error", e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
