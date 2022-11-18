import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:car_service/helper/theme.dart';
import 'package:car_service/model/main_model.dart';
import 'package:car_service/widget/local_app_bar.dart';
import 'package:car_service/widget/local_progress.dart';

import '../widget/local_button.dart';
import '../widget/screen_layout_builder.dart';
import 'util.dart';

typedef ProfileCallback = void Function();

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  GlobalKey key = GlobalKey();
  bool _isLoading = false;
  TextEditingController bizNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MainModel mainModel = Provider.of<MainModel>(context);
    if (mainModel.user == null) {
      return Container();
    }

    final logoBox = Container(
      width: 120,
      height: 120,
      alignment: Alignment.center,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: nonePhotoBgColor),
      child: Text(
        mainModel.user!.getFirstLetter().toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.black, fontSize: 37),
      ),
    );

    final versionBox = Text(
        "v ${mainModel.packageInfo?.version}+${mainModel.packageInfo?.buildNumber}");

    final logoutBtn = Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: LocalButton(
        iconData: Icons.exit_to_app,
        textKey: "btn.logout",
        onTap: () {
          _logout();
        },
      ),
    );

    final bodyBox = Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 20),
          logoBox,
          const SizedBox(height: 10),
          Center(
            child: Text(
              mainModel.user?.email ?? "",
              style: const TextStyle(fontSize: 20, color: Colors.black),
            ),
          ),
          const SizedBox(height: 20),
          logoutBtn,
          const SizedBox(height: 10),
          Center(child: versionBox),
        ],
      ),
    );

    return LocalProgress(
      inAsyncCall: _isLoading,
      child: Scaffold(
          key: key,
          backgroundColor: Colors.white,
          appBar: const LocalAppBar(
            labelKey: "profile.title",
            backgroundColor: Colors.white,
            labelColor: Colors.black,
            arrowColor: Colors.black,
          ),
          body: ScreenLayoutBuilder(
              screenBuilder: (context, isMobile) => isMobile
                  ? bodyBox
                  : Container(
                      margin:
                          const EdgeInsets.only(left: 200, right: 200, top: 20),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: bodyBox))),
    );
  }

  _logout() {
    showConfirmDialog(context, "profile.logout.confirm", () async {
      setState(() {
        _isLoading = true;
      });
      try {
        // await context.read<MainModel>().signout();
      } catch (e) {
        print(e);
      } finally {
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        });
        Navigator.of(context)
            .pushNamedAndRemoveUntil("/login", ModalRoute.withName('/login'));
      }
    });
  }
}
