import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/model/task.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'edit_task';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  DateTime selectDate = DateTime.now();
  late TextEditingController titleController;
  late TextEditingController detailsController;

  @override
  Widget build(BuildContext context) {
    // recieve arguments from TaskListItem class
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args == null || args is! Task) {
      return Scaffold(
        body: Center(
          child: Text('No task data found.'),
        ),
      );
    }
    final Task task = args; // Now you can safely cast

    // Use task object for further processing
    titleController = TextEditingController(text: task.title);
    detailsController = TextEditingController(text: task.description);
    selectDate = task.dateTime;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
          AppLocalizations.of(context)!.app_title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.blackDarkColor
              : AppColors.whiteColor,
        ),
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Edit Task',
                // AppLocalizations.of(context)!.edit_task,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    labelText: 'Enter your task title',
                    // AppLocalizations.of(context)!.this_is_title,
                    labelStyle: Theme.of(context).textTheme.displaySmall),
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: detailsController,
                decoration: InputDecoration(
                    labelText: 'Task details',
                    // AppLocalizations.of(context)!.task_details,
                    labelStyle: Theme.of(context).textTheme.displaySmall),
                maxLines: 3,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                // 'Select date',
                AppLocalizations.of(context)!.select_date,
                style: GoogleFonts.inter(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.greyColor
                        : AppColors.blackColor),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  showCalender();
                },
                child: Text(
                  '${selectDate.day} - ${selectDate.month} - ${selectDate.year}',
                  style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.greyColor
                          : AppColors.blackColor),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            FloatingActionButton(
                onPressed: () {
                  // Update the task with new data
                  task.title = titleController.text;
                  task.description = detailsController.text;
                  task.dateTime = selectDate;

                  // Call updateTaskFromFireStore method
                  FirebaseUtils.updateTaskFromFireStore(task).timeout(
                    Duration(seconds: 1),
                    onTimeout: () {
                      print('Task updated successfully');
                      SnackBar(
                        content: Text('Task updated successfully'),
                        backgroundColor: AppColors.greenColor,
                      );
                    },
                  );

                  // // Go back to the home screen
                  Navigator.pop(context);
                },
                child: Text(
                  'save changes',
                  // AppLocalizations.of(context)!.save_changes,
                  style: TextStyle(color: AppColors.whiteColor),
                ))
          ],
        ),
      ),
    );
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

  // void saveChanges() async {
  //   Task updatedTask = Task(
  //       // id: widget.task.id,
  //       title: titleController.text,
  //       description: detailsController.text,
  //       dateTime: selectDate);
  //   await FirebaseUtils.updateTaskFromFireStore(updatedTask);
  //   // .timeout(
  //   //   Duration(seconds: 1),
  //   //   onTimeout: () {
  //   //     print('task updated successfully');
  //   //     // print list after deleting task
  //   //     var listProvider = Provider.of<ListProvider>(context);
  //   //     listProvider.getAllTasksFromFireStore();
  //   //   },
  //   // );
  //   Navigator.pushNamed(context, HomeScreen.routeName);
  // }
}
