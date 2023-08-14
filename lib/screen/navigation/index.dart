import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mgahawa_app/components/navbar.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/includes/dimensions.dart';
import 'package:mgahawa_app/models/categoryModel.dart';
import 'package:mgahawa_app/screen/pages/category/view_category.dart';
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
        title: Center(child: Text("0657871769/0744939220", style: myTextStyle)),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: const Color.fromARGB(255, 255, 255, 254),
          height: fullHeight,
          child: Column(
            children: [
              Container(
                child: NavBar(),
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
                        SizedBox(
                          width: fullWidth,
                          child: Card(
                            color: AppColors.secondaryColor,
                            child: Text("${IndexPage}"),
                          ),
                        )),
              ),
              Container(
                  padding: const EdgeInsets.only(top: 20, left: 20),
                  alignment: Alignment.centerLeft,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("Types of Foods"))),
              Expanded(
                  child: Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewCategory(
                                      categoryName: '${item.name}',
                                      categoryId: '${item.id}',
                                      category: '$item')));
                        },
                        child: Card(
                          color: Colors.white,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Container(
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
                              )),
                              Container(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "${item.name}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
