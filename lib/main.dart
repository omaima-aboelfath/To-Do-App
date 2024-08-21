import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/home/home_screen.dart';
import 'package:to_do_app/my_theme_data.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppConfigProvider(), 
      child: MyApp())
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // create object of Provider
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.route,
      routes: {
        HomeScreen.route: (context) => HomeScreen(),
      },
  //     localizationsDelegates: const [
  //   // Add the localization delegates here
  //   GlobalMaterialLocalizations.delegate,
  //   GlobalWidgetsLocalizations.delegate,
  //   GlobalCupertinoLocalizations.delegate,
  // ],
  // supportedLocales: const [
  //   // Add the supported locales here
  //   Locale('en'), 
  //   Locale('ar'), 
  // ],
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      // themeMode: ThemeMode.light, //اتحكم ف المود اللي هيشتغل
      // locale: Locale('ar'), // اتحكم في لغة التطبيق
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
      themeMode: provider.appMode,
    );
  }
}
