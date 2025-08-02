import 'package:flutter/material.dart';

import '../../view/category/category_wise_list_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  CategoryItemWidget({super.key, this.category});
  Map<String, dynamic>? category;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          CategoryWiseListScreen.name,
          arguments: category!['title'],
        );
      },
      child: Container(
        width: 81,
        height: 87,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFFFF), Color(0x1A696969)],
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(category!['icon'] ?? '', width: 45, height: 45),
              SizedBox(height: 6),
              Text(
                category!['title'] ?? 'Category',
                style: textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
