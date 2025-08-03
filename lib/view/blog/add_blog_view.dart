import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tastify/view_model/view_models.dart';

import '../../res/app_colors.dart';
import '../../res/component/circle_progress.dart';
import '../../utils/utils.dart';

class AddBlogView extends StatefulWidget {
  const AddBlogView({super.key});

  static const String name = '/add-blog';

  @override
  State<AddBlogView> createState() => _AddBlogViewState();
}

class _AddBlogViewState extends State<AddBlogView> {
  XFile? _pickedImage;
  String imageString = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  late BlogViewModel _blogViewModel;

  @override
  Widget build(BuildContext context) {
    _blogViewModel = Provider.of<BlogViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          'Add Blog',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          Consumer<BlogViewModel>(
            builder: (context, value, child) {
              return value.isLoading
                  ? circleProgress()
                  : ElevatedButton(
                    onPressed: () {
                      blogPost();
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
                  );
            },
          ),
          SizedBox(width: 12),
        ],
      ),

      body: ColoredBox(
        color: Colors.deepOrangeAccent.shade100.withOpacity(0.03),
        child: SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SizedBox(height: 16),
                  _buildImagePicker(),
                  SizedBox(height: 16),
                  _buildNameAndSes(),
                ],
              ),
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
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              minLines: 1,
              maxLines: 4,
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Title',
                hintStyle: _hinttextStyle(),
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter Title';
                }
                return null;
              },
            ),
            SizedBox(height: 10),
            TextFormField(
              minLines: 6,
              maxLines: null,
              controller: _contentController,
              keyboardType: TextInputType.multiline,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                hintText: 'Content',
                hintStyle: _hinttextStyle(),
              ),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter Content';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _hinttextStyle() => TextStyle(
    color: Colors.deepOrangeAccent.shade100,
    fontWeight: FontWeight.w600,
  );

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

  blogPost() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (_pickedImage != null) {
        final bytes = await _pickedImage!.readAsBytes();
        String imageString = base64Encode(bytes);

        bool isSuccess = await _blogViewModel.addBlog({
          'title': _titleController.text.trim(),
          'content': _contentController.text.trim(),
          'uid': AuthViewModel.uid,
          'image': imageString,
        });

        if (isSuccess) {
          Utils.showToast('Blog added successfully');
          context.pop();
        }
      }
    } else {
      Utils.showFlushBar(context, 'Please select an image');
    }
  }
}
