import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';

// create new type of function
typedef MyValidator = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  String label;
  TextEditingController controller; // to save what the user write
  TextInputType keyboardType; // optional in constructor
  bool obscureText; // input is visible or not, false => visible
  MyValidator validator; // make sure all fields are written in it
  // OR String? Function(String?) validator;
  Widget? suffixIcon;


  CustomTextFormField(
      {required this.label,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      required this.validator,
      this.suffixIcon = null});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.displaySmall,
          suffixIcon: suffixIcon,
          // not pressed
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.primaryColor)),
          // on pressed
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.primaryColor)),
          // on error but not presses
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.redColor)),
          // on error but pressed
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.redColor)),
        ),
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.whiteColor
              : AppColors.blackColor,
        ),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        
      ),
    );
  }
}
