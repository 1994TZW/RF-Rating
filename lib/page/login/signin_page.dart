import 'package:car_service/widget/signin_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/localization/app_translations.dart';
import '../../helper/theme.dart';
import '../../model/main_model.dart';
import '../../vo/setting.dart';
import '../../widget/local_text.dart';
import '../../widget/signin_button.dart';

typedef OnSignEmail = Function(String email, String password);

class SignInPage extends StatefulWidget {
  final OnSignEmail onSignEmail;
  final bool showLogo;

  const SignInPage({Key? key, required this.onSignEmail,  this.showLogo = true}) : super(key: key);
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailCtl = TextEditingController();
  final TextEditingController _passwordCtl = TextEditingController();

  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     Setting? setting = Provider.of<MainModel>(context).setting;

     print("Setting>>>>>${setting?.supportBuildNum}");
    final emailBox = SigninInput(
      controller: _emailCtl,
      labelTextKey: "login.email",
      hintText: "joe@gmail.com",
      validator: (value) {
        if (value!.isEmpty) {
          return AppTranslations.of(context).text("login.email_empty");
        }
        return null;
      },
    );

    final passwordBox = Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LocalText(context, 'login.password',
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          const SizedBox(height: 10),
          TextFormField(
              cursorColor: Colors.black54,
              controller: _passwordCtl,
              obscureText: !_obscureText,
              autofocus: false,
              readOnly: false,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    splashRadius: 20,
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: inputBoxColor, width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: inputBoxColor, width: 1.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: inputBoxColor, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: inputBoxColor, width: 1.0),
                  ),
                  hintText: "Please enter password",
                  hintStyle: TextStyle(color: inputBoxColor)),
              validator: (value) {
                if (value!.isEmpty) {
                  return AppTranslations.of(context)
                      .text("login.password_empty");
                }
                if (value.length < 6) {
                  return AppTranslations.of(context)
                      .text("login.password_size");
                }
                return null;
              })
        ],
      ),
    );

    final forgotBtn = Container(
      alignment: Alignment.topRight,
      child: TextButton(
        onPressed: () {},
        child: LocalText(
          context,
          "login.forgot_password",
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
      ),
    );

    final signinButton = SigninButton(
      callBack: () {
        _login();
      },
      textKey: 'login.btn',
      color: primaryColor,
    );

    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
            children: [
              const SizedBox(height: 30),
              widget.showLogo?
              Hero(
                tag: "logo",
                child: Image.asset(
                  "assets/logo.jpg",
                  height: 130,
                  filterQuality: FilterQuality.medium,
                ),
              ):const SizedBox(),
              const SizedBox(height: 20),
              Center(
                  child: LocalText(context, "login.title",
                      color: Colors.black, fontSize: 18)),
              const SizedBox(height: 20),
              emailBox,
              const SizedBox(height: 5),
              passwordBox,
              forgotBtn,
              const SizedBox(height: 30),
              signinButton,
              const SizedBox(height: 20),
            ]),
      ),
    );
  }

  _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    widget.onSignEmail(_emailCtl.text, _passwordCtl.text);
  }
}
