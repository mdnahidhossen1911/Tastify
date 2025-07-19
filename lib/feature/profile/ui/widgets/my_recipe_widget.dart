import 'package:flutter/material.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/app/assets_path.dart';

class MyRecipeWidget extends StatelessWidget {
  const MyRecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              AssetsPath.popularFishImageJPG,
              height: 100,
              width: 150,
              fit: BoxFit.cover,
            ),
          ),

          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Big and Juicy Wagyu Beef Cheeseburger',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height:4),
                Text('03-07-2025',style: TextStyle(color: Colors.grey,fontSize: 10),),
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
