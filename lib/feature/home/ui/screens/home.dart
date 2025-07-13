import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/app/assets_path.dart';
import 'package:tastify/core/utils/circle_progress.dart';
import 'package:tastify/feature/common/ui/widget/food_recipe_widget.dart';
import 'package:tastify/feature/common/ui/widget/category_item_widget.dart';
import 'package:tastify/feature/home/ui/widgets/home_carousel_slider.dart';
import 'package:tastify/feature/home/ui/widgets/home_popular_widget.dart';
import 'package:tastify/feature/home/ui/widgets/section_header.dart';
import 'package:tastify/feature/recipe/ui/screens/add_recipe_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/category_list_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/featured_recipe_list_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/popular_list_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/search_list_screen.dart';

import '../controller/carousel_image_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  static const String name='/home';
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Map<String, dynamic>> sliderImages =[];
  CarouselImageController carouselImageController = Get.find<CarouselImageController>();

  @override
  void initState() {
    // TODO: implement initState
    getSliderImages();
    super.initState();
  }

  getSliderImages() async {
    final response = await carouselImageController.getImage();
    sliderImages = response.responseData!['data'] as List<Map<String, dynamic>>;
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(AssetsPath.appLogoPNG,height: 36,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, AddRecipeScreen.name);
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.orange.withOpacity(0.15),
                    child: Icon(Icons.add,size: 26,color: AppColor.themeColor,),
                  ),
                ),
                SizedBox(width: 12,),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.orange.withOpacity(0.15),
                  child: IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, SearchListScreen.name);
                    },
                    icon: Icon(Icons.search,size: 22,color: AppColor.themeColor,),
                  )
                ),
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            GetBuilder<CarouselImageController>(
              builder: (controller) {
                return controller.isLoading
                    ? Center(child: circleProgress())
                    : HomeCarouselSlider(sliderImages: sliderImages);
              },
            ),
            SizedBox(height: 8),
            SectionHeader(title: 'Category',seeAll: (){Navigator.pushReplacementNamed(context, CategoryListScreen.name);},),
            _buildCategorySection(),
            SizedBox(height: 8,),
            SectionHeader(title: 'Popular', seeAll: (){Navigator.pushReplacementNamed(context, PopularListScreen.name);}),
            _buildPopularSection(),
            SizedBox(height: 8,),
            SectionHeader(title: 'Featured Recipe', seeAll: (){Navigator.pushReplacementNamed(context, FeaturedRecipeListScreen.name);}),
            _buildFeaturedRecipe()

          ],
        ),
      ),
    );
  }

  ListView _buildFeaturedRecipe() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 5,
      padding: EdgeInsets.only(bottom: 20),
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: FoodRecipeWidget(),
        );
      },
    );
  }

  Widget _buildPopularSection() {
    return SizedBox(
      height: 196,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: EdgeInsets.symmetric(horizontal: 10),
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
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          padding: EdgeInsets.symmetric(horizontal: 10),
          itemBuilder: (context,index){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CategoryItemWidget()
            );
          },

        ),
      );
  }
}
