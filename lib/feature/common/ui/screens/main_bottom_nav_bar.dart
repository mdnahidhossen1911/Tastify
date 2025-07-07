import 'package:flutter/material.dart';
import 'package:tastify/feature/blog/ui/screens/blog_screen.dart';
import 'package:tastify/feature/favourite/ui/screens/favourite_screen.dart';
import 'package:tastify/feature/home/ui/screens/home.dart';
import 'package:tastify/feature/profile/ui/screens/profile_screen.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  static const String name='/main-bottom-nav-bar';

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedIndex=0;
  List<Widget> _screens=[
    Home(),
    BlogScreen(),
    FavouriteScreen(),
    ProfileScreen(),
  ];
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
            color: Colors.grey.withOpacity(0.3),
          ),
          NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (index){
              _selectedIndex=index;
              print(_selectedIndex);
              setState(() {});
            },
            destinations: [
              NavigationDestination(icon: Icon(Icons.home), label: 'home'),
              NavigationDestination(icon: Icon(Icons.newspaper), label: 'Blog'),
              NavigationDestination(icon: Icon(Icons.favorite_outlined), label: 'Favourite'),
              NavigationDestination(icon: Icon(Icons.account_box_outlined), label: 'Profile'),
            ],
            backgroundColor: Colors.white,
            //indicatorColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}
