import 'package:flutter/material.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/feature/category/controller/category_controller.dart';
import 'package:tastify/feature/favourite/ui/controller/favourite_controller.dart';

class GoogleSignScreen extends StatefulWidget {
  const GoogleSignScreen({super.key});

  @override
  State<GoogleSignScreen> createState() => _GoogleSignScreenState();
}

class _GoogleSignScreenState extends State<GoogleSignScreen> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google sign'),),
      body: Center(child: Column(
        children: [
          ElevatedButton(onPressed: () async {

           NetworkResponse data = await FavouriteController.getFavouriteRecipes('00eb5dfd-9d07-4754-bae3-47e1dd0cc8cd');
           print(data.responseData);

          }, child: Text('sign in')),

          ElevatedButton(onPressed: () async {

            NetworkResponse data = await CategoryController.getRecipesByCategory('', '54207fee-1d13-41f6-9f8a-72bbca54e18d');
            print(data.responseData);

          }, child: Text('toggle')),
        ],
      ),),
    );
  }
}
