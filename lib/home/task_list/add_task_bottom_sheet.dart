import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddTaskBottomSheet extends StatelessWidget {
  String title = '';
  String description = '';
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Text(
              // 'Add New Task',
              AppLocalizations.of(context)!.add_new_task,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Form(
                // refrence to anything inside form - to access user inputs
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        // call back fun
                        onChanged: (text) {
                          title = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'please enter task title'; // field invalid
                          }
                          return null; // field valid
                        },
                        decoration: InputDecoration(
                            labelText:
                                // 'Enter your task title',
                                AppLocalizations.of(context)!
                                    .enter_your_task_title,
                            labelStyle:
                                Theme.of(context).textTheme.displaySmall),
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (text) {
                          description = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'please enter task description'; // field invalid
                          }
                          return null; // field valid
                        },
                        decoration: InputDecoration(
                            labelText:
                                // 'Enter your task description',
                                AppLocalizations.of(context)!
                                    .enter_your_task_description,
                            labelStyle:
                                Theme.of(context).textTheme.displaySmall),
                        maxLines: 3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Text(
                        // 'Select date',
                        AppLocalizations.of(context)!.select_date,
                        style: GoogleFonts.inter(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.greyColor
                                    : AppColors.blackColor),
                        // Theme.of(context)
                        //     .textTheme
                        //     .displaySmall
                        //     ?.copyWith(fontWeight: FontWeight.bold)

                        // GoogleFonts.inter(
                        //     fontSize: 17,
                        //     fontWeight: FontWeight.w400,
                        //     color: AppColors.blackColor
                        //   ),
                      ),
                    ),
                    Center(
                      child: Text(
                        '8 - 9 - 2024',
                        style: GoogleFonts.inter(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.greyColor
                                    : AppColors.blackColor),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        addTask();
                      },
                      child: Icon(
                        Icons.check_sharp,
                        color: AppColors.whiteColor,
                        size: 35,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
    );
  }

  void addTask() {
    // validate() has forloop to loop on validators that i make
    // if we return string => invalid => validate will return false
    if (formKey.currentState?.validate() == true) {}
  }
}
