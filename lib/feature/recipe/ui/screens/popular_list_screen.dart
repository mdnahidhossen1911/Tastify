import 'package:flutter/material.dart';
import 'package:tastify/feature/common/ui/widget/food_recipe_widget.dart';

class PopularListScreen extends StatefulWidget {
  const PopularListScreen({super.key});

  static const String name='/popular-list-screen';

  @override
  State<PopularListScreen> createState() => _PopularListScreenState();
}

class _PopularListScreenState extends State<PopularListScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Popular',style: textTheme.titleLarge,),
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
