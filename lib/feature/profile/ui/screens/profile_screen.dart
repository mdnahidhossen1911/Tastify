import 'package:flutter/material.dart';
import 'package:tastify/app/app_colors.dart';
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
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Profile',style: textTheme.titleLarge,),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.account_circle_outlined,size: 45,),
                    /*CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(AssetsPath.profileImagePNG),
                    ),*/
                    SizedBox(width: 8,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('MD Nahid Hossen',style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        ),),
                        Text('nahidhossen.mail@gmail.com',style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12
                        ),)
                      ],
                    )
                  ],
                ),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey.shade200,
                  child: Icon(Icons.person_add_alt,size: 30,),
                )
              ],
            ),
            SizedBox(height: 16,),
            Padding(
              padding: EdgeInsets.only(left: 8,right: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, MyRecipeScreen.name);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.restaurant_menu,size: 30,color: AppColor.themeColor,),
                          SizedBox(width: 10,),
                          Text('My Recipe',style: TextStyle(
                              color: AppColor.themeColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.orange.shade50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RecipeFeedback.name);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.restaurant,size: 30,color: AppColor.themeColor,),
                          SizedBox(width: 10,),
                          Text('Recipe Feedback',style: TextStyle(
                              color: AppColor.themeColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                          ),)
                        ],
                      ),
                    ),
                  ),
                  Divider(color: Colors.orange.shade50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.lock_open,size: 30,color: AppColor.themeColor,),
                        SizedBox(width: 10,),
                        Text('Changed Password',style: TextStyle(
                            color: AppColor.themeColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),
                  Divider(color: Colors.orange.shade50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.privacy_tip,size: 30,color: AppColor.themeColor,),
                        SizedBox(width: 10,),
                        Text('Privacy & Policy',style: TextStyle(
                            color: AppColor.themeColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),
                  Divider(color: Colors.orange.shade50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(Icons.info,size: 30,color: AppColor.themeColor,),
                        SizedBox(width: 10,),
                        Text('About',style: TextStyle(
                            color: AppColor.themeColor,
                            fontSize: 17,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                  ),
                  Divider(color: Colors.orange.shade50,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: GestureDetector(
                      onTap: () {
                        AuthController.logOut();
                        Navigator.pushNamedAndRemoveUntil(context, LoginScreen.name, (route) => false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.logout,size: 30,color: AppColor.themeColor,),
                              SizedBox(width: 10,),
                              Text('Logout',style: TextStyle(
                                  color: AppColor.themeColor,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          ),
                          Icon(Icons.arrow_forward_ios,size: 30,color: AppColor.themeColor,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
