import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/service_locator.dart';

import '../../res/component/circle_progress.dart';
import '../../res/component/food_recipe_widget.dart';
import '../../view_model/auth_view_model.dart';
import '../../view_model/get_recipe_by_category_view_model.dart';
import '../favourite/ui/controller/favourite_toggle_controller.dart';

class CategoryWiseListScreen extends StatefulWidget {
  const CategoryWiseListScreen({super.key, required this.categoryName});

  final String categoryName;

  static const String name = '/catagoryWiseListScreen';

  @override
  State<CategoryWiseListScreen> createState() => _CategoryWiseListScreenState();
}

class _CategoryWiseListScreenState extends State<CategoryWiseListScreen> {
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
                              FavouriteToggleController.toggleFavourite(
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
