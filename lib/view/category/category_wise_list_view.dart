import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/service_locator.dart';
import 'package:tastify/view_model/view_models.dart';

import '../../res/component/circle_progress.dart';
import '../../res/component/food_recipe_widget.dart';

class CategoryWiseListView extends StatefulWidget {
  const CategoryWiseListView({super.key, required this.categoryName});

  final String categoryName;

  static const String name = '/catagoryWiseListScreen';

  @override
  State<CategoryWiseListView> createState() => _CategoryWiseListViewState();
}

class _CategoryWiseListViewState extends State<CategoryWiseListView> {
  final GetRecipeByCategoryViewModel _getRecipeByCategoryViewModel =
      locator<GetRecipeByCategoryViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    print(widget.categoryName);
    _getRecipeByCategoryViewModel.getRecipesByCategory(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(widget.categoryName),
      ),
      body: SafeArea(
        child: ChangeNotifierProvider(
          create: (context) => _getRecipeByCategoryViewModel,
          child: Consumer<GetRecipeByCategoryViewModel>(
            builder: (context, value, child) {
              return value.isLoading
                  ? Center(child: circleProgress())
                  : Visibility(
                    visible: value.recipes.isNotEmpty,
                    replacement: Center(
                      child: Text('No recipes found in this category'),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: value.recipes.length,
                      padding: EdgeInsets.only(bottom: 20),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: FoodRecipeWidget(
                            onTap: () {
                              FavouriteToggleViewModel.toggleFavourite(
                                value.recipes[index]['id'],
                                AuthViewModel.uid!,
                              );
                              value.updateToggle(value.recipes[index]['id']);
                            },
                            recipeDetails: value.recipes[index],
                          ),
                        );
                      },
                    ),
                  );
            },
          ),
        ),
      ),
    );
  }
}
