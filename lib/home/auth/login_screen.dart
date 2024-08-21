import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/app_colors.dart';
import 'package:to_do_app/home/auth/custom_text_form_field.dart';
import 'package:to_do_app/home/auth/register_screen.dart';
import 'package:to_do_app/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>(); // to access data of form
  bool _obscurePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: Theme.of(context).textTheme.bodyLarge),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(70),
                        child: Text(
                          'Welcome Back!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.primaryColor)),
                            onPressed: () {
                              // ensure that everything is written and right
                              login();
                            },
                            child: Text(
                              'Login',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegisterScreen.routeName);
                            },
                            child: Text(
                              'or Create Account',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void login() async {
    // loop on every validator in text form field and see if its valid or not
    // if return null => valid = true
    if (formKey.currentState?.validate() == true) {
      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        print("Login Successfully");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login successfully'),
            backgroundColor: AppColors.greenColor,
          ),
        );
        Navigator.pushNamed(context, HomeScreen.routeName);
        // print user id and if not found print null
        print(credential.user?.uid ?? "");
        // }
        // on FirebaseAuthException catch (e) {
        //   if (e.code == 'user-not-found') {
        //     print('No user found for that email.');
        //   } else if (e.code == 'wrong-password') {
        //     print('Wrong password provided for that user.');
        // }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'The supplied auth credential is incorrect, malformed or has expired.'),
                backgroundColor: AppColors.redColor),
          );
          print(
              'The supplied auth credential is incorrect, malformed or has expired.');
        }
      } catch (e) {
        print(e
            .toString()); // print the string of exception that not specified above
      }
    }
  }
}
