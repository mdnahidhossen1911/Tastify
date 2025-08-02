import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tastify/service_locator.dart';
import 'package:tastify/view_model/update_profile_view_model.dart';

import '../../res/app_colors.dart';
import '../../res/assets_path.dart';
import '../../res/component/circle_progress.dart';
import '../../res/component/screen_background.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  static const String name = '/profile-edit';

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  @override
  void initState() {
    // TODO: implement initState
    photoString.value = AuthViewModel().getPhoto;
    nameController.text = AuthViewModel().getUserName;
    emailController.text = AuthViewModel().getGmail;
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxString photoString = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16),
                    CircleAvatar(
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                    SizedBox(height: 60),
                    Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: DottedBorder(
                                options: CircularDottedBorderOptions(
                                  padding: const EdgeInsets.all(0),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Colors.deepOrange.shade300,
                                      Colors.deepOrange.shade200,
                                    ],
                                  ),
                                  strokeWidth: 2.8,
                                  dashPattern: [20, 5],
                                ),
                                child: Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(80),
                                      // circular clipping
                                      child: Image.memory(
                                        base64Decode(photoString.value),
                                        width: 112,
                                        height: 112,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Image.asset(
                                            AssetsPath.profileImagePNG,
                                            width: 112,
                                            height: 112,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 80,
                              left: 80,
                              child: CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    _pickImage();
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 16),
                        Text(
                          'Edit Profile',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Update your profile information',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 32),
                        TextField(
                          controller: nameController,
                          decoration: InputDecoration(hintText: 'Name'),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: emailController,
                          enabled: false,
                          decoration: InputDecoration(hintText: 'Email'),
                        ),
                        SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ChangeNotifierProvider(
                            create:
                                (context) => locator<UpdateProfileViewModel>(),
                            child: Consumer<UpdateProfileViewModel>(
                              builder: (context, value, child) {
                                return value.isLoading
                                    ? circleProgress()
                                    : ElevatedButton(
                                      onPressed: () async {
                                        final isSuccess = await value
                                            .updateProfile(
                                              nameController.text.trim(),
                                              photoString.value,
                                            );

                                        if (isSuccess) {
                                          Utils.showToast(
                                            'Profile updated successfully',
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColor.themeColor,
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        "Update",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
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
      XFile _pickedImage = image;
      photoString.value = base64Encode(await _pickedImage.readAsBytes());
    }
  }
}
