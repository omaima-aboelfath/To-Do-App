import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/firebase_utils.dart';
// import 'package:to_do_app/home/task_list/edit_task.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:to_do_app/home/task_list/edit_task.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/providers/list_provider.dart';

class TaskListItem extends StatelessWidget {
  // object from model to access title & desc of task
  Task task;
  TaskListItem({required this.task});
  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    return Container(
      margin: EdgeInsets.all(10),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.48,
          // A motion is a widget used to control how the pane animates.
          motion: const BehindMotion(),
          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                // delete task
                FirebaseUtils.deleteTaskFromFireStore(task, task.id).timeout(
                  Duration(seconds: 1),
                  onTimeout: () {
                    print('task deleted successfully');
                    // print list after deleting task
                    listProvider.getAllTasksFromFireStore();
                  },
                );
              },
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              label: 'delete',
              // label: AppLocalizations.of(context)!.delete,
            ),
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                // edit task
                // Navigator.pushNamed(context, EditTask.routeName);
              },
              backgroundColor: AppColors.greyColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.edit,
              label: 'edit',
              // label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).brightness == Brightness.dark
                ? AppColors.blackDarkColor
                : AppColors.whiteColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                color: AppColors.primaryColor,
                height: MediaQuery.of(context).size.height * 0.1,
                width: 4,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // 'task1',
                    task.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  Text(
                    // 'task1 description',
                    task.description,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.whiteColor
                              : AppColors.blackColor,
                        ),
                  ),
                ],
              )),
              Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.primaryColor),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.check,
                      color: AppColors.whiteColor,
                      size: 35,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
