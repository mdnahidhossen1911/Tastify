import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tastify/feature/recipe/ui/screens/recipe_details_screen.dart';

class FoodRecipeWidget extends StatelessWidget {
  const FoodRecipeWidget({super.key, required this.recipeDetails});
  final Map<String,dynamic> recipeDetails ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RecipeDetailsScreen.name, arguments: recipeDetails);
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8,),
                  SizedBox(
                    width: 86,
                    height: 28,
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.favorite,size: 14,color: Colors.deepOrange,),
                          ),
                          SizedBox(width: 5,),
                          Text('Favourite',style: TextStyle(color: Colors.deepOrange,fontSize: 10,fontWeight: FontWeight.bold),),
                          SizedBox(width: 8)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.timer,size: 16,color: Colors.black,),
                      SizedBox(width: 4),
                      Text(recipeDetails['prep_time'], style: TextStyle(color: Colors.black38,fontSize: 10,fontWeight: FontWeight.bold)),
                      SizedBox(width: 16),
                      Icon(Icons.restaurant, size: 16, color: Colors.black),
                      SizedBox(width: 4),
                      Text(recipeDetails['category_name'], style: TextStyle(color: Colors.black38,fontSize: 10,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),

      ),
    );
  }
}
