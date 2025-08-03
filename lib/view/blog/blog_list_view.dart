import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tastify/view/views.dart';
import 'package:tastify/view_model/view_models.dart';

import '../../res/app_colors.dart';
import '../../res/component/blog_widget.dart';
import '../../res/component/circle_progress.dart';

class BlogListView extends StatefulWidget {
  const BlogListView({super.key});

  @override
  State<BlogListView> createState() => _BlogListViewState();
}

class _BlogListViewState extends State<BlogListView> {
  late BlogViewModel _blogViewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _blogViewModel.fetchBlogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    _blogViewModel = Provider.of<BlogViewModel>(context, listen: false);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog', style: textTheme.headlineSmall),
        forceMaterialTransparency: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AddBlogView.name);
        },
        elevation: 4,
        child: Icon(Icons.edit, color: AppColor.themeColor),
      ),

      body: Consumer<BlogViewModel>(
        builder: (context, value, child) {
          return value.isLoading
              ? circleProgress()
              : ListView.builder(
                itemCount: value.blogs.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 100),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: BlogWidget(blogData: value.blogs[index]),
                  );
                },
              );
        },
      ),
    );
  }
}
