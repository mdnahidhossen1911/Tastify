import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/res/component/home_view_app_logo.dart';
import 'package:tastify/service_locator.dart';
import 'package:tastify/view/home/popular_list_screen.dart';
import 'package:tastify/view/home/search_list_screen.dart';
import 'package:tastify/view_model/category_view_model.dart';

import '../../res/app_colors.dart';
import '../../res/component/category_item_widget.dart';
import '../../res/component/circle_progress.dart';
import '../../res/component/food_recipe_widget.dart';
import '../../res/component/home_carousel_slider.dart';
import '../../res/component/home_popular_widget.dart';
import '../../res/component/section_header.dart';
import '../../view_model/auth_view_model.dart';
import '../../view_model/carousel_image_view_model.dart';
import '../../view_model/favourite_toggle_controller.dart';
import '../../view_model/fetch_popular_view_model.dart';
import '../../view_model/get_recipe_view_model.dart';
import '../category/category_list_screen.dart';
import '../recipe/add_recipe_screen.dart';
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
        forceMaterialTransparency: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeAppLogo(),
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
          locator<CarouselImageViewModel>().getImage();
          locator<CategoryViewModel>().getCategory();
          locator<GetRecipeViewModel>().getAllRecipes(AuthViewModel.uid ?? '');
          locator<FetchPopularViewModel>().getAllRecipes(
            AuthViewModel.uid ?? '',
          );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              Consumer<CarouselImageViewModel>(
                builder: (context, value, child) {
                  return value.isLoading
                      ? Center(child: circleProgress())
                      : HomeCarouselSlider(sliderImages: value.carouselImages);
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
    return Consumer<GetRecipeViewModel>(
      builder: (context, value, child) {
        return value.isLoading
            ? Center(child: circleProgress())
            : ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.recipes.length,
              padding: EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: FoodRecipeWidget(
                    onTap: () {
                      FavouriteToggleViewModel.toggleFavourite(
                        value.recipes[index]['id'],
                        AuthViewModel.uid!,
                      );
                    },
                    recipeDetails: value.recipes[index],
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
      child: Consumer<FetchPopularViewModel>(
        builder: (context, value, child) {
          return Visibility(
            visible: !value.isLoading,
            replacement: Center(child: circleProgress()),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: value.recipes.length,
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HomePopularWidget(popularItem: value.recipes[index]),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategorySection() {
    return Consumer<CategoryViewModel>(
      builder: (context, value, child) {
        return value.isLoading
            ? Center(child: circleProgress())
            : SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: value.categoryList.length,
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CategoryItemWidget(
                      category: value.categoryList[index],
                    ),
                  );
                },
              ),
            );
      },
    );
  }
}
