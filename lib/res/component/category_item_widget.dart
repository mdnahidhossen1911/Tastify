import 'package:flutter/material.dart';

import '../../view/category/ui/screen/category_wise_list_screen.dart';

class CategoryItemWidget extends StatelessWidget {
  CategoryItemWidget({super.key, this.category});
  Map<String, dynamic>? category;

  @override
  Widget build(BuildContext context) {
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
            colors: [
              Color.fromRGBO(255, 255, 255, 1), // White at the top
              Color.fromRGBO(240, 240, 240, 1),
            ],
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
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
