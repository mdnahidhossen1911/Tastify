import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/view/auth/ui/screen/sign_up_screen.dart';

import '../../../../model/auth_user_model.dart';
import '../../../../model/network_response.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/assets_path.dart';
import '../../../../res/component/circle_progress.dart';
import '../../../../res/component/screen_background.dart';
import '../../../../utils/utils.dart';
import '../../../common/ui/screens/main_bottom_nav_bar.dart';
import '../controller/auth_controller.dart';
import '../controller/google_sign_controller.dart';
import '../controller/login_controller.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String name = 'loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _SignInFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final LoginController _loginController = Get.find<LoginController>();
  final GoogleSignController _googleSignController =
      Get.find<GoogleSignController>();

  RxBool passwordInVisible = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Form(
                key: _SignInFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 70),
                    Text(
                      "Welcome to",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        height: 1,
                      ),
                    ),
                    Text(
                      "Tastify",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 40,
                        color: AppColor.themeColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "A smart space to explore, share, and manage your favorite recipes.",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: "username@example.com",
                      ),
                      keyboardType: TextInputType.emailAddress,
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
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Obx(
                      () => TextFormField(
                        obscureText: passwordInVisible.value,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: "*****************",
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (passwordInVisible.value) {
                                passwordInVisible.value = false;
                              } else {
                                passwordInVisible.value = true;
                              }
                            },
                            icon:
                                passwordInVisible.value == false
                                    ? Icon(
                                      CupertinoIcons.eye_slash,
                                      color: Colors.grey.shade400,
                                    )
                                    : Icon(
                                      CupertinoIcons.eye,
                                      color: Colors.grey.shade400,
                                    ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            ForgotPasswordScreen.name,
                          );
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                            color: AppColor.themeColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    _buildLoginButon(),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?  ",
                          style: TextStyle(color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, SignUpScreen.name);
                          },
                          child: Text(
                            "Sign Up",
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
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center _buildGoogleSignINButton() {
    return Center(
      child: GetBuilder(
        init: _googleSignController,
        builder: (controller) {
          return Visibility(
            visible: !controller.isLoading,
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

  Center _buildLoginButon() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: GetBuilder(
          init: _loginController,
          builder: (controller) {
            return Visibility(
              visible: !controller.isLoading,
              replacement: circleProgress(),
              child: ElevatedButton(
                onPressed: () {
                  onClickLoginButton();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.themeColor,
                  elevation: 0,
                ),
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  googleSignIn() async {
    NetworkResponse response = await _googleSignController.signInWithGoogle();
    if (response.isSuccess) {
      print("Google Sign-In Success: ${response.responseData}");
      await AuthController().saveData(
        response.responseData!['id'],
        AuthUserModel.fromJson(response.responseData!),
      );
      Navigator.pushReplacementNamed(context, MainBottomNavBar.name);
    } else {
      print("Google Sign-In Error: ${response.errorMessage}");
      Utils.showFlushBar(context, response.errorMessage);
    }
  }

  onClickLoginButton() async {
    if (_SignInFormKey.currentState!.validate()) {
      NetworkResponse response = await _loginController.loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (response.isSuccess) {
        print("Login Success: ${response.responseData}");
        await AuthController().saveData(
          response.responseData!['id'],
          AuthUserModel.fromJson(response.responseData!),
        );
        Navigator.pushReplacementNamed(context, MainBottomNavBar.name);
      } else {
        print("Login Error: ${response.errorMessage}");
        Utils.showFlushBar(context, response.errorMessage);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
