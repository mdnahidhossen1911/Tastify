import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';

class RecipeFeedbackScreen extends StatefulWidget {
  const RecipeFeedbackScreen({super.key});

  static const String name='/recipe-feedback';

  @override
  State<RecipeFeedbackScreen> createState() => _RecipeFeedbackScreenState();
}

class _RecipeFeedbackScreenState extends State<RecipeFeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Feedback',style: textTheme.titleLarge,),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: 5,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: double.maxFinite,
                  //height: 300,
                  decoration: BoxDecoration(
                      color: Colors.pink.shade50,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(AssetsPath.popularFishImageJPG,width: 120,height: 120,fit: BoxFit.cover,),
                            ),
                            SizedBox(width: 10,),
                            Expanded(
                              child: Text(
                                'Big and Juicy Wagyu Beef Cheeseburger',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: double.maxFinite,
                          //height: double.maxFinite,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.account_circle,size: 40,),
                                SizedBox(width: 8,),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('Nahid Hossen',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                                          SizedBox(width: 5,),
                                          CircleAvatar(
                                            radius: 3,
                                            backgroundColor: Colors.grey,
                                          ),
                                          SizedBox(width: 5,),
                                          Text('03-07-2025',style: TextStyle(fontSize: 15,color: Colors.grey),)

                                        ],
                                      ),
                                      SizedBox(height: 8,),
                                      Text('The Wagyu Beef Cheeseburger was juicy and flavorful. Perfectly cooked beef, fresh toppings, and a soft toasted bun made it a delicious and satisfying meal. Highly recommended! ',style: TextStyle(
                                        color: Colors.grey,

                                      ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
