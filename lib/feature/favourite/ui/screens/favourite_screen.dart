import 'package:flutter/material.dart';
import 'package:tastify/feature/common/ui/widget/food_recipe_widget.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        title: Text('Favourite',style: textTheme.titleLarge),
      ),
      body: SafeArea(
        child: SizedBox()


        // ListView.builder(
        //   shrinkWrap: true,
        //   itemCount: 10,
        //   itemBuilder: (context,index){
        //     return Padding(
        //       padding: EdgeInsets.symmetric(vertical: 10),
        //       child: FoodRecipeWidget(),
        //     );
        //   },
        // ),
      ),
    );
  }
}
