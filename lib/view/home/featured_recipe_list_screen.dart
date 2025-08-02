import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/view_model/view_models.dart';

import '../../res/component/food_recipe_widget.dart';

class FeaturedRecipeListScreen extends StatefulWidget {
  const FeaturedRecipeListScreen({super.key});

  static const String name = '/featured-recipe-screen';

  @override
  State<FeaturedRecipeListScreen> createState() =>
      _FeaturedRecipeListScreenState();
}

class _FeaturedRecipeListScreenState extends State<FeaturedRecipeListScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('Featured Recipe', style: textTheme.headlineSmall),
      ),
      body: SafeArea(
        child: Consumer<GetRecipeViewModel>(
          builder: (context, value, child) {
            return ListView.builder(
              itemCount: value.recipes.length,
              padding: EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FoodRecipeWidget(
                    recipeDetails: value.recipes[index],
                    onTap: () {
                      FavouriteToggleViewModel.toggleFavourite(
                        value.recipes[index]['id'],
                        AuthViewModel.uid!,
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
