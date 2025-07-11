import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';

class BlogWidget extends StatelessWidget {
  const BlogWidget({super.key});

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
                Text('Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum ',style: TextStyle(

                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: 8,),
                Row(
                  children: [
                    /*CircleAvatar(
                    radius: 10,
                    backgroundImage: AssetImage(AssetsPath.popularFishImageJPG),
                    backgroundColor: Colors.transparent,
                  ),*/
                    Icon(Icons.account_circle_outlined,size: 20,color: Colors.black,),
                    SizedBox(width: 4),
                    Text('UserName', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                    SizedBox(width: 6),
                    Icon(Icons.circle, size: 5, color: Colors.grey),
                    SizedBox(width: 6),
                    Text('3/7/2025', style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold)),
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
