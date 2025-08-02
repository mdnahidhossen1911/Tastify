import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tastify/service_locator.dart';

import '../../../../view_model/carousel_image_view_model.dart';
import '../../../../view_model/fetch_popular_view_model.dart';
import '../../../../view_model/get_recipe_view_model.dart';
import '../../../auth/ui/controller/auth_controller.dart';
import '../../../blog/blog_screen.dart';
import '../../../category/controller/category_controller.dart';
import '../../../favourite/ui/screens/favourite_screen.dart';
import '../../../home/ui/screens/home_screen.dart';
import '../../../profile/ui/screens/profile_screen.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  static const String name = '/main-bottom-nav-bar';

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedIndex = 0;

  late GetRecipeViewModel _getRecipeViewModel;

  final List<Widget> _screens = [
    Home(),
    BlogScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      locator<CarouselImageViewModel>().getImage();
      Get.find<CategoryController>().getCategory();
      _getRecipeViewModel.getAllRecipes(AuthController.uid ?? '');
      locator<FetchPopularViewModel>().getAllRecipes(AuthController.uid ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    _getRecipeViewModel = Provider.of<GetRecipeViewModel>(
      context,
      listen: false,
    );
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
