import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/view_model/view_models.dart';

import '../../res/component/circle_progress.dart';
import '../../res/component/my_recipe_widget.dart';

class MyRecipeView extends StatefulWidget {
  const MyRecipeView({super.key});

  static const String name = '/my-recipe-screen';

  @override
  State<MyRecipeView> createState() => _MyRecipeViewState();
}

class _MyRecipeViewState extends State<MyRecipeView> {
  late MyRecipeViewModel _myRecipeViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _myRecipeViewModel.fetchMyRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
    _myRecipeViewModel = Provider.of<MyRecipeViewModel>(context, listen: false);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title: Text('My Recipe', style: textTheme.headlineSmall),
      ),
      body: SafeArea(
        child: Consumer<MyRecipeViewModel>(
          builder: (context, value, child) {
            return value.isLoading
                ? circleProgress()
                : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: value.myRecipes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: MyRecipeWidget(recipe: value.myRecipes[index]),
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
