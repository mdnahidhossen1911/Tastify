import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/component/category_item_widget.dart';
import '../../../../res/component/circle_progress.dart';
import '../../controller/category_controller.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  static const String name = '/category';

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text('Category', style: textTheme.titleLarge)),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GetBuilder<CategoryController>(
          builder: (controller) {
            return controller.isLoading
                ? Center(child: circleProgress())
                : GridView.builder(
                  itemCount: controller.categoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return FittedBox(
                      child: CategoryItemWidget(
                        category: controller.categoryList[index],
                      ),
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
