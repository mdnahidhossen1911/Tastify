import 'dart:convert';

import 'package:flutter/material.dart';

import '../../view/recipe/ui/screens/recipe_details_screen.dart';

class FoodRecipeWidget extends StatelessWidget {
  const FoodRecipeWidget({
    super.key,
    required this.recipeDetails,
    required this.onTap,
  });
  final Map<String, dynamic> recipeDetails;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    final isFav = recipeDetails['favourites'] == true;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RecipeDetailsScreen.name,
          arguments: recipeDetails,
        );
      },
      child: Container(
        height: 110,
        margin: EdgeInsets.symmetric(horizontal: 16),
        width: double.maxFinite,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                base64Decode(recipeDetails['photo'] ?? ''),
                height: 110,
                width: 158,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipeDetails['title'] ?? 'name',
                    style: textTheme.labelLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: 86,
                    height: 28,
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        elevation: 0,
                        backgroundColor: Color(0x33ffa571),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white,
                              child:
                                  isFav == true
                                      ? Icon(
                                        Icons.favorite,
                                        size: 14,
                                        color: Colors.deepOrange,
                                      )
                                      : Icon(
                                        Icons.favorite,
                                        size: 14,
                                        color: Colors.black26,
                                      ),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Favourite',
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.timer,
                        size: 16,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${recipeDetails['prep_time'] ?? ''} min',
                        style: textTheme.labelSmall,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.restaurant,
                        size: 16,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                      SizedBox(width: 4),
                      Text(
                        recipeDetails['category_name'] ?? 'category',
                        style: textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
