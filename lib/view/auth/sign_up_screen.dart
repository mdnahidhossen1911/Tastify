import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/service_locator.dart';
import 'package:tastify/view_model/view_models.dart';

import '../../model/auth_user_model.dart';
import '../../model/network_response.dart';
import '../../model/user_model.dart';
import '../../res/app_colors.dart';
import '../../res/assets_path.dart';
import '../../res/component/circle_progress.dart';
import '../../res/component/screen_background.dart';
import '../../utils/utils.dart';
import '../main_bottom_nav_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static String name = 'signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late GoogleSignViewModel _googleSignController;

  final SignupViewModel _signupViewModel = locator<SignupViewModel>();

  @override
  Widget build(BuildContext context) {
    _googleSignController = Provider.of<GoogleSignViewModel>(
      context,
      listen: false,
    );
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 62),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        color: AppColor.themeColor,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Name",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: nameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "username",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "username@example.com",
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                          r'^[^@]+@[^@]+\.[^@]+',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "*****************",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 12),
                    Text(
                      "Confirm Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "*****************",
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 26),
                    _buildSignUpButton(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: AppColor.themeColor,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 34),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade600)),
                          SizedBox(width: 10),
                          Text("Sign in with"),
                          SizedBox(width: 10),
                          Expanded(child: Divider(color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    _buildGoogleSignINButton(),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return ChangeNotifierProvider(
      create: (context) => _signupViewModel,
      child: Consumer<SignupViewModel>(
        builder: (context, value, child) {
          return Visibility(
            visible: !value.isLoading,
            replacement: circleProgress(),
            child: Center(
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    ///Need to put profile page Navigation
                    onClickSignUp();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.themeColor,
                    elevation: 0,
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Center _buildGoogleSignINButton() {
    return Center(
      child: Consumer<GoogleSignViewModel>(
        builder: (context, value, child) {
          return Visibility(
            visible: !value.isLoading,
            replacement: circleProgress(),
            child: SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: Image.asset(AssetsPath.googleLogoPNG, width: 24),
                onPressed: () {
                  googleSignIn();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Color(0xff565656), width: 0.6),
                  elevation: 0,
                ),
                label: Text(
                  "Continue with Goodle",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  onClickSignUp() async {
    if (formKey.currentState!.validate()) {
      UserModel user = UserModel(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      NetworkResponse response = await _signupViewModel.registerUser(user);
      if (response.isSuccess) {
        await AuthViewModel().saveData(
          response.responseData!['id'],
          AuthUserModel.fromJson(response.responseData!),
        );
        Utils.showToast(
          "Sign Up ${response.responseData!['email']} successfully",
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          MainBottomNavBar.name,
          (route) => false,
        );
      } else {
        Utils.showFlushBar(context, response.errorMessage);
      }
    }
  }

  googleSignIn() async {
    NetworkResponse response = await _googleSignController.signInWithGoogle();
    if (response.isSuccess) {
      print("Google Sign-In Success: ${response.responseData}");
      await AuthViewModel().saveData(
        response.responseData!['id'],
        AuthUserModel.fromJson(response.responseData!),
      );
      Navigator.pushReplacementNamed(context, MainBottomNavBar.name);
    } else {
      print("Google Sign-In Error: ${response.errorMessage}");
      Utils.showFlushBar(context, response.errorMessage);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
