import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/home/auth/login_screen.dart';
import 'package:to_do_app/home/settings/settings_tab.dart';
import 'package:to_do_app/home/task_list/add_task_bottom_sheet.dart';
import 'package:to_do_app/home/task_list/task_list_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_app/providers/user_provider.dart';

import '../providers/list_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var listProvider = Provider.of<ListProvider>(context);
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Text(
          selectedIndex == 0
              ? "${AppLocalizations.of(context)!.app_title} (${userProvider.currentUser?.name})"
              : AppLocalizations.of(context)!.settings,
          // selectedIndex == 0 ? 'To Do List' : 'Settings',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          IconButton(
              onPressed: () {
                // listProvider.tasksList = null ; // if it was nullable list
                // to remove task list of previous user on current user
                listProvider.tasksList = [];
                // userProvider.currentUser = null; // not important bcz we update user on login and register
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.routeName);
              },
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.blackDarkColor
                    : AppColors.whiteColor,
              ))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.blackDarkColor
            : AppColors.whiteColor,
        child: BottomNavigationBar(
            currentIndex:
                selectedIndex, // to define which selected and which not
            // to change selected index depending on what the user tap on
            onTap: (index) {
              // to get index and identify which one selected
              selectedIndex = index;
              setState(() {
                // to change the button on screen
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/list_icon.png'),
                    size: 20,
                  ),
                  label: AppLocalizations.of(context)!.task_list
                  // label: 'Task List',
                  ),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/settings_icon.png'),
                    size: 20,
                  ),
                  label: AppLocalizations.of(context)!.settings
                  //  label: 'Settings'
                  ),
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 30,
          color: AppColors.whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: selectedIndex == 0
          ? TaskListTab()
          : SettingsTab(), // conditional operator
    );
  }

  void showAddTaskBottomSheet() {
    // create new bottom sheet
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }

  // if we have more than 2 items in bottom navigation bar:
  // List<Widget> tabs = [TaskListTab(), SettingsTab()];
  // and then
  // body: tabs[selectedIndex]
  // if selectedIndex is 0 => show task list tab
  // and if selectedIndex is 1 => show settings tab
}
