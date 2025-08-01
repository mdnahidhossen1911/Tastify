import 'dart:convert';

import 'package:flutter/material.dart';

import '../../utils/utc_to_local_date.dart';
import '../../view/blog/blog_details_screen.dart';
import '../assets_path.dart';

class BlogWidget extends StatelessWidget {
  const BlogWidget({super.key, required this.blogData});

  final Map<String, dynamic> blogData;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          Navigator.pushNamed(
            context,
            BlogDetailsScreen.name,
            arguments: blogData,
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                base64Decode(blogData['image'] ?? ''),
                height: 100,
                width: 150,
                fit: BoxFit.cover,
              ),
            ),

            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    blogData['title'] ?? 'Blog Title',
                    style: textTheme.labelLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    blogData['content'] ??
                        'This is a sample blog content that is quite long and should be truncated if it exceeds the maximum lines allowed.',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(
                          base64Decode(blogData['Users']['photo'] ?? ''),
                          width: 16,
                          height: 16,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return CircleAvatar(
                              radius: 8,
                              child: Image.asset(AssetsPath.profileImagePNG),
                            );
                          },
                        ),
                      ),

                      SizedBox(width: 4),
                      Text(
                        blogData['Users']['name'] ?? 'Author',
                        style: textTheme.labelSmall,
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.circle, size: 3.5, color: Colors.grey),
                      SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          formatUtcToLocalDate(blogData['created_at'] ?? ''),
                          style: textTheme.labelSmall,
                        ),
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
