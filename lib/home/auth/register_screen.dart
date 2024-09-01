import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/dialog_utils.dart';
import 'package:to_do_app/firebase_utils.dart';
import 'package:to_do_app/home/auth/custom_text_form_field.dart';
import 'package:to_do_app/home/auth/login_screen.dart';
import 'package:to_do_app/home/home_screen.dart';
import 'package:to_do_app/model/my_user.dart';
import 'package:to_do_app/providers/user_provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register_screen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  var formKey = GlobalKey<FormState>(); // to access data of form
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Account',
            style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomTextFormField(
                        label: 'User Name',
                        controller: nameController,
                        // call back function
                        validator: (text) {
                          // trim => remove space before & after string
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter user name'; // invalid
                          }
                          return null; // valid
                        },
                      ),
                      CustomTextFormField(
                        label: 'Email',
                        controller: emailController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter email'; // invalid
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(emailController.text);
                          // if email not valid
                          if (!emailValid) {
                            return 'Please enter valid email';
                          }
                          return null; // valid
                        },
                        keyboardType: TextInputType.emailAddress,
                      ),
                      CustomTextFormField(
                        label: 'Password',
                        controller: passwordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter password'; // invalid
                          }
                          if (text.length < 6) {
                            return 'Password must be at least 6 digits';
                          }
                          return null; // valid
                        },
                        keyboardType: TextInputType.number,
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                            onPressed: _togglePasswordVisibility,
                            icon: _obscurePassword
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                      ),
                      CustomTextFormField(
                        label: 'Confirm Password',
                        controller: confirmPasswordController,
                        validator: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please enter the same password'; // invalid
                          }
                          if (text.length < 6) {
                            return 'Password must be at least 6 digits';
                          }
                          if (confirmPasswordController.text !=
                              passwordController.text) {
                            return "Confirm password dosen't match password";
                          }
                          return null; // valid
                        },
                        keyboardType: TextInputType.number,
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                            onPressed: _toggleConfirmPasswordVisibility,
                            icon: _obscureConfirmPassword
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility)),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.primaryColor)),
                            onPressed: () {
                              // ensure that everything is written and right
                              register();
                            },
                            child: Text(
                              'Create Account',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ))
                    ],
                  )),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.routeName);
                    },
                    child: Text(
                      'Already have an account? Login',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    // loop on every validator in text form field and see if its valid or not
    // if return null => valid = true
    if (formKey.currentState?.validate() == true) {
      //todo: show loading
      DialogUtils.showLoading(
          context: context,
          loadingLabel: 'Loading...',
          barrierDismissible: false);
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        MyUser myUser = MyUser(
            id: credential.user?.uid ?? '',
            name: nameController.text,
            email: emailController.text);
        print('before database');
        await FirebaseUtils.addUserToFireStore(myUser);
        print('after database');
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(myUser);
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //show message
        DialogUtils.showMessage(
          context: context,
          message: 'Register Successfully',
          posAction: () {
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          },
          posActionName: 'Ok',
          title: 'Success',
        );
        print("Register Successfully");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text('Register successfully'),
        //     backgroundColor: AppColors.greenColor,
        //   ),
        // );
        print(credential.user?.uid ?? "");
        // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        // if (e.code == 'weak-password') {
        //   print('The password provided is too weak.');
        // } else
        // compare between code of error exception(e) with string that specified by FirebaseAuthException
        if (e.code == 'email-already-in-use') {
          //todo: hide loading
          DialogUtils.hideLoading(context);
          //show message
          DialogUtils.showMessage(
              context: context,
              message: 'The account already exists for that email.',
              title: 'Error',
              posActionName: 'Ok');
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text('The account already exists for that email.'),
          //     backgroundColor: AppColors.redColor,
          //   ),
          // );
          print('The account already exists for that email.');
        }
      } catch (e) {
        //todo: hide loading
        DialogUtils.hideLoading(context);
        //show message
        DialogUtils.showMessage(
            context: context,
            message: e.toString(),
            title: 'Error',
            posActionName: 'Ok');
        print(e);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(e.toString()),
        //     backgroundColor: AppColors.redColor,
        //   ),
        // );
      }
    }
  }
}
