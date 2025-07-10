import 'package:flutter/material.dart';
import 'package:tastify/feature/common/ui/widget/category_item_widget.dart';
import 'package:tastify/feature/common/ui/widget/food_recipe_widget.dart';

class FeaturedRecipeListScreen extends StatefulWidget {
  const FeaturedRecipeListScreen({super.key});

  static const String name='/featured-recipe-screen';

  @override
  State<FeaturedRecipeListScreen> createState() => _FeaturedRecipeListScreenState();
}

class _FeaturedRecipeListScreenState extends State<FeaturedRecipeListScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Featured Recipe',style: textTheme.titleLarge,),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context,index){
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: FoodRecipeWidget(),
            );
          },
        )
      ),
    );
  }
}
