import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/app/assets_path.dart';
import 'package:tastify/core/utils/circle_progress.dart';
import 'package:tastify/feature/auth/ui/controller/auth_controller.dart';
import 'package:tastify/feature/category/controller/category_controller.dart';
import 'package:tastify/feature/common/ui/widget/category_item_widget.dart';
import 'package:tastify/feature/common/ui/widget/food_recipe_widget.dart';
import 'package:tastify/feature/home/ui/widgets/home_carousel_slider.dart';
import 'package:tastify/feature/home/ui/widgets/home_popular_widget.dart';
import 'package:tastify/feature/home/ui/widgets/section_header.dart';
import 'package:tastify/feature/recipe/ui/controller/get_recipe_controller.dart';
import 'package:tastify/feature/recipe/ui/screens/add_recipe_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/category_list_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/featured_recipe_list_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/popular_list_screen.dart';
import 'package:tastify/feature/recipe/ui/screens/search_list_screen.dart';

import '../../../favourite/ui/controller/favourite_toggle_controller.dart';
import '../controller/carousel_image_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const String name = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
            Image.asset(AssetsPath.appLogoPNG, height: 36),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.orange.withOpacity(0.15),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AddRecipeScreen.name);
                    },
                    icon: Icon(Icons.add, size: 24, color: AppColor.themeColor),
                  ),
                ),
                SizedBox(width: 12),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.orange.withOpacity(0.15),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SearchListScreen.name);
                    },
                    icon: Icon(
                      Icons.search,
                      size: 22,
                      color: AppColor.themeColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: AppColor.themeColor,
        backgroundColor: Colors.white,
        displacement: 50,
        edgeOffset: 10,
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          Get.find<CarouselImageController>().getImage();
          Get.find<CategoryController>().getCategory();
          Get.find<GetRecipeController>().getAllRecipes(
            AuthController.uid ?? '',
          );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              GetBuilder<CarouselImageController>(
                builder: (controller) {
                  return controller.isLoading
                      ? Center(child: circleProgress())
                      : HomeCarouselSlider(
                        sliderImages: controller.carouselImages,
                      );
                },
              ),
              SizedBox(height: 8),
              SectionHeader(
                title: 'Category',
                seeAll: () {
                  Navigator.pushNamed(context, CategoryListScreen.name);
                },
              ),
              _buildCategorySection(),
              SizedBox(height: 8),
              SectionHeader(
                title: 'Popular',
                seeAll: () {
                  Navigator.pushNamed(context, PopularListScreen.name);
                },
              ),
              _buildPopularSection(),
              SizedBox(height: 8),
              SectionHeader(
                title: 'Featured Recipe',
                seeAll: () {
                  Navigator.pushNamed(context, FeaturedRecipeListScreen.name);
                },
              ),
              SizedBox(height: 4),
              _buildFeaturedRecipe(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedRecipe() {
    return GetBuilder<GetRecipeController>(
      builder: (controller) {
        return controller.isLoading
            ? Center(child: circleProgress())
            : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.recipes.length,
              padding: EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FoodRecipeWidget(
                    onTap: () {
                      FavouriteToggleController.toggleFavourite(
                        controller.recipes[index]['id'],
                        AuthController.uid!,
                      );
                    },
                    recipeDetails: controller.recipes[index],
                  ),
                );
              },
            );
      },
    );
  }

  Widget _buildPopularSection() {
    return SizedBox(
      height: 196,
      child: GetBuilder<GetRecipeController>(
        builder: (controller) {
          return Visibility(
            visible: !controller.isLoading,
            replacement: Center(child: circleProgress()),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.recipes.length,
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HomePopularWidget(
                    popularItem: controller.recipes[index],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategorySection() {
    return GetBuilder<CategoryController>(
      builder: (controller) {
        return controller.isLoading
            ? Center(child: circleProgress())
            : SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categoryList.length,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CategoryItemWidget(
                      category: controller.categoryList[index],
                    ),
                  );
                },
              ),
            );
      },
    );
  }
}
