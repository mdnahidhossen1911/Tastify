import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../res/component/food_recipe_widget.dart';
import '../../../../view_model/get_recipe_view_model.dart';
import '../../../auth/ui/controller/auth_controller.dart';
import '../../../favourite/ui/controller/favourite_toggle_controller.dart';

class PopularListScreen extends StatefulWidget {
  const PopularListScreen({super.key});

  static const String name = '/popular-list-screen';

  @override
  State<PopularListScreen> createState() => _PopularListScreenState();
}

class _PopularListScreenState extends State<PopularListScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('Popular', style: textTheme.headlineSmall),
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
                      FavouriteToggleController.toggleFavourite(
                        value.recipes[index]['id'],
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
