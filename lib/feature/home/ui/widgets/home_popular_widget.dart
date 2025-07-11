import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';

class HomePopularWidget extends StatelessWidget {
  const HomePopularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.deepOrange.shade100.withOpacity(0.1),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),  // adjust the radius as you like
                  child: Image.asset(
                    AssetsPath.popularFishImageJPG,
                    height: 160,
                    width: 226,
                    fit: BoxFit.cover,
                  ),
                ),

              ),
              Positioned(
                top: 25,
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
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                SizedBox(height: 8),
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
                    Text('Snack', style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold)),
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
