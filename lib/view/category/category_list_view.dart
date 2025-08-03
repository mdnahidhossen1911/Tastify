import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/view_model/view_models.dart';

import '../../res/component/category_item_widget.dart';
import '../../res/component/circle_progress.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  static const String name = '/category';

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text('Category', style: textTheme.headlineSmall)),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Consumer<CategoryViewModel>(
          builder: (context, value, child) {
            return value.isLoading
                ? Center(child: circleProgress())
                : GridView.builder(
                  itemCount: value.categoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return FittedBox(
                      child: CategoryItemWidget(
                        category: value.categoryList[index],
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
