import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/view/home/ui/screens/popular_list_screen.dart';
import 'package:tastify/view/home/ui/screens/search_list_screen.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/assets_path.dart';
import '../../../../res/component/category_item_widget.dart';
import '../../../../res/component/circle_progress.dart';
import '../../../../res/component/food_recipe_widget.dart';
import '../../../../res/component/home_carousel_slider.dart';
import '../../../../res/component/home_popular_widget.dart';
import '../../../../res/component/section_header.dart';
import '../../../auth/ui/controller/auth_controller.dart';
import '../../../category/controller/category_controller.dart';
import '../../../category/ui/screen/category_list_screen.dart';
import '../../../favourite/ui/controller/favourite_toggle_controller.dart';
import '../../../recipe/ui/controller/get_recipe_controller.dart';
import '../../../recipe/ui/screens/add_recipe_screen.dart';
import '../controller/carousel_image_controller.dart';
import '../controller/fetch_popular_item_controller.dart';
import 'featured_recipe_list_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static const String name = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isDarkMode
                ? Image.asset(AssetsPath.appLogoDarkPNG, height: 36)
                : Image.asset(AssetsPath.appLogoPNG, height: 36),
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
          Get.find<FetchPopularItemController>().getAllRecipes(
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
                title: isDarkMode ? 'Category dark' : 'Category',
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
      child: GetBuilder<FetchPopularItemController>(
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
