import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/core/utils/circle_progress.dart';
import 'package:tastify/feature/auth/ui/controller/auth_controller.dart';
import 'package:tastify/feature/common/ui/widget/food_recipe_widget.dart';
import 'package:tastify/feature/favourite/ui/controller/favourite_toggle_controller.dart';
import 'package:tastify/feature/favourite/ui/controller/favourite_controller.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final GetFavouriteController getFavouriteController =
      GetFavouriteController();

  initState() {
    super.initState();
    getFavouriteController.FavouriteRecipes(AuthController.uid??'');
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Text('Favourite', style: textTheme.titleLarge),
      ),
      body: SafeArea(
        child: GetBuilder(
          init: getFavouriteController,
          builder: (controller) {
            return controller.isLoading
                ? circleProgress()
                : ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.favouriteRecipes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: FoodRecipeWidget(
                        recipeDetails: controller.favouriteRecipes[index],
                        onTap: () {
                          FavouriteToggleController.toggleFavourite(
                            controller.favouriteRecipes[index]['id'],
                            AuthController.uid!,
                          );
                          controller.removeFavourite(
                            controller.favouriteRecipes[index]['id'],
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
