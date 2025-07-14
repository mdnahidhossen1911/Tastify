import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tastify/feature/recipe/ui/screens/recipe_details_screen.dart';

class HomePopularWidget extends StatelessWidget {
  HomePopularWidget({super.key, required this.popularItem});
  Map<String, dynamic> popularItem ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RecipeDetailsScreen.name, arguments: popularItem);
      },
      child: Container(
        width: 196,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xfffff0e8),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),  // adjust the radius as you like
                    child: Image.memory(
                      base64Decode(popularItem['photo'] ?? ''),
                      height: 94,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                  ),

                ),
                Positioned(
                  top: 5,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.favorite,size: 17,color: Colors.deepOrange,),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    popularItem['title'] ?? 'Title',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [

                      Icon(Icons.timer,size: 16,color: Colors.black,),
                      SizedBox(width: 4),
                      Text( popularItem['prep_time']??'', style: TextStyle(color: Colors.black38,fontSize: 10,fontWeight: FontWeight.bold)),
                      SizedBox(width: 16),
                      Icon(Icons.restaurant, size: 16, color: Colors.black),
                      SizedBox(width: 4),
                      Text( popularItem['category_name']??'' , style: TextStyle(color: Colors.black38,fontSize: 10 ,fontWeight: FontWeight.bold)),
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
