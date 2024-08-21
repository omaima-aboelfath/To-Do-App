import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/home/home_screen.dart';

class TaskListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.26,
          // A motion is a widget used to control how the pane animates.
          motion: const BehindMotion(),
          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.circular(15),
              onPressed: (context) {
                // delete task
              },
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              label: 'Delete',
            ),
            // SlidableAction(
            //   onPressed: (context) {
            //     // edit task
            //   },
            //   backgroundColor: Color(0xFF21B7CA),
            //   foregroundColor: Colors.white,
            //   icon: Icons.share,
            //   label: 'Share',
            // ),
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
                    'task1',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  Text(
                    'task1 description',
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
