import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../model/recipe_model.dart';
import '../../../../res/app_colors.dart';
import '../../../../res/component/circle_progress.dart';
import '../../../../utils/utils.dart';
import '../../../../view_model/get_recipe_view_model.dart';
import '../../../../view_model/recipe_view_model.dart';
import '../../../auth/ui/controller/auth_controller.dart';
import '../../../category/controller/category_controller.dart';
import '../../../home/ui/controller/fetch_popular_item_controller.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  static const String name = '/add-recipe-screen';

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  XFile? _pickedImage;

  final TextEditingController _recipeNameTEController = TextEditingController();
  final TextEditingController _recipeDescriptionTEController =
      TextEditingController();
  final TextEditingController _recipePrepTimeTEController =
      TextEditingController();
  final TextEditingController _recipeCookTimeTEController =
      TextEditingController();

  final List<TextEditingController> ingredients = [TextEditingController()];
  final List<TextEditingController> instructions = [TextEditingController()];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late RecipeViewModel _recipeViewModel;

  String? _selectedCategory;
  String? _selectedCategoryId;

  List<Map<String, TextEditingController>> nutritionControllers = [
    {"key": TextEditingController(), "value": TextEditingController()},
  ];

  void addNutritionField() {
    setState(() {
      nutritionControllers.add({
        "key": TextEditingController(),
        "value": TextEditingController(),
      });
    });
  }

  void removeNutritionField(int index) {
    setState(() {
      nutritionControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    _recipeViewModel = Provider.of<RecipeViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Add Recipe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Consumer<RecipeViewModel>(
              builder: (context, value, child) {
                return Visibility(
                  visible: !value.isLoading,
                  replacement: circleProgress(),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _uploadRecipe();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.themeColor,
                      elevation: 0,
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: ColoredBox(
        color: Colors.deepOrangeAccent.shade100.withOpacity(0.03),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImagePicker(),
                  SizedBox(height: 12),
                  _buildNameAndSes(),
                  SizedBox(height: 12),
                  _buildDetails(),
                  SizedBox(height: 12),
                  _buildIngredients(),
                  SizedBox(height: 12),
                  _buildInstructions(),
                  SizedBox(height: 12),
                  _buildNutritionInfo(),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildNutritionInfo() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Nutrition Information",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColor.themeColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    addNutritionField();
                  });
                },
                child: Text(
                  "+ Add",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          ...nutritionControllers.asMap().entries.map((entry) {
            int index = entry.key;
            var controllers = entry.value;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controllers["key"],
                      decoration: InputDecoration(
                        hintText: "Label (e.g. calories)",
                        hintStyle: _hinttextStyle(),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: controllers["value"],
                      decoration: InputDecoration(
                        hintText: "Value (e.g. 200kcal)",
                        hintStyle: _hinttextStyle(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => removeNutritionField(index),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Container _buildInstructions() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Instructions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColor.themeColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    instructions.add(TextEditingController());
                  });
                },
                child: Text(
                  "+ Add",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: List.generate(instructions.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      child: Text(
                        "${index + 1}",
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColor.themeColor,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: instructions[index],
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: "Describe this step...",
                          hintStyle: _hinttextStyle(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          instructions.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildIngredients() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Ingredients",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: AppColor.themeColor,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    ingredients.add(TextEditingController());
                  });
                },
                child: Text(
                  "+ Add",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ],
          ),
          Column(
            children: List.generate(ingredients.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: ingredients[index],
                        decoration: InputDecoration(
                          hintText: "Ingredient",
                          hintStyle: _hinttextStyle(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          ingredients.removeAt(index);
                        });
                      },
                    ),
                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Category',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: AppColor.themeColor,
            ),
          ),
          SizedBox(height: 5),
          GetBuilder<CategoryController>(
            builder: (controller) {
              return DropdownButtonFormField<String>(
                value: _selectedCategory,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                hint: Text(
                  'Select a Category',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                items:
                    controller.categoryList.map((category) {
                      return DropdownMenuItem<String>(
                        value: category['title'],
                        child: Text(
                          category['title'] ?? '',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                    _selectedCategoryId =
                        controller.categoryList.firstWhere(
                          (category) => category['title'] == newValue,
                          orElse: () => {'id': ''},
                        )['id'];
                  });
                },
                validator:
                    (value) =>
                        value == null ? 'Please select a category' : null,
              );
            },
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prep Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColor.themeColor,
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _recipePrepTimeTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0 min',
                        hintStyle: _hinttextStyle(),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter prepared time';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cook Time',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: AppColor.themeColor,
                      ),
                    ),
                    SizedBox(height: 3),
                    TextFormField(
                      controller: _recipeCookTimeTEController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: '0 min',
                        hintStyle: _hinttextStyle(),
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter cook time';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNameAndSes() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _recipeNameTEController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            decoration: InputDecoration(
              hintText: 'Recipe Name',
              hintStyle: _hinttextStyle(),
            ),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter recipe name';
              }
              return null;
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            maxLines: 4,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: _recipeDescriptionTEController,
            decoration: InputDecoration(
              hintText: 'Add Descriptions',
              hintStyle: _hinttextStyle(),
            ),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Enter recipe details';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  TextStyle _hinttextStyle() => TextStyle(
    color: Colors.deepOrangeAccent.shade100,
    fontWeight: FontWeight.w600,
  );

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 190,
        decoration: BoxDecoration(
          color: Color(0xffffede9),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child:
            _pickedImage == null
                ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate,
                      size: 30,
                      color: AppColor.themeColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Add Image',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.themeColor,
                      ),
                    ),
                  ],
                )
                : ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.file(
                    File(_pickedImage!.path),
                    width: double.infinity,
                    height: 190,
                    fit: BoxFit.cover,
                  ),
                ),
      ),
    );
  }

  Future<void> _pickImage() async {
    ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 200,
      imageQuality: 80,
    );
    if (image != null) {
      _pickedImage = image;
      setState(() {});
    }
  }

  _uploadRecipe() async {
    String recipeName = _recipeNameTEController.text;
    String recipeDescription = _recipeDescriptionTEController.text;
    String prepTime = _recipePrepTimeTEController.text;
    String cookTime = _recipeCookTimeTEController.text;
    String uid = AuthController.uid!;
    late String imageString;

    final ingredientList =
        ingredients
            .map((controller) => controller.text.trim())
            .where((text) => text.isNotEmpty)
            .map((text) => '\"$text\"')
            .toList();

    final instructionList =
        instructions
            .map((controller) => controller.text.trim())
            .where((text) => text.isNotEmpty)
            .map((text) => '\"$text\"')
            .toList();

    final Map<String, String> nutritionInfo = {};
    for (var item in nutritionControllers) {
      final key = item['key']?.text.trim();
      final value = item['value']?.text.trim();
      if (key != null && key.isNotEmpty && value != null && value.isNotEmpty) {
        nutritionInfo['"$key"'] = '"$value"';
      }
    }

    if (_pickedImage != null) {
      final bytes = await _pickedImage?.readAsBytes();
      imageString = base64Encode(bytes!);
    } else {
      Utils.showFlushBar(context, "Please select an image");
      return;
    }

    if (instructionList.isEmpty ||
        ingredientList.isEmpty ||
        nutritionInfo.isEmpty) {
      Utils.showFlushBar(context, "Please fill all fields");
      return;
    }

    RecipeModel model = RecipeModel(
      userId: uid,
      title: recipeName,
      description: recipeDescription,
      prepTime: prepTime,
      cookTime: cookTime,
      photo: imageString,
      cid: _selectedCategoryId ?? '',
      category_name: _selectedCategory ?? '',
      ingredients: ingredientList.toString(),
      instructions: instructionList.toString(),
      nutritionInfo: nutritionInfo.toString(),
    );

    final response = await _recipeViewModel.addRecipe(model);
    if (response.isSuccess) {
      Utils.showToast("Recipe added successfully");

      Provider.of<GetRecipeViewModel>(
        context,
      ).getAllRecipes(AuthController.uid!);
      Get.find<FetchPopularItemController>().getAllRecipes(AuthController.uid!);
      Navigator.pop(context);
    } else {
      Utils.showFlushBar(context, response.errorMessage);
    }
  }
}
