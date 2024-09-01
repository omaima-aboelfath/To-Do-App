/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                // change language to english
                provider.changeLanguage('en');
              },
              child: 
              // en
              provider.appLanguage == 'en' ?
              getSelectedItemWidget(AppLocalizations.of(context)!.english) :
              getUnselectedItemWidget(AppLocalizations.of(context)!.english),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'English',
              //       // AppLocalizations.of(context)!.english xxxxx
              //       style: Theme.of(context).textTheme.bodyMedium,
              //     ),
              //     Icon(
              //       Icons.check,
              //       size: 25,
              //     )
              //   ],
              // ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                provider.changeLanguage('ar');
              },
              child: 
              // ar
              provider.appLanguage == 'ar' ?
              getSelectedItemWidget(AppLocalizations.of(context)!.arabic) :
              getUnselectedItemWidget(AppLocalizations.of(context)!.arabic),
              // Text(
              //   'Arabic',
              //   // AppLocalizations.of(context)!.arabic xxxxxx
              //   style: Theme.of(context).textTheme.bodyMedium,
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.primaryColor)),
        Icon(
          Icons.check,
          size: 25,
          color: AppColors.primaryColor,
        )
      ],
    );
  }

  Widget getUnselectedItemWidget(String text) {
    return Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                provider.changeLanguage('en');
                Navigator.pop(context); // Close the bottom sheet after selection
              },
              child: provider.appLanguage == 'en' 
                ? getSelectedItemWidget(AppLocalizations.of(context)!.english) 
                : getUnselectedItemWidget(AppLocalizations.of(context)!.english),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              onTap: () {
                provider.changeLanguage('ar');
                Navigator.pop(context); // Close the bottom sheet after selection
              },
              child: provider.appLanguage == 'ar' 
                ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic) 
                : getUnselectedItemWidget(AppLocalizations.of(context)!.arabic),
            ),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(color: AppColors.primaryColor),
        ),
        Icon(
          Icons.check,
          size: 25,
          color: AppColors.primaryColor,
        ),
      ],
    );
  }

  Widget getUnselectedItemWidget(String text) {
    return Text(
      text,
      style: TextStyle(),
    );
  }
}
