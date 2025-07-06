import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';

class Homecategorywidget extends StatelessWidget {
  const Homecategorywidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 140,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(255, 255, 255, 1),    // White at the top
              Color.fromRGBO(240, 240, 240, 1),
            ],
          ),
          borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Image.asset(AssetsPath.categoryMeatlImageJPG, // Replace with your image path
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Breakfast',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
