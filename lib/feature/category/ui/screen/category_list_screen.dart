import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/core/utils/circle_progress.dart';
import 'package:tastify/feature/category/controller/category_controller.dart';
import 'package:tastify/feature/common/ui/widget/category_item_widget.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  static const String name='/category';

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Category',style: textTheme.titleLarge,),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: GetBuilder<CategoryController>(
          builder: (controller) {
            return

              controller.isLoading
                  ? Center(child: circleProgress())
                  : GridView.builder(
              itemCount: controller.categoryList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisSpacing: 16,crossAxisSpacing: 8),
              itemBuilder: (context,index){
                return FittedBox(child: CategoryItemWidget(category: controller.categoryList[index],));
              },
            );
          }
        ),
      ),
    );
  }
}
