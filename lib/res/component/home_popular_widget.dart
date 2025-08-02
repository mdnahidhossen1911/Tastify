import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/res/theme/theme_changer.dart';

import '../../view/favourite/ui/controller/favourite_toggle_controller.dart';
import '../../view/recipe/recipe_details_screen.dart';
import '../../view_model/auth_view_model.dart';

class HomePopularWidget extends StatelessWidget {
  HomePopularWidget({super.key, required this.popularItem});

  final Map<String, dynamic> popularItem;

  @override
  Widget build(BuildContext context) {
    ThemeChanger themeChanger = Provider.of<ThemeChanger>(context);
    TextTheme textTheme = Theme.of(context).textTheme;

    final isFav = popularItem['favourites'] == true;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RecipeDetailsScreen.name,
          arguments: popularItem,
        );
      },
      child: Container(
        width: 196,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              themeChanger.values ? Colors.transparent : Colors.white,
              themeChanger.values
                  ? Colors.orange.withOpacity(0.05)
                  : Color(0xfffff0e8),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    // adjust the radius as you like
                    child: Image.memory(
                      base64Decode(popularItem['photo'] ?? ''),
                      height: 94,
                      width: 170,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: IconButton(
                      onPressed: () {
                        FavouriteToggleController.toggleFavourite(
                          popularItem['id'],
                          AuthViewModel.uid!,
                        );
                      },
                      icon: Icon(
                        Icons.favorite,
                        size: 17,
                        color: isFav ? Colors.deepOrange : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    popularItem['title'] ?? 'Title',
                    style: textTheme.labelMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.timer,
                        size: 16,

                        color:
                            themeChanger.values ? Colors.white : Colors.black,
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${popularItem['prep_time'] ?? ''} min',
                        style: textTheme.labelSmall,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.restaurant,
                        size: 16,
                        color:
                            themeChanger.values ? Colors.white : Colors.black,
                      ),
                      SizedBox(width: 4),
                      Text(
                        popularItem['category_name'] ?? 'category',
                        style: textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
