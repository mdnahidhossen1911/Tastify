import 'package:flutter/material.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/app/assets_path.dart';

class MyRecipeWidget extends StatelessWidget {
  const MyRecipeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.maxFinite,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),  // adjust the radius as you like
            child: Image.asset(
              AssetsPath.popularFishImageJPG,
              height: 120,
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
                Text('03-07-2025',style: TextStyle(color: Colors.grey),),
                SizedBox(height: 8,),
                Row(
                  children: [
                    /*CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(AssetsPath.popularFishImageJPG),
                    backgroundColor: Colors.transparent,
                  ),*/
                   Row(
                     children: [
                       Icon(Icons.edit,color: AppColor.themeColor,size: 20,),
                       SizedBox(width: 2,),
                       Text('Edit recipe',style: TextStyle(fontSize:15,color: AppColor.themeColor,fontWeight: FontWeight.bold),)
                     ],
                   ),
                    SizedBox(width: 10,),
                    Row(
                      children: [
                        Icon(Icons.delete_outline,color: AppColor.themeColor,size: 20,),
                        SizedBox(width: 2,),
                        Text('Delete',style: TextStyle(fontSize:15,color: AppColor.themeColor,fontWeight: FontWeight.bold),)
                      ],
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
