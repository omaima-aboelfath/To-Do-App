import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/providers/app_config_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
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
                // change theme to light
                provider.changeMode(ThemeMode.light);
              },
              child: 
              provider.appMode == ThemeMode.light?
              getSelectedItemWidget(AppLocalizations.of(context)!.light) :
              getUnselectedItemWidget(AppLocalizations.of(context)!.light)
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Light',
              //       // AppLocalizations.of(context)!.light, xxxxx
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
                // change theme to dark
                provider.changeMode(ThemeMode.dark);
              },
              child: 
               // provider.appMode == ThemeMode.dark?
              // getSelectedItemWidget(AppLocalizations.of(context)!.dark) :
              // getUnselectedItemWidget(AppLocalizations.of(context)!.light)
              //// OR
              provider.isDarkMode()?
              getSelectedItemWidget(AppLocalizations.of(context)!.dark) :
              getUnselectedItemWidget(AppLocalizations.of(context)!.dark)
              // Text(
              //   'Dark',
              //   // AppLocalizations.of(context)!.dark, xxxxx
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
