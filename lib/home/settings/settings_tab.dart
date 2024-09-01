/*
import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/home/settings/language_bottom_sheet.dart';
import 'package:to_do_app/home/settings/theme_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            // 'Language',
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: height * 0.017,
          ),
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.blackDarkColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: AppColors.primaryColor, width: 1.5)),
            child: InkWell(
              // to be clickable
              onTap: () {
                showLanguageBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // 'English' or arabic,
                    Localizations.localeOf(context)!.languageCode == 'en' 
                    ? AppLocalizations.of(context)!.english
                    : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: height * 0.03,
          ),
          Text(
            // 'Mode',
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(
            height: height * 0.017,
          ),
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.blackDarkColor
                    : AppColors.whiteColor,
                borderRadius: BorderRadius.circular(2),
                border: Border.all(color: AppColors.primaryColor, width: 1.5)),
            child: InkWell(
              onTap: () {
                showThemeBottomSheet();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // 'Light' or dark,
                    Theme.of(context).brightness == Brightness.dark 
                    ? AppLocalizations.of(context)!.dark
                    : AppLocalizations.of(context)!.light,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// convert class to stateful widget that can access context of build outside the build scope
  void showLanguageBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

// or you will pass it as a parameter to the function and in the calling pass to it the context of build
//   void showLanguageBottomSheet(BuildContext cont) {
//     showModalBottomSheet(
//       context: cont,
//       builder: builder);
//   }     ///// showLanguageBottomSheet(context);

  void showThemeBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }

  
}
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/home/settings/language_bottom_sheet.dart';
import 'package:to_do_app/home/settings/theme_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/providers/app_config_provider.dart';

class SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: height * 0.017),
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: provider.isDarkMode() ? AppColors.blackDarkColor : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: AppColors.primaryColor, width: 1.5),
            ),
            child: InkWell(
              onTap: () {
                showLanguageBottomSheet(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appLanguage == 'en' 
                      ? AppLocalizations.of(context)!.english 
                      : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: height * 0.03),
          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: height * 0.017),
          Container(
            padding: EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: provider.isDarkMode() ? AppColors.blackDarkColor : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: AppColors.primaryColor, width: 1.5),
            ),
            child: InkWell(
              onTap: () {
                showThemeBottomSheet(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.isDarkMode() 
                      ? AppLocalizations.of(context)!.dark 
                      : AppLocalizations.of(context)!.light,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageBottomSheet(),
    );
  }

  void showThemeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeBottomSheet(),
    );
  }
}
