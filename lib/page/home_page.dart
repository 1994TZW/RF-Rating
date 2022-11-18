import 'package:car_service/widget/local_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/localization/app_translations.dart';
import '../helper/localization/transalation.dart';
import '../helper/theme.dart';
import '../model/language_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../model/main_model.dart';
import '../widget/local_progress.dart';
import '../widget/rating_local_progress.dart';
import '../widget/screen_layout_builder.dart';
import '../widget/signin_button.dart';
import 'profile_page.dart';
import 'util.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> isSelected = [true, false];
  final TextEditingController _remarkCtl = TextEditingController();
  double _rating = 3.0;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var languageModel = Provider.of<LanguageModel>(context);
    var mainModel = Provider.of<MainModel>(context);
    double width = MediaQuery.of(context).size.width;

    final langToggle = ToggleButtons(
      onPressed: _langChange,
      borderColor: Colors.transparent,
      isSelected: languageModel.currentState,
      selectedBorderColor: Colors.white24,
      children: <Widget>[
        Image.asset(
          'icons/flags/png/us.png',
          package: 'country_icons',
          fit: BoxFit.fitWidth,
          width: 25,
        ),
        Image.asset(
          'icons/flags/png/mm.png',
          package: 'country_icons',
          fit: BoxFit.fitWidth,
          width: 25,
        )
      ],
    );

    final doneButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
      child: SigninButton(
        callBack: () {
          _onDone();
        },
        textKey: 'home.done.btn',
        color: primaryColor,
      ),
    );

    return RatingLocalProgress(
      inAsyncCall: _isLoading,
      context: context,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Hero(
              tag: "logo",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  "assets/logo1.png",
                  height: 50,
                  width: 50,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
            actions: [
              langToggle,
              IconButton(
                  splashRadius: 23,
                  iconSize: 30,
                  icon: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: nonePhotoBgColor),
                    child: Text(
                      mainModel.user!.getFirstLetter().toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (context) => Profile()),
                    );
                  })
            ],
          ),
          body: ScreenLayoutBuilder(
            screenBuilder: (context, isMobile) => Container(
              margin: isMobile
                  ? null
                  : const EdgeInsets.only(left: 150, right: 150, top: 20),
              padding: isMobile ? null : const EdgeInsets.all(20.0),
              decoration: isMobile
                  ? null
                  : BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(5.0)),
                    ),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/car_cleaning.jpg",
                            filterQuality: FilterQuality.medium,
                          ),
                          SizedBox(
                            height: isMobile ? 70 : 100,
                            child: LocalText(context, "home.instruction",
                                fontSize: isMobile
                                    ? languageModel.isEng
                                        ? 20
                                        : 18
                                    : languageModel.isEng
                                        ? 27
                                        : 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          RatingBar.builder(
                            initialRating: _rating,
                            itemCount: 5,
                            itemSize: isMobile ? (width / 6) : (width / 9),
                            itemBuilder: (context, index) {
                              switch (index) {
                                case 0:
                                  return emotionIcon(
                                      icon: Icons.sentiment_dissatisfied,
                                      color: secondaryColor);

                                case 1:
                                  return emotionIcon(
                                      icon: Icons.sentiment_very_dissatisfied,
                                      color: thirdColor);

                                case 2:
                                  return emotionIcon(
                                      icon: Icons.sentiment_neutral,
                                      color: Colors.amber);

                                case 3:
                                  return emotionIcon(
                                      icon: Icons.sentiment_satisfied,
                                      color: Colors.lightGreen);

                                case 4:
                                  return emotionIcon(
                                      icon: Icons.sentiment_very_satisfied,
                                      color: Colors.green);
                              }
                              return Container();
                            },
                            onRatingUpdate: (rating) {
                              print(rating);
                              setState(() {
                                _rating = rating;
                              });
                            },
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              cursorColor: Colors.black54,
                              controller: _remarkCtl,
                              maxLines: 5,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade200,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: inputBoxColor, width: 1.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: inputBoxColor, width: 1.0),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: inputBoxColor, width: 1.0),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: inputBoxColor, width: 1.0),
                                  ),
                                  hintText: AppTranslations.of(context)
                                      .text("home.remark"),
                                  hintStyle: languageModel.isEng
                                      ? newLabelStyle(
                                          color: Colors.grey.shade400)
                                      : newLabelStyleMM(
                                          color: Colors.grey.shade400)),
                            ),
                          ),
                          const SizedBox(height: 30),
                          doneButton,
                          const SizedBox(height: 30),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget emotionIcon({required IconData icon, required Color color}) {
    return Icon(icon, color: color);
  }

  _langChange(index) {
    var languageModel = Provider.of<LanguageModel>(context, listen: false);
    languageModel.saveLanguage(Translation().supportedLanguages[index]);
    setState(() {
      isSelected.asMap().forEach((i, e) {
        isSelected[i] = false;
      });
      isSelected[index] = !isSelected[index];
    });
  }

  _onDone() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await context.read<MainModel>().onRating(_rating, _remarkCtl.text);
    } catch (e) {
      showMsgDialog(context, "Error", e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
