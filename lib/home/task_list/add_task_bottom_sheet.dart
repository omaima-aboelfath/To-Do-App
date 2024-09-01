import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/providers/list_provider.dart';
import 'package:to_do_app/providers/user_provider.dart';

class AddTaskBottomSheet extends StatefulWidget {
  // late String title ;

  // late String description ;
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  String title = '';

  String description = '';

  var formKey = GlobalKey<FormState>();

  DateTime selectDate = DateTime.now(); // or var

  // because we haven't initial value because we need context so will set it late
  late ListProvider listProvider; // global

  @override
  Widget build(BuildContext context) {
    // update value
    listProvider = Provider.of<ListProvider>(context);
    // Create a DateFormat object with the desired pattern
    DateFormat dateFormat = DateFormat('d - M - yyyy');

    // Format the date
    String formattedDate = dateFormat.format(selectDate);
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
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
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
                      child: InkWell(
                        onTap: () {
                          showCalender();
                        },
                        child: Text(
                          formattedDate,
                          // '${selectDate.day} - ${selectDate.month} - ${selectDate.year}',
                          style: GoogleFonts.inter(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? AppColors.greyColor
                                  : AppColors.blackColor),
                        ),
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
    if (formKey.currentState?.validate() == true) {
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      Task task =
          Task(title: title, description: description, dateTime: selectDate);
      FirebaseUtils.addTaskToFireStore(task, userProvider.currentUser!.id)
          // online
          .then(
        (value) {
          print('task added successfully');
          Navigator.pop(context); // to close bottomSheet after adding task
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Task added successfully')),
          );
          listProvider.getAllTasksFromFireStore(userProvider.currentUser!.id);
        },
      )
          // offline
          .timeout(
        // after one sec will print
        Duration(seconds: 1),
        onTimeout: () {
          print('task added successfully');
          Navigator.pop(context); // to close bottomSheet after adding task
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Task added successfully')),
          );

          // print(task.id);
          // هيجيب الكولكشن كلها بما فيها المهمة الجديدة اللي اتضافت
          listProvider.getAllTasksFromFireStore(userProvider
              .currentUser!.id); // update list when clicking the button
        },
      );
    }
  }

  Future<void> showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        // initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    // if user chosen a date
    if (chosenDate != null) {
      selectDate = chosenDate;
    }
    // default val : if LHS(chosenDate) = null then put default val(DateTime.now) in selectDate
    // selectDate = chosenDate ?? DateTime.now();
    setState(() {});
  }
}
