import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tastify/app/app_colors.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  static const String name='/add-recipe-screen';

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {

  XFile? _pickedImage;

  final TextEditingController _recipeNameTEController=TextEditingController();
  final TextEditingController _recipeDescriptionTEController=TextEditingController();
  final TextEditingController _recipePrepTimeTEController=TextEditingController();
  final TextEditingController _recipeCookTimeTEController=TextEditingController();
  final TextEditingController _recipeIngredientsTEController=TextEditingController();
  final TextEditingController _recipeInstructionsTEController=TextEditingController();
  final TextEditingController _recipeNutritionInfoTEController=TextEditingController();

  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Recipe',style: textTheme.titleLarge,),
            TextButton(onPressed: (){}, child: Text('Add',style: TextStyle(color: AppColor.themeColor,fontWeight: FontWeight.bold,fontSize: 30),))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImagePicker(),
                  SizedBox(height: 10,),
                  TextFormField(
                    controller: _recipeNameTEController,
                    decoration: InputDecoration(
                      hintText: 'Recipe Name',
                      hintStyle: TextStyle(color: AppColor.themeColor,fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:BorderSide(color: AppColor.themeColor)
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:BorderSide(color: AppColor.themeColor)
                      ),
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter recipe name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    maxLines: 4,
                    controller: _recipeDescriptionTEController,
                    decoration: InputDecoration(
                      hintText: 'Add Descriptions',
                      hintStyle: TextStyle(color: AppColor.themeColor),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:BorderSide(color: AppColor.themeColor)
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:BorderSide(color: AppColor.themeColor)
                      ),
                    ),
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter recipe details';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  Text('Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.themeColor)),
                  SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColor.themeColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: AppColor.themeColor),
                      ),

                    ),
                    value: _selectedCategory,
                    hint: Text('Select a Category',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 15),),
                    items: ['Breakfast', 'Lunch', 'Dinner', 'Snacks'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedCategory = newValue;
                      });
                    },
                    validator: (value) => value == null ? 'Please select a category' : null,
                  ),
                  SizedBox(height: 10,),
                  Row(

                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Prep Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.themeColor)),
                            SizedBox(height: 3,),
                            TextFormField(
                              controller: _recipePrepTimeTEController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '0 min',
                                hintStyle: TextStyle(color: AppColor.themeColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColor.themeColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColor.themeColor),
                                )
                              ),
                              validator: (String? value){
                                if(value?.trim().isEmpty ?? true){
                                  return 'Enter prepared time';
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Cook Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.themeColor)),
                            SizedBox(height: 3,),
                            TextFormField(
                              controller: _recipeCookTimeTEController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '0 min',
                                hintStyle: TextStyle(color: AppColor.themeColor),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColor.themeColor),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: AppColor.themeColor),
                                )
                              ),
                              validator: (String? value){
                                if(value?.trim().isEmpty ?? true){
                                  return 'Enter cook time';
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.themeColor)),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: _recipeIngredientsTEController,
                    decoration: InputDecoration(
                      hintText: 'All ingredients',
                      hintStyle: TextStyle(color: AppColor.themeColor,fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:BorderSide(color: AppColor.themeColor)
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:BorderSide(color: AppColor.themeColor)
                      ),
                    ),
                    maxLines: 3,
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter recipe ingredients';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  Text('Instructions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.themeColor)),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: _recipeInstructionsTEController,
                    decoration: InputDecoration(
                      hintText: 'Write cook instructions',
                      hintStyle: TextStyle(color: AppColor.themeColor,fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:BorderSide(color: AppColor.themeColor)
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:BorderSide(color: AppColor.themeColor)
                      ),
                    ),
                    maxLines: 3,
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter recipe cooking instructions';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10,),
                  Text('Nutrition Info', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: AppColor.themeColor)),
                  SizedBox(height: 5,),
                  TextFormField(
                    controller: _recipeNutritionInfoTEController,
                    decoration: InputDecoration(
                      hintText: 'All ingredients',
                      hintStyle: TextStyle(color: AppColor.themeColor,fontWeight: FontWeight.bold),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:BorderSide(color: AppColor.themeColor)
                      ),
                      border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:BorderSide(color: AppColor.themeColor)
                      ),
                    ),
                    maxLines: 3,
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true){
                        return 'Enter recipe nutrition info';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
        ),
      ),

    );
  }

  Widget _buildImagePicker() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Color(0xFFf9dad4),
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: _pickedImage == null
            ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.photo_filter_outlined, size: 30, color: AppColor.themeColor),
            SizedBox(width: 8),
            Text(
              'Add Image',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColor.themeColor),
            ),
          ],
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.file(
            File(_pickedImage!.path),
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }


  Future<void> _pickImage() async{
    print('Hello');
    ImagePicker picker=ImagePicker();
    XFile? image=await picker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      _pickedImage=image;
      setState(() {});
    }
  }
}
