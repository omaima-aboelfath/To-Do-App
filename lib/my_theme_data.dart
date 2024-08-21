import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:to_do_app/app_colors.dart';

/*
const => بكتبها لو انا عارفة القيمة بتاعتها وقت  compile time 
final => لو انا مش عارفة القيمة بتاعتها الا وقت run time
----
MediaQuery => use it to fit on all screen sizes on height or width
height of screen = 870
height of app bar = 157
ratio of mediaQuery = 157 / 870 = 0.18
*/
class MyThemeData {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundLightColor,

    // styling all screens with app bar on the theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      // toolbarHeight: 130
    ),

    // styling the text on the app bar
    textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
        // styling the text on the settings tabs
        bodyMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColor,
        ),
        displaySmall: GoogleFonts.inter(
            fontSize: 17, fontWeight: FontWeight.w400, color: Colors.grey)),

    // styling the navigation bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.greyColor,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        elevation: 0),

    // styling the floating button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        shape: StadiumBorder(
            side: BorderSide(color: AppColors.whiteColor, width: 5))
        // OR
        // shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(30),
        //       side: BorderSide(
        //         color: AppColors.whiteColor,
        //         width: 5))
        ),

    // styling the bottom sheet
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
    )),
  );

///////////////////////////////////////////////////////

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.backgroundDarkColor,
    // styling all screens with app bar on the theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryColor,
      elevation: 0,
      // toolbarHeight: 130
    ),

    // styling the text on the theme
    textTheme: TextTheme(
        bodyLarge: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.blackDarkColor,
        ),
        // styling the text on the settings tabs
        bodyMedium: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColor,
        ),
        displaySmall: GoogleFonts.inter(
            fontSize: 17, fontWeight: FontWeight.w400, color: Colors.grey)),

    // styling the navigation bar
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.greyColor,
        showUnselectedLabels: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        ),

    // styling the floating button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        shape: StadiumBorder(
            side: BorderSide(color: AppColors.blackDarkColor, width: 5))
        // OR
        // shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(30),
        //       side: BorderSide(
        //         color: AppColors.whiteColor,
        //         width: 5))
        ),

    // styling the bottom sheet
    bottomSheetTheme: BottomSheetThemeData(
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15), topRight: Radius.circular(15)),
    )),

  );
}
