import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/includes/dimensions.dart';
import 'package:mgahawa_app/models/categoryModel.dart';
import 'package:mgahawa_app/services/api.dart';
import 'package:mgahawa_app/services/config.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final categoriesApi = '${config['apiBaseUrl']}/categories';
  List<Category> categories = [];
  Future getCategories() async {
    final response = await getRequest(categoriesApi);

    if (response != null) {
      List<dynamic> responseData = response.data;
      print(
        "___get categories ${categories}",
      );
      if (responseData.isNotEmpty) {
        List<Category> fetchedCategories = responseData
            .map((categoryData) => Category.fromJson(categoryData))
            .toList();

        setState(() {
          categories = fetchedCategories;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    final CarouselController _carouselController = CarouselController();
    final Tween<double> _opacityTween = Tween<double>(begin: 0.0, end: 1.0);

    int cartItemCount = 0;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title:
              Center(child: Text("0657871769/0744939220", style: myTextStyle))),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 254),
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
                      initialPage: 1,
                    ),
                    itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) =>
                        Container(
                          width: fullWidth,
                          child: Card(
                            color: AppColors.secondaryColor,
                            child: Text("${IndexPage}"),
                          ),
                        )),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20, left: 20),
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                      onPressed: () {}, child: Text("Types of Foods"))),

              Expanded(
                  child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      mainAxisSpacing: 5.0,
                      crossAxisSpacing: 7.0,
                    ),
                    itemCount: categories.isEmpty ? 0 : categories.length,
                    shrinkWrap:
                        true, // Set shrinkWrap to true to disable the GridView's internal scrolling behavior
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      Category item = categories[index];
                      return Card(
                        color: Colors.white,
                        child: item.icon == null
                            ? Icon(
                                Icons.food_bank,
                                color: Colors.black,
                                size: 50,
                              )
                            : Image.network(
                                '${item.icon}',
                                fit: BoxFit.contain,
                                width: fullWidth,
                                height: fullHeight / 4,
                              ),
                      );
                    }),
              ))
              // Expanded(
              //     child: foods.isEmpty
              //         ? Center(
              //             child: Column(
              //               children: [
              //                 Icon(Icons.emoji_people),
              //                 CircularProgressIndicator(
              //                   strokeWidth: 1,
              //                   color: AppColors.primaryColor,
              //                 )
              //               ],
              //             ),
              //           )
              //         : GridView.builder(
              //             gridDelegate:
              //                 const SliverGridDelegateWithFixedCrossAxisCount(
              //               crossAxisCount: 2,
              //               childAspectRatio: 0.75,
              //               mainAxisSpacing: 5.0,
              //               crossAxisSpacing: 7.0,
              //             ),
              //             itemCount: foods.isEmpty ? 0 : foods.length,
              //             itemBuilder: (BuildContext context, int index) {
              //               FoodItem item = foods[index];
              //               bool isSelected = _ckeckoutList.contains(item);
              //               return GestureDetector(
              //                 onTap: () {
              //                   handleItemClick(item);

              //                   ScaffoldMessenger.of(context)
              //                       .showSnackBar(SnackBar(
              //                     content: isSelected
              //                         ? Text('Removed from the cart')
              //                         : Text("Added to Cart"),
              //                     duration: const Duration(seconds: 1),
              //                     action: SnackBarAction(
              //                       label: 'ACTION',
              //                       onPressed: () {},
              //                     ),
              //                   ));
              //                 },
              //                 child: Card(
              //                   color: isSelected ? Colors.red : Colors.white,
              //                   child: Column(
              //                     children: [
              //                       Expanded(
              //                           child: ClipRRect(
              //                         borderRadius: BorderRadius.circular(5),
              //                         child: Image.network(
              //                           '${item.image}',
              //                           fit: BoxFit.contain,
              //                           width: fullWidth,
              //                           height: fullHeight / 4,
              //                         ),
              //                       )),
              //                       const SizedBox(
              //                         height: 10,
              //                       ),
              //                       Container(
              //                         padding: const EdgeInsets.fromLTRB(
              //                             10, 10, 10, 0),
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Text(
              //                               "${item.name}",
              //                               style: const TextStyle(
              //                                   fontSize: 12,
              //                                   fontWeight: FontWeight.w500),
              //                             ),
              //                           ],
              //                         ),
              //                       ),
              //                       Container(
              //                         padding:
              //                             const EdgeInsets.fromLTRB(10, 0, 0, 0),
              //                         child: Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                           children: [
              //                             Row(
              //                               children: [
              //                                 const Text(
              //                                   "TZS ",
              //                                   style: TextStyle(
              //                                       fontSize: 12,
              //                                       fontWeight: FontWeight.w500),
              //                                 ),
              //                                 Text(
              //                                   "${item.price}",
              //                                   style: const TextStyle(
              //                                       fontSize: 12,
              //                                       fontWeight: FontWeight.w500),
              //                                 ),
              //                               ],
              //                             ),
              //                             IconButton(
              //                                 onPressed: () {
              //                                   print("______tapping one");
              //                                   Navigator.push(
              //                                     context,
              //                                     MaterialPageRoute(
              //                                       builder: (context) =>
              //                                           CheckoutListScreen(
              //                                         checkoutList: _ckeckoutList,
              //                                         onDismiss: (FoodItem) {},
              //                                       ),
              //                                     ),
              //                                   );
              //                                 },
              //                                 icon: const Icon(
              //                                   Icons.shopping_cart_sharp,
              //                                   color: AppColors.primaryColor,
              //                                 ))
              //                           ],
              //                         ),
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               );
              //             }))
            ],
          ),
        ),
      ),
    );
  }
}
