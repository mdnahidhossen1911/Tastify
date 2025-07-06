import 'package:flutter/material.dart';
import 'package:tastify/feature/home/ui/controller/carousel_image_controller.dart';

class GoogleSignScreen extends StatefulWidget {
  const GoogleSignScreen({super.key});

  @override
  State<GoogleSignScreen> createState() => _GoogleSignScreenState();
}

class _GoogleSignScreenState extends State<GoogleSignScreen> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google sign'),),
      body: Center(child: ElevatedButton(onPressed: () async {

       final data = await CarouselImageController.getImage();
       print(data.responseData);

      }, child: Text('sign in')),),
    );
  }
}
