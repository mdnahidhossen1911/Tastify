import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/service_locator.dart';

import '../../res/component/circle_progress.dart';
import '../../res/component/food_recipe_widget.dart';
import '../../view_model/auth_view_model.dart';
import '../../view_model/favourite_toggle_controller.dart';
import '../../view_model/favourite_view_model.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final GetFavouriteViewModel _getFavouriteViewModel =
      locator<GetFavouriteViewModel>();

  @override
  initState() {
    super.initState();
    _getFavouriteViewModel.FavouriteRecipes(AuthViewModel.uid ?? '');
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
        child: ChangeNotifierProvider(
          create: (context) => _getFavouriteViewModel,
          child: Consumer<GetFavouriteViewModel>(
            builder: (context, value, child) {
              return value.isLoading
                  ? circleProgress()
                  : ListView.builder(
                    itemCount: value.favouriteRecipes.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: FoodRecipeWidget(
                          recipeDetails: value.favouriteRecipes[index],
                          onTap: () {
                            FavouriteToggleViewModel.toggleFavourite(
                              value.favouriteRecipes[index]['id'],
                              AuthViewModel.uid!,
                            );
                            value.removeFavourite(
                              value.favouriteRecipes[index]['id'],
                            );
                          },
                        ),
                      );
                    },
                  );
            },
          ),
        ),
      ),
    );
  }
}
