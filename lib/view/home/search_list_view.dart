import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/service_locator.dart';
import 'package:tastify/view_model/view_models.dart';

import '../../res/component/circle_progress.dart';
import '../../res/component/food_recipe_widget.dart';

class SearchListView extends StatefulWidget {
  const SearchListView({super.key});

  static const String name = '/search-screen';

  @override
  State<SearchListView> createState() => _SearchListViewState();
}

class _SearchListViewState extends State<SearchListView> {
  final TextEditingController _searchController = TextEditingController();
  final RecipeSearchViewModel _recipeSearchViewModel =
      locator<RecipeSearchViewModel>();
  Timer? _debounce;

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 1400), () {
      _recipeSearchViewModel.searchWithTitle(query.trim().toLowerCase());
    });
  }

  void _clearSearch() {
    _searchController.clear();
    _recipeSearchViewModel.searchWithTitle('');
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
        child: ChangeNotifierProvider(
          create: (context) => _recipeSearchViewModel,
          child: Consumer<RecipeSearchViewModel>(
            builder: (context, value, child) {
              return value.isLoading
                  ? circleProgress()
                  : ListView.builder(
                    itemCount: value.recipes.length,
                    padding: const EdgeInsets.symmetric(vertical: 8),
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
                            value.updateToggle(value.recipes[index]['id']);
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
