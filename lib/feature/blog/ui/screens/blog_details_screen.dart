import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';
import 'package:tastify/core/utc_to_local_date.dart';

class BlogDetailsScreen extends StatelessWidget {
  const BlogDetailsScreen({super.key, required this.blogDetails});

  final Map<String, dynamic> blogDetails;

  static String name = '/blog-details-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0, forceMaterialTransparency: true),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.memory(
                        base64Decode(blogDetails['image'] ?? ''),
                        width: double.infinity,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      blogDetails['title'] ?? 'Blog Title',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.grey.shade200,
                          child: Image.asset(AssetsPath.profileImagePNG),
                        ),
                        SizedBox(width: 4),
                        Text(
                          blogDetails['Users']['name'] ?? 'Author',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.circle, size: 3.5, color: Colors.grey),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            formatUtcToLocalDate(blogDetails['created_at'] ?? ''),
                            style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontSize: 12
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      blogDetails['content'] ?? 'Blog content goes here.',
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
