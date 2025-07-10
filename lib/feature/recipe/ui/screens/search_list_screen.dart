import 'package:flutter/material.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/feature/common/ui/widget/category_item_widget.dart';
import 'package:tastify/feature/common/ui/widget/food_recipe_widget.dart';

class SearchListScreen extends StatefulWidget {
  const SearchListScreen({super.key});

  static const String name='/search-screen';

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Search',style: textTheme.titleLarge,),
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    hintText: 'Strawbery Oatmeal',
                    hintStyle: TextStyle(color: Colors.black),
                    suffixIcon: Icon(Icons.search,color: AppColor.themeColor,size: 30,),
                    fillColor: Colors.pink.shade50,
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60),
                      borderSide: BorderSide(color: Colors.pink.shade50)
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: BorderSide(color: Colors.pink.shade50)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: FoodRecipeWidget(),
                    );
                  },
                ),
              ],
            )
        ),
      ),
    );
  }
}
