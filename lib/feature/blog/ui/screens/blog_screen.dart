import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/app/app_colors.dart';
import 'package:tastify/core/utils/circle_progress.dart';
import 'package:tastify/feature/blog/ui/controller/blog_controller.dart';
import 'package:tastify/feature/blog/ui/screens/add_blog_screen.dart';
import 'package:tastify/feature/blog/ui/widget/blog_widget.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  final BlogController _blogController = Get.find<BlogController>();

  @override
  void initState() {
    // TODO: implement initState
    _blogController.fetchBlogs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Blog', style: textTheme.titleLarge),
        forceMaterialTransparency: true,
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddBlogScreen.name);
        },
        elevation: 4,
        child: Icon(Icons.edit, color: AppColor.themeColor),
      ),

      body: GetBuilder(
        init: _blogController,
        builder: (controller) {
          return controller.isLoading
              ? circleProgress()
              : ListView.builder(
                itemCount: controller.blogs.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 100),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: BlogWidget(blogData: controller.blogs[index],),
                  );
                },
              );
        },
      ),
    );
  }
}
