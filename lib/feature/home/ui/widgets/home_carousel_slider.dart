import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tastify/app/assets_path.dart';

class HomeCarouselSlider extends StatefulWidget {
   HomeCarouselSlider({super.key, required this.sliderImages});

  List<Map<String, dynamic>> sliderImages = [];

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  int _selectedSlider=0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                autoPlay: true,
                height: 186,
                viewportFraction: 1,
                onPageChanged: (index,reason){
                  _selectedSlider=index;
                  setState(() {});
                }
            ),
            items: widget.sliderImages.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(image: NetworkImage(image['image'],
                          ),
                          fit: BoxFit.fill,
                          )
                      ),

                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 8,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i=0;i<widget.sliderImages.length;i++)
                Container(
                  width: _selectedSlider==i ? 22: 8,
                  height: 8,
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    //border: _selectedSlider==i ? Border.all(color: Colors.deepOrange.withOpacity(0.7)) : Border.all(color: Colors.orange.withOpacity(0.8)),
                    color: _selectedSlider==i ? Colors.deepOrange.withOpacity(0.7): Color(0xffff9763),
                  ),
                )

            ],
          )
        ],
      ),
    );
  }
}
