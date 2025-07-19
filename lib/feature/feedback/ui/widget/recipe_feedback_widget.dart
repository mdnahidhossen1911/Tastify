import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';
import 'package:tastify/core/utc_to_local_date.dart';

class RecipeFeedbackWidget extends StatelessWidget {
  const RecipeFeedbackWidget({super.key, required this.feedback});

  final Map<String, dynamic> feedback;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepOrange.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.memory(
                      base64Decode(feedback['recipe']['photo']),
                      width: 80,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      feedback['recipe']['title'] ?? 'Recipe Name',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      feedback['Users']['photo'] != null
                          ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.memory(
                              base64Decode(feedback['Users']['photo']),
                              width: 22,
                              height: 22,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return CircleAvatar(
                                  radius: 12,
                                  child: Image.asset(
                                    AssetsPath.profileImagePNG,
                                  ),
                                );
                              },
                            ),
                          )
                          : CircleAvatar(
                            radius: 12,
                            child: Image.asset(AssetsPath.profileImagePNG),
                          ),

                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  feedback['Users']['name'] ?? 'Anonymous',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                                SizedBox(width: 5),
                                CircleAvatar(
                                  radius: 2,
                                  backgroundColor: Colors.grey,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  formatUtcToLocalDate(
                                    feedback['created_at'] ?? '',
                                  ),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Text(
                              feedback['feedback'] ?? 'No comment provided',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
