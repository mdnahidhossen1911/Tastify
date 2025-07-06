import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({super.key});

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  int _selectedSlider=0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              autoPlay: true,
              height: 200,
              viewportFraction: 1,
              onPageChanged: (index,reason){
                _selectedSlider=index;
                setState(() {});
              }
          ),
          items: [1,2,3,4,5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(image: AssetImage(AssetsPath.carouselImagePNG))
                    ),
                    child: Text('text $i', style: TextStyle(fontSize: 16.0),)
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 8,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for(int i=0;i<5;i++)
              Container(
                width: _selectedSlider==i ? 20: 10,
                height: 10,
                margin: EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  //border: _selectedSlider==i ? Border.all(color: Colors.deepOrange.withOpacity(0.7)) : Border.all(color: Colors.orange.withOpacity(0.8)),
                  color: _selectedSlider==i ? Colors.deepOrange.withOpacity(0.7): Colors.orange.withOpacity(0.8),
                ),
              )

          ],
        )
      ],
    );
  }
}
