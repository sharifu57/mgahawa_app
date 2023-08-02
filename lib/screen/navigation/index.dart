import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/includes/dimensions.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    int cartItemCount = 0;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title:
              Center(child: Text("0657871769/0744939220", style: myTextStyle))),
      body: Container(
        height: fullHeight,
        child: Column(
          children: [
            Container(
              child: AppBar(
                elevation: 10,
                leading: Center(
                  child: Container(
                    child: Text('Logo'),
                  ),
                ),
                actions: [
                  Stack(
                    children: [
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () {
                          // Add your onPressed functionality here
                        },
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '$cartItemCount',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: fullHeight / 5,
              width: fullWidth,
              child: CarouselSlider.builder(
                  itemCount: 5,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.97,
                    aspectRatio: 2.0,
                    initialPage: 2,
                  ),
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      Container(
                        width: fullWidth,
                        child: Card(
                          color: AppColors.secondaryColor,
                          child: Text("ONe"),
                        ),
                      )),
            ),
            Container(
                padding: EdgeInsets.only(top: 20, left: 20),
                alignment: Alignment.centerLeft,
                child: ElevatedButton(
                    onPressed: () {}, child: Text("Types of Foods")))
          ],
        ),
      ),
    );
  }
}
