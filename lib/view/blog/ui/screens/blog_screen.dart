import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../res/app_colors.dart';
import '../../../../res/component/blog_widget.dart';
import '../../../../res/component/circle_progress.dart';
import '../../../../view_model/blog_view_model.dart';
import 'add_blog_screen.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
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
          Navigator.pushNamed(context, AddBlogScreen.name);
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
