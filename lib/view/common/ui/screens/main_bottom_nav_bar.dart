import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth/ui/controller/auth_controller.dart';
import '../../../blog/blog_screen.dart';
import '../../../category/controller/category_controller.dart';
import '../../../favourite/ui/screens/favourite_screen.dart';
import '../../../home/ui/controller/carousel_image_controller.dart';
import '../../../home/ui/controller/fetch_popular_item_controller.dart';
import '../../../home/ui/screens/home_screen.dart';
import '../../../profile/ui/screens/profile_screen.dart';
import '../../../recipe/ui/controller/get_recipe_controller.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  static const String name = '/main-bottom-nav-bar';

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
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
    Get.find<GetRecipeController>().getAllRecipes(AuthController.uid ?? '');
    Get.find<FetchPopularItemController>().getAllRecipes(
      AuthController.uid ?? '',
    );
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
            onDestinationSelected: (index) {
              _selectedIndex = index;
              setState(() {});
            },
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
              NavigationDestination(icon: Icon(Icons.newspaper), label: 'Blog'),
              NavigationDestination(
                icon: Icon(Icons.favorite_outlined),
                label: 'Favourite',
              ),
              NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            ],
          ),
        ],
      ),
    );
  }
}
