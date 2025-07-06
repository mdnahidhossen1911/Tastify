import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';

class FoodRecipeWidget extends StatelessWidget {
  const FoodRecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),  // adjust the radius as you like
            child: Image.asset(
              AssetsPath.popularFishImageJPG,
              height: 140,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Big and Juicy Wagyu Beef Cheeseburger',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8,),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 8,vertical: 4)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.favorite,size: 17,color: Colors.deepOrange,),
                        ),
                        SizedBox(width: 5,),
                        Text('Favourite',style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    /*CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(AssetsPath.popularFishImageJPG),
                    backgroundColor: Colors.transparent,
                  ),*/
                    Icon(Icons.timer,size: 20,color: Colors.black,),
                    SizedBox(width: 4),
                    Text('30 Minutes', style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold)),
                    SizedBox(width: 16),
                    Icon(Icons.restaurant, size: 20, color: Colors.black),
                    SizedBox(width: 4),
                    Text('Breakfast', style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold)),
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
