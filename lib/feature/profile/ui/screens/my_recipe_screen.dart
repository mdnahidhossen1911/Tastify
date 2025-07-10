import 'package:flutter/material.dart';
import 'package:tastify/feature/profile/ui/widgets/my_recipe_widget.dart';

class MyRecipeScreen extends StatefulWidget {
  const MyRecipeScreen({super.key});

  static const String name='/my-recipe-screen';

  @override
  State<MyRecipeScreen> createState() => _MyRecipeScreenState();
}

class _MyRecipeScreenState extends State<MyRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('My Recipe',style: textTheme.titleLarge,),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          //shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context,index){
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: MyRecipeWidget(),
            );
          },
        ),
      ),
    );
  }
}
