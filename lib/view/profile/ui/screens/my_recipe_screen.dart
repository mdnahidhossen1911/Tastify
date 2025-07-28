import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/component/circle_progress.dart';
import '../../../../res/component/my_recipe_widget.dart';
import '../controller/my_recipe_controller.dart';

class MyRecipeScreen extends StatefulWidget {
  const MyRecipeScreen({super.key});

  static const String name = '/my-recipe-screen';

  @override
  State<MyRecipeScreen> createState() => _MyRecipeScreenState();
}

class _MyRecipeScreenState extends State<MyRecipeScreen> {
  MyRecipeController myRecipeController = Get.find<MyRecipeController>();

  @override
  void initState() {
    // TODO: implement initState
    myRecipeController.fetchMyRecipes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title: Text('My Recipe', style: textTheme.titleLarge),
      ),
      body: SafeArea(
        child: GetBuilder(
          init: myRecipeController,
          builder: (controller) {
            return controller.isLoading
                ? circleProgress()
                : ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: controller.myRecipes.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: MyRecipeWidget(
                        recipe: controller.myRecipes[index],
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
