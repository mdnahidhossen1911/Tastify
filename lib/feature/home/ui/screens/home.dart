import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';
import 'package:tastify/feature/common/ui/widget/food_recipe_widget.dart';
import 'package:tastify/feature/home/ui/widgets/home_category_widget.dart';
import 'package:tastify/feature/home/ui/widgets/home_carousel_slider.dart';
import 'package:tastify/feature/home/ui/widgets/home_popular_widget.dart';
import 'package:tastify/feature/home/ui/widgets/section_header.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String name='/home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedSlider=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(AssetsPath.appLogoPNG,width: 140,height: 80,),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.orange.withOpacity(0.2),
                  child: Icon(Icons.add,size: 30,color: Colors.deepOrange,),
                ),
                SizedBox(width: 8,),
                CircleAvatar(
                  backgroundColor: Colors.orange.withOpacity(0.2),
                  child: Icon(Icons.search,size:30,color: Colors.deepOrange,),
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              HomeCarouselSlider(),
              SizedBox(height: 16,),
              SectionHeader(title: 'Category',seeAll: (){},),
              SizedBox(height: 16,),
              _buildCategorySection(),
              SizedBox(height: 16,),
              SectionHeader(title: 'Popular', seeAll: (){}),
              _buildPopularSection(),
              SizedBox(height: 16,),
              SectionHeader(title: 'Featured Recipe', seeAll: (){}),
              SizedBox(height: 16,),
              _buildFeaturedRecipe()


        
        
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildFeaturedRecipe() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: FoodRecipeWidget(),
        );
      },
    );
  }

  Widget _buildPopularSection() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: HomePopularWidget()
          );
        },
      ),
    );
  }

  Widget _buildCategorySection() {
    return SizedBox(
        height: 145,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Homecategorywidget()
            );
          },

        ),
      );
  }
}
