import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tastify/view/views.dart';

import '../../model/recipe_model.dart';
import '../../utils/utc_to_local_date.dart';
import '../../view_model/my_recipe_view_model.dart';
import '../app_colors.dart';
import 'circle_progress.dart';

class MyRecipeWidget extends StatelessWidget {
  MyRecipeWidget({super.key, required this.recipe});

  final Map<String, dynamic> recipe;

  RxBool deleteInProgress = false.obs;

  late MyRecipeViewModel _myRecipeViewModel;

  @override
  Widget build(BuildContext context) {
    _myRecipeViewModel = Provider.of<MyRecipeViewModel>(context, listen: false);

    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              context.push(RecipeDetailsScreen.name, extra: recipe);
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                base64Decode(recipe['photo']),
                height: 100,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  recipe['title'] ?? 'Recipe Name',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  formatUtcToLocalDate(recipe['created_at']),
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.push(
                          UpdateRecipeScreen.name,
                          extra: RecipeModel.fromJson(recipe),
                        );
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: AppColor.themeColor,
                            size: 16,
                          ),
                          SizedBox(width: 2),
                          Text(
                            'Edit recipe',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColor.themeColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),

                    Obx(
                      () =>
                          deleteInProgress.value == true
                              ? circleProgress()
                              : InkWell(
                                onTap: () async {
                                  deleteInProgress.value = true;
                                  await _myRecipeViewModel.deleteRecipe(
                                    recipe['id'],
                                  );
                                  deleteInProgress.value = false;
                                },
                                borderRadius: BorderRadius.circular(12),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete_outline,
                                      color: AppColor.themeColor,
                                      size: 16,
                                    ),
                                    SizedBox(width: 2),
                                    Text(
                                      'Delete',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColor.themeColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
