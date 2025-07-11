import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key});

  static const String name='/recipe-details-screen';

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: double.maxFinite,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(AssetsPath.popularFishImageJPG,width: 300,height: 300,fit: BoxFit.cover,),
                ),
              ),
              SizedBox(height: 8,),
              Text('Big and Juicy Wagyu Beef Cheeseburger',style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25
              ),),
              SizedBox(height: 8,),
              Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Color(0xFFf4f3f2),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.timer),
                          SizedBox(width: 5,),
                          Column(
                            children: [
                              Text('Prep Time',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                              SizedBox(height: 2,),
                              Text('30 Minutes',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.timer),
                          SizedBox(width: 5,),
                          Column(
                            children: [
                              Text('Prep Time',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                              SizedBox(height: 2,),
                              Text('30 Minutes',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.restaurant),
                          SizedBox(width: 5,),
                          Text('Breakfast',style: TextStyle(color:Colors.grey,fontWeight: FontWeight.bold,fontSize: 15),),
                        ],
                      ),
        
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8,),
              Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",style: TextStyle(color: Colors.grey),)
            ],
          ),
        ),
      ),
    );
  }
}
