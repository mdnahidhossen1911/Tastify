import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tastify/res/theme/theme_changer.dart';
import 'package:tastify/view/profile/ui/screens/profile_edit_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/assets_path.dart';
import '../../../auth/ui/controller/auth_controller.dart';
import '../../../auth/ui/screen/login_screen.dart';
import '../../../feedback/ui/screens/recipe_feedback.dart';
import 'change_password_screen.dart';
import 'my_recipe_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    // TODO: implement initState
    dataUpdate();
    super.initState();
  }

  dataUpdate() async {
    await _authController.getData();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text('Profile', style: textTheme.headlineSmall)),
      body: Column(
        children: [
          SizedBox(height: 16),
          _buildHeader(),
          SizedBox(height: 16),
          ListTile(
            leading: Icon(Icons.nights_stay_outlined, size: 28),
            iconColor: Colors.grey.shade700,
            titleTextStyle: _buildTextStyle(),
            title: Text('Night mode'),
            trailing: Consumer<ThemeChanger>(
              builder: (context, value, child) {
                return Switch(
                  value: value.values,
                  activeColor: Colors.deepOrange,
                  activeTrackColor: Colors.deepOrange.shade100,
                  inactiveThumbColor: Colors.grey.shade400,
                  inactiveTrackColor: Colors.grey.shade200,
                  trackOutlineColor: WidgetStateProperty.all(
                    Colors.transparent,
                  ),
                  onChanged: (mode) {
                    value.change(mode);
                  },
                );
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_outline, size: 28),
            title: Text('Profile edit'),
            onTap: () {
              Navigator.pushNamed(context, ProfileEditScreen.name);
            },
            iconColor: Colors.grey.shade700,
            titleTextStyle: _buildTextStyle(),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            leading: Icon(Icons.lock_open_rounded, size: 28),
            title: Text('Change password'),
            iconColor: Colors.grey.shade700,
            titleTextStyle: _buildTextStyle(),
            onTap: () {
              Navigator.pushNamed(
                context,
                ChangePasswordScreen.name,
                arguments: _authController.getGmail,
              );
            },
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            leading: Icon(Icons.restaurant_outlined, size: 28),
            title: Text('My Recipes'),
            iconColor: Colors.grey.shade700,
            titleTextStyle: _buildTextStyle(),
            onTap: () {
              Navigator.pushNamed(context, MyRecipeScreen.name);
            },
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            leading: Icon(Icons.feedback_outlined, size: 28),
            title: Text('Recipe feedback'),
            iconColor: Colors.grey.shade700,
            titleTextStyle: _buildTextStyle(),
            onTap: () {
              Navigator.pushNamed(context, RecipeFeedbackScreen.name);
            },
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined, size: 28),
            title: Text('Logout'),
            iconColor: Colors.grey.shade700,
            titleTextStyle: _buildTextStyle(),
            onTap: () async {
              // Handle logout action
              await AuthController().logOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                LoginScreen.name,
                (route) => false,
              );
            },
          ),
          SizedBox(height: 4),
          _buildHelpButton(),
        ],
      ),
    );
  }

  GestureDetector _buildHelpButton() {
    return GestureDetector(
      onTap: contactTastifySupport,
      child: Container(
        margin: EdgeInsets.all(18),
        padding: EdgeInsets.symmetric(horizontal: 25),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.deepOrange.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              Icons.mark_email_unread_outlined,
              size: 36,
              color: AppColor.themeColor,
            ),
            SizedBox(width: 20),
            Text(
              'How can we help you?',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _buildTextStyle() => TextStyle(
    color: Colors.grey.shade800,
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  Widget _buildHeader() {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: GetBuilder(
        init: _authController,
        builder: (controller) {
          return Row(
            children: [
              DottedBorder(
                options: CircularDottedBorderOptions(
                  padding: const EdgeInsets.all(0),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.deepOrange.shade300,
                      Colors.deepOrange.shade200,
                    ],
                  ),
                  strokeWidth: 2.8,
                  dashPattern: [13, 4],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.memory(
                        base64Decode(controller.getPhoto),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AssetsPath.profileImagePNG,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.getUserName, style: textTheme.titleLarge),
                  Text(
                    controller.getGmail,
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  void contactTastifySupport() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'md.nahidhossen1911@gmail.com',
      query: Uri.encodeFull(
        'subject=Help with Tastify App&body=Hey Tastify team',
      ),
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch email client';
    }
  }
}
