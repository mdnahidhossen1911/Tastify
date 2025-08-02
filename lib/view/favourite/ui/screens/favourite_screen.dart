import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/component/circle_progress.dart';
import '../../../../res/component/food_recipe_widget.dart';
import '../../../../view_model/auth_view_model.dart';
import '../controller/favourite_controller.dart';
import '../controller/favourite_toggle_controller.dart';

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
    getFavouriteController.FavouriteRecipes(AuthViewModel.uid ?? '');
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('Favourite', style: textTheme.headlineSmall),
      ),
      body: SafeArea(
        child: GetBuilder(
          init: getFavouriteController,
          builder: (controller) {
            return controller.isLoading
                ? circleProgress()
                : ListView.builder(
                  itemCount: controller.favouriteRecipes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: FoodRecipeWidget(
                        recipeDetails: controller.favouriteRecipes[index],
                        onTap: () {
                          FavouriteToggleController.toggleFavourite(
                            controller.favouriteRecipes[index]['id'],
                            AuthViewModel.uid!,
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
