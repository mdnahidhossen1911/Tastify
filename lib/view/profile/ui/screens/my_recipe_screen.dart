import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../res/component/circle_progress.dart';
import '../../../../res/component/my_recipe_widget.dart';
import '../../../../view_model/my_recipe_view_model.dart';

class MyRecipeScreen extends StatefulWidget {
  const MyRecipeScreen({super.key});

  static const String name = '/my-recipe-screen';

  @override
  State<MyRecipeScreen> createState() => _MyRecipeScreenState();
}

class _MyRecipeScreenState extends State<MyRecipeScreen> {
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
