import 'package:flutter/material.dart';
import 'package:get/get.dart' show GetBuilder;

import '../../../../res/component/food_recipe_widget.dart';
import '../../../auth/ui/controller/auth_controller.dart';
import '../../../favourite/ui/controller/favourite_toggle_controller.dart';
import '../../../recipe/ui/controller/get_recipe_controller.dart';

class PopularListScreen extends StatefulWidget {
  const PopularListScreen({super.key});

  static const String name = '/popular-list-screen';

  @override
  State<PopularListScreen> createState() => _PopularListScreenState();
}

class _PopularListScreenState extends State<PopularListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title: Text('Popular'),
      ),
      body: SafeArea(
        child: GetBuilder<GetRecipeController>(
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.recipes.length,
              padding: EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FoodRecipeWidget(
                    recipeDetails: controller.recipes[index],
                    onTap: () {
                      FavouriteToggleController.toggleFavourite(
                        controller.recipes[index]['id'],
                        AuthController.uid!,
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
