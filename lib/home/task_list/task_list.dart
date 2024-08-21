import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/home/task_list/task_list_item.dart';

class TaskListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.all(10),
        // padding: EdgeInsets.all(5),
        child: Column(
      children: [
        EasyDateTimeLine(
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
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
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskListItem();
            },
            itemCount: 10,
          ),
        ),
      ],
    ));
  }
}
