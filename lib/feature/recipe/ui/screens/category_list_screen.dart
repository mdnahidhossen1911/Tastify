import 'package:flutter/material.dart';
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
        child: GridView.builder(
          itemCount: 20,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,mainAxisSpacing: 16),
          itemBuilder: (context,index){
            return FittedBox(child: CategoryItemWidget());
          },
        ),
      ),
    );
  }
}
