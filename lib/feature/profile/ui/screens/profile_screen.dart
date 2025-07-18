import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/app/assets_path.dart';
import 'package:tastify/feature/auth/ui/controller/auth_controller.dart';
import 'package:tastify/feature/auth/ui/screen/login_screen.dart';
import 'package:tastify/feature/feedback/ui/screens/recipe_feedback.dart';
import 'package:tastify/feature/profile/ui/screens/my_recipe_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Profile', style: textTheme.titleLarge),
      ),
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
            trailing: Switch(
              value: isDarkMode,
              activeColor: Colors.deepOrange,
              activeTrackColor: Colors.deepOrange.shade100,
              inactiveThumbColor: Colors.grey.shade400,
              inactiveTrackColor: Colors.grey.shade200,
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
              onChanged: (value) {
                isDarkMode = value;
                setState(() {});
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.person_outline, size: 28),
            title: Text('Profile edit'),
            onTap: () {},
            iconColor: Colors.grey.shade700,
            titleTextStyle: _buildTextStyle(),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            leading: Icon(Icons.lock_open_rounded, size: 28),
            title: Text('Change password'),
            iconColor: Colors.grey.shade700,
            titleTextStyle: _buildTextStyle(),
            onTap: () {},
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
              await AuthController.logOut();
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
      onTap: () {},
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
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
            child: CircleAvatar(
              radius: 32,
              backgroundColor: Colors.transparent,
              child: Image.asset(AssetsPath.profileImagePNG, fit: BoxFit.cover),
            ),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthController.userModel?.fullName??'unknown',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                AuthController.userModel?.email??'unknown@gmail.com',
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
