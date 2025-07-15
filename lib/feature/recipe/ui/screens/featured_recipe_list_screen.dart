import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/feature/common/ui/widget/food_recipe_widget.dart';
import 'package:tastify/feature/recipe/ui/controller/get_recipe_controller.dart';

import '../../../auth/ui/controller/auth_controller.dart';
import '../../../favourite/ui/controller/favourite_toggle_controller.dart';

class FeaturedRecipeListScreen extends StatefulWidget {
  const FeaturedRecipeListScreen({super.key});

  static const String name='/featured-recipe-screen';

  @override
  State<FeaturedRecipeListScreen> createState() => _FeaturedRecipeListScreenState();
}

class _FeaturedRecipeListScreenState extends State<FeaturedRecipeListScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title: Text('Featured Recipe'),
      ),
      body: SafeArea(
        child:  GetBuilder<GetRecipeController>(
            builder: (controller) {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: controller.recipes.length,
                padding: EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: FoodRecipeWidget(recipeDetails: controller.recipes[index],
                    onTap: () {
                      FavouriteToggleController.toggleFavourite(controller.recipes[index]['id'], AuthController.uid!);
                    },
                    ),
                  );
                },
              );
            }
        )
      ),
    );
  }
}
