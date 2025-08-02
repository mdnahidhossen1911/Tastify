import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/component/circle_progress.dart';
import '../../../../res/component/food_recipe_widget.dart';
import '../../../../view_model/auth_view_model.dart';
import '../../../favourite/ui/controller/favourite_toggle_controller.dart';
import '../controller/recipe_search_controller.dart';

class SearchListScreen extends StatefulWidget {
  const SearchListScreen({super.key});

  static const String name = '/search-screen';

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final RecipeSearchController _recipeController = RecipeSearchController();
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1400), () {
      _recipeController.searchWithTitle(query.trim().toLowerCase());
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _recipeController.searchWithTitle('');
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    _clearSearch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: SizedBox(
          height: 45,
          child: SearchBar(
            controller: _searchController,
            backgroundColor: WidgetStateColor.resolveWith(
              (states) => Colors.deepOrange.shade50.withOpacity(0.7),
            ),
            hintText: "Search recipes with title or category",
            elevation: const MaterialStatePropertyAll(0),
            onChanged: _onSearchChanged,
          ),
        ),
      ),
      body: SafeArea(
        child: GetBuilder(
          init: _recipeController,
          builder: (controller) {
            return controller.isLoading
                ? circleProgress()
                : ListView.builder(
                  itemCount: controller.recipes.length,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: FoodRecipeWidget(
                        recipeDetails: controller.recipes[index],
                        onTap: () {
                          FavouriteToggleController.toggleFavourite(
                            controller.recipes[index]['id'],
                            AuthViewModel.uid!,
                          );
                          controller.updateToggle(
                            controller.recipes[index]['id'],
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
