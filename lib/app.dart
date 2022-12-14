import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'helper/localization/app_translations_delegate.dart';
import 'helper/localization/transalation.dart';
import 'model/language_model.dart';
import 'model/main_model.dart';
import 'page/home_page.dart';
import 'page/login/login_screen_builder.dart';
import 'page/splash_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final MainModel mainModel = MainModel();
  final LanguageModel lanuguageModel = LanguageModel();
  

  // final TimetableModel _timetableModel = TimetableModel();
  // final AnnouncementModel _announcementModel = AnnouncementModel();
  // final RegistrationModel _registrationModel = RegistrationModel();

  late AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    _newLocaleDelegate =
        AppTranslationsDelegate(newLocale: Translation.defaultLocale);
    Translation().onLocaleChanged = onLocaleChange;

    // mainModel.addModel(_timetableModel);
    // mainModel.addModel(_announcementModel);
    // mainModel.addModel(_registrationModel);
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  Map<String, WidgetBuilder> route(BuildContext context) {
    final routes = <String, WidgetBuilder>{
      '/': (_) => const SplashScreen(),
      '/login': (_) => const LoginScreenBuilder(),
      '/home': (_) => const HomePage()
    };
    return routes;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: mainModel),
          ChangeNotifierProvider.value(value: lanuguageModel),
    
          // ChangeNotifierProvider.value(value: _timetableModel),
          // ChangeNotifierProvider.value(value: _announcementModel),
          // ChangeNotifierProvider.value(value: _registrationModel),
        ],
        child: Consumer<LanguageModel>(
          builder: (context, value, child) {
            return CupertinoApp(
                debugShowCheckedModeBanner: false,
                title: 'ABSQ',
                routes: route(context),
                localizationsDelegates: [
                  _newLocaleDelegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: Translation().supportedLocales());
          },
        ));
  }
}
