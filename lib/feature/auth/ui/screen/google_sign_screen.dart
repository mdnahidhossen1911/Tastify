import 'package:flutter/material.dart';
import 'package:tastify/core/network_response.dart';
import 'package:tastify/feature/recipe/ui/controller/recipe_controller.dart';

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
      body: Center(child: ElevatedButton(onPressed: () async {

       NetworkResponse data = await RecipeController.getAllRecipes('00eb5dfd-9d07-4754-bae3-47e1dd0cc8cd');
       print(data.responseData);

      }, child: Text('sign in')),),
    );
  }
}
