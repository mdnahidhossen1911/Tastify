import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/service_locator.dart';
import 'package:tastify/view/views.dart';
import 'package:tastify/view_model/view_models.dart';

class MainBottomNavBarView extends StatefulWidget {
  const MainBottomNavBarView({super.key});

  static const String name = '/main-bottom-nav-bar';

  @override
  State<MainBottomNavBarView> createState() => _MainBottomNavBarViewState();
}

class _MainBottomNavBarViewState extends State<MainBottomNavBarView> {
  int _selectedIndex = 0;

  late GetRecipeViewModel _getRecipeViewModel;

  final List<Widget> _screens = [
    HomeView(),
    BlogListView(),
    FavouriteView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      locator<CarouselImageViewModel>().getImage();
      locator<CategoryViewModel>().getCategory();
      _getRecipeViewModel.getAllRecipes(AuthViewModel.uid ?? '');
      locator<FetchPopularViewModel>().getAllRecipes(AuthViewModel.uid ?? '');
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
