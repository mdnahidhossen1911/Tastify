import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/core/utils/circle_progress.dart';
import 'package:tastify/feature/category/controller/get_recipe_by_category_controller.dart';
import 'package:tastify/feature/common/ui/widget/food_recipe_widget.dart';

class CategoryWiseListScreen extends StatefulWidget {
  const CategoryWiseListScreen({super.key, required this.categoryName});

  final String categoryName;

  static const String name = '/catagoryWiseListScreen';

  @override
  State<CategoryWiseListScreen> createState() => _CategoryWiseListScreenState();
}

class _CategoryWiseListScreenState extends State<CategoryWiseListScreen> {
  final GetRecipeByCategoryController getRecipeByCategoryController =
      GetRecipeByCategoryController();

  @override
  void initState() {
    // TODO: implement initState
    print(widget.categoryName);
    getRecipeByCategoryController.getRecipesByCategory(widget.categoryName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title: Text(widget.categoryName),
      ),
      body: SafeArea(
        child: GetBuilder(
          init: getRecipeByCategoryController,
          builder: (controller) {
            return controller.isLoading
                ? Center(child: circleProgress())
                : Visibility(
                  visible: controller.recipes.isNotEmpty,
                  replacement: Center(
                    child: Text(
                      'No recipes found in this category',
                    ),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.recipes.length,
                    padding: EdgeInsets.only(bottom: 20),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: FoodRecipeWidget(
                          recipeDetails: controller.recipes[index],
                        ),
                      );
                    },
                  ),
                );
          },
        ),
      ),
    );
  }
}
