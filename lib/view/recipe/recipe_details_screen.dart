import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/service_locator.dart';
import 'package:tastify/view_model/add_feedback_view_model.dart';
import 'package:tastify/view_model/auth_view_model.dart';

import '../../../../res/component/circle_progress.dart';
import '../../../../utils/app_logger.dart';
import '../../../../utils/utils.dart';

class RecipeDetailsScreen extends StatefulWidget {
  const RecipeDetailsScreen({super.key, required this.recipeDetails});

  final Map<String, dynamic> recipeDetails;

  static const String name = '/recipe-details-screen';

  @override
  State<RecipeDetailsScreen> createState() => _RecipeDetailsScreenState();
}

class _RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  late List<String> ingredients;
  late List<String> instructions;
  late Map<String, dynamic> nutritionInfo;

  TextEditingController feedbackController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    ingredients = List<String>.from(
      jsonDecode(widget.recipeDetails['ingredients']),
    );
    instructions = List<String>.from(
      jsonDecode(widget.recipeDetails['instructions']),
    );
    nutritionInfo = Map<String, dynamic>.from(
      jsonDecode(widget.recipeDetails['nutrition_info']),
    );
  }

  @override
  Widget build(BuildContext context) {
    appLogger.i(widget.recipeDetails);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title: Text(
          widget.recipeDetails['title'],
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                width: double.maxFinite,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(
                    base64Decode(widget.recipeDetails['photo'] ?? ''),
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.recipeDetails['title'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 16),
              _buildTimeCategory(),
              SizedBox(height: 12),
              _buildNutrition(),
              SizedBox(height: 16),
              Text(
                widget.recipeDetails['description'],
                style: TextStyle(color: Colors.black54, fontSize: 15),
              ),
              SizedBox(height: 20),
              _buildIngredients(),
              SizedBox(height: 20),
              _buildInstructions(),
              SizedBox(height: 40),
              _buildSendFeedBack(),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSendFeedBack() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Recipe Feedback',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              maxLines: 3,
              controller: feedbackController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: 'Share your feedback...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your feedback';
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20),
          ChangeNotifierProvider(
            create: (context) => locator<AddFeedbackViewModel>(),
            child: Consumer<AddFeedbackViewModel>(
              builder: (context, value, child) {
                return value.isLoading
                    ? circleProgress(color: Colors.white)
                    : ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          Map<String, dynamic> feedback = {
                            'rid': widget.recipeDetails['id'],
                            'uid': AuthViewModel.uid,
                            'rwid': widget.recipeDetails['user_id'],
                            'feedback': feedbackController.text,
                          };

                          bool isSuccess = await value.addFeedback(feedback);
                          if (isSuccess) {
                            Utils.showToast('Feedback submitted successfully!');
                            feedbackController.clear();
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        fixedSize: Size.fromWidth(double.maxFinite),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredients() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ingredients',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: ingredients.length,
          itemBuilder: (context, index) {
            String ing = ingredients[index];
            return Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, color: Colors.deepOrange, size: 16),
                  SizedBox(width: 10),
                  Expanded(child: Text(ing, style: TextStyle(fontSize: 16))),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInstructions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Instructions',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: instructions.length,
          itemBuilder: (context, index) {
            String instruction = instructions[index];
            return Padding(
              padding: const EdgeInsets.all(6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.check_circle, color: Colors.deepOrange, size: 16),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(instruction, style: TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNutrition() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xb3fff3ea),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nutrition Information',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: nutritionInfo.length,
            separatorBuilder:
                (context, index) =>
                    Divider(color: Colors.deepOrangeAccent.withOpacity(0.4)),
            itemBuilder: (context, index) {
              final key = nutritionInfo.keys.elementAt(index);
              final value = nutritionInfo[key];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    key[0].toUpperCase() + key.substring(1),
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  Text(
                    value.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCategory() {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Color(0xb3fff3ea),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Icon(Icons.timer, size: 24),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prep Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${widget.recipeDetails['prep_time'] ?? '0 Minutes'} min',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.timer, size: 24),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cook Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 11,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${widget.recipeDetails['cook_time'] ?? '0 Minutes'} min',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.restaurant, size: 24),
                SizedBox(width: 5),
                Text(
                  widget.recipeDetails['category_name'] ?? 'Category',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
