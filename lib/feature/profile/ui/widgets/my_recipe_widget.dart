import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/core/utc_to_local_date.dart';
import 'package:tastify/feature/recipe/ui/screens/recipe_details_screen.dart';

class MyRecipeWidget extends StatelessWidget {
  const MyRecipeWidget({super.key, required this.recipe});
  final Map<String, dynamic> recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RecipeDetailsScreen.name, arguments: recipe);
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
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height:4),
                Text(formatUtcToLocalDate(recipe['created_at']),style: TextStyle(color: Colors.grey,fontSize: 10),),
                SizedBox(height: 8),
                Row(
                  children: [
                   InkWell(
                     onTap: () {
                       
                     },
                     borderRadius: BorderRadius.circular(12),
                     child: Row(
                       children: [
                         Icon(Icons.edit,color: AppColor.themeColor,size: 16,),
                         SizedBox(width: 2,),
                         Text('Edit recipe',style: TextStyle(fontSize:12,color: AppColor.themeColor,fontWeight: FontWeight.bold),)
                       ],
                     ),
                   ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        
                      },
                      borderRadius: BorderRadius.circular(12),
                      child: Row(
                        children: [
                          Icon(Icons.delete_outline,color: AppColor.themeColor,size: 16,),
                          SizedBox(width: 2,),
                          Text('Delete',style: TextStyle(fontSize:12,color: AppColor.themeColor,fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),

    );
  }
}
