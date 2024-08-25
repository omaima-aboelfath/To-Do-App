import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/home/task_list/task_list_item.dart';
import 'package:to_do_app/model/task.dart';
import 'package:to_do_app/providers/list_provider.dart';

/*
tasksList changes in 2 places:
1- in adding button in bottom sheet
2- in UI of task list tab the length will change
will use StateManagement because the data when changes it affects multiple widgets
 */

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  // list of Task objects
  // List<Task> tasksList = [];

  @override
  Widget build(BuildContext context) {
    var listProvider = Provider.of<ListProvider>(context);
    // One-time read
    // if (listProvider.tasksList.isEmpty) {
    listProvider.getAllTasksFromFireStore();
    // }
    return Container(
        child: Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
            listProvider.changeSelectDate(selectedDate);
          },
          headerProps: EasyHeaderProps(
            monthPickerType: MonthPickerType.dropDown,
            dateFormatter: DateFormatter.fullDateDMY(),
            selectedDateStyle: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.whiteColor
                  : AppColors.blackColor,
            ),
          ),
          dayProps: EasyDayProps(
            dayStructure: DayStructure.dayStrDayNum,
            inactiveDayStyle: DayStyle(
                dayNumStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                    ),
                dayStrStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                    ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.blackDarkColor
                      : AppColors.whiteColor,
                )),
            activeDayStyle: DayStyle(
              dayNumStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.primaryColor),
              dayStrStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.primaryColor),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? AppColors.blackDarkColor
                      : AppColors.whiteColor),
            ),
          ),
        ),
        Expanded(
          child: listProvider.tasksList.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(100),
                  child: Text("No Tasks Added"),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return TaskListItem(
                      // access data inside list
                      task: listProvider.tasksList[index],
                    );
                  },
                  // itemCount: 10,
                  itemCount: listProvider.tasksList.length,
                ),
        ),
      ],
    ));
  }

  // void getAllTasksFromFireStore() async {
  //   // .get will return Future<QuerySnapshot<Task>> => return every thing in collection(docs) in firebase
  //   // use await on result because it returns => --Future--<QuerySnapshot<Task>>
  //   var querySnapshot = await FirebaseUtils.getTasksCollection().get();
  //   // we want to convert List<QueryDocumentSnapshot<Task>> => List<Task>
  //   // doc is object from List<QueryDocumentSnapshot<Task>>
  //   // map will convert every document snapshot into task
  //   tasksList = querySnapshot.docs.map((doc) {
  //     // access task from doc object
  //     return doc.data();
  //   }).toList(); // map return iterable so we will convert it to list
  //   for (int i = 0; i < tasksList.length; i++) {
  //     print(tasksList[i].title);
  //   }
  //   setState(() {});
  // }
}
