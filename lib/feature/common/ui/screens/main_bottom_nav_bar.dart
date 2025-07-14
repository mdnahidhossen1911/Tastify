import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/feature/auth/ui/controller/auth_controller.dart';
import 'package:tastify/feature/blog/ui/screens/blog_screen.dart';
import 'package:tastify/feature/category/controller/category_controller.dart';
import 'package:tastify/feature/favourite/ui/screens/favourite_screen.dart';
import 'package:tastify/feature/home/ui/controller/carousel_image_controller.dart';
import 'package:tastify/feature/home/ui/screens/home.dart';
import 'package:tastify/feature/profile/ui/screens/profile_screen.dart';
import 'package:tastify/feature/recipe/ui/controller/get_recipe_controller.dart';
import 'package:tastify/feature/recipe/ui/controller/recipe_controller.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  static const String name='/main-bottom-nav-bar';

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedIndex=0;
  final List<Widget> _screens=[
    Home(),
    BlogScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];


  @override
  void initState() {
    // TODO: implement initState
    Get.find<CarouselImageController>().getImage();
    Get.find<CategoryController>().getCategory();
    Get.find<GetRecipeController>().getAllRecipes(AuthController.uid??'');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.withOpacity(0.04),
          ),
          NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index){
              _selectedIndex=index;
              setState(() {});
            },
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.newspaper), label: 'Blog'),
              NavigationDestination(icon: Icon(Icons.favorite_outlined), label: 'Favourite'),
              NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            ],
            backgroundColor: Colors.white,
            //indicatorColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}
