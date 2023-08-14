import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/models/categoryModel.dart';
import 'package:mgahawa_app/models/product.dart';
import 'package:mgahawa_app/screen/pages/checkout.dart';
import 'package:mgahawa_app/services/api.dart';
import 'package:mgahawa_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final categoriesApi = '${config['apiBaseUrl']}/categories';
  final foodItemApi = '${config['apiBaseUrl']}/fooditems';
  List<Category> categories = [];
  List<Product> foods = [];
  List<Product> _ckeckoutList = [];

  // Future getFoodItems() async {
  //   final response = await getRequest(foodItemApi);

  //   print("_____food response");
  //   print(response);
  //   print("____end food response");

  //   if (response != null) {
  //     List<dynamic> responseData = response.data;
  //     if (responseData.isNotEmpty) {
  //       List<FoodItem> fetchedFoods = responseData
  //           .map((foodData) => FoodItem.fromJson(foodData))
  //           .toList();

  //       setState(() {
  //         foods = fetchedFoods;
  //       });
  //     }
  //   }
  // }

  Future getCategories() async {
    final response = await getRequest(categoriesApi);

    if (response != null) {
      List<dynamic> responseData = response.data;
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

  Future<void> _getLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Handle the case when the user denies the location permission
      }
    }
    // Permission granted, you can now proceed to get the location.
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      double latitude = position.latitude;
      double longitude = position.longitude;

      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];

      String? currentLocationName =
          place.name; // Location name, e.g., "Kigamboni"

      // Do something with the currentLocationName, like displaying it on the UI.

      setState(() {
        locationName = currentLocationName;
      });
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  // void handleItemClick(FoodItem item) async {
  //   setState(() {
  //     if (_ckeckoutList.contains(item)) {
  //       _ckeckoutList.remove(item);
  //     } else {
  //       _ckeckoutList.add(item);
  //     }
  //   });

  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> checkoutListIds =
  //       _ckeckoutList.map((item) => item.id.toString()).cast<String>().toList();

  //   await prefs.setStringList('_ckeckoutList', checkoutListIds);
  //   print(checkoutListIds);
  //   print("end of new item___");
  // }

  // void _loadCheckoutListFromPrefs() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? checkoutListIds = prefs.getStringList('_ckeckoutList');

  //   if (checkoutListIds != null && checkoutListIds.isNotEmpty) {
  //     List<FoodItem> loadedCheckoutList = [];

  //     for (String id in checkoutListIds) {
  //       FoodItem foundItem = foods.firstWhere(
  //         (item) => item.id.toString() == id,
  //         orElse: () => FoodItem(
  //             id: -1,
  //             name: 'Not Found',
  //             price: '0',
  //             image: '',
  //             quantity: 1,
  //             description: ''),
  //       );

  //       // Check if the item was found and it's not the dummy "Not Found" item
  //       if (foundItem.id != -1) {
  //         loadedCheckoutList.add(foundItem);
  //       }
  //     }

  //     setState(() {
  //       _ckeckoutList = loadedCheckoutList;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getCategories();
    // getFoodItems();
    _getLocationPermission();
    _getCurrentLocation();
    // _loadCheckoutListFromPrefs();
  }

  String? locationName;
  var padding = const EdgeInsets.only(left: 30, right: 30, top: 20);

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            children: [
              const Text(
                "Location",
                style: TextStyle(fontSize: 13),
              ),
              Text(
                "$locationName",
                style: const TextStyle(fontSize: 13),
              )
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 15),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.shopping_cart_checkout,
                      color: AppColors.primaryColor,
                    )),
                Text(
                  '${_ckeckoutList.length}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                      fontSize: 19),
                )
              ],
            ),
          )
        ], //<Widget>[]
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.auto_awesome_mosaic_rounded),
          color: AppColors.primaryColor,
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: const SizedBox(
                height: 150,
                width: double.infinity,
                child: Card(
                  color: AppColors.secondaryColor,
                  child: Text("Barners"),
                ),
              ),
            ),
            Container(
              padding: padding,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                  hintText: "Search here..",
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 14,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            Container(
              padding: padding,
              child: SizedBox(
                height: fullHeight,
                width: fullWidth,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.isEmpty ? 0 : categories.length,
                          itemBuilder: (BuildContext context, index) {
                            Category category = categories[index];
                            return GestureDetector(
                              onTap: () {},
                              child: Card(
                                  color: index == 0
                                      ? AppColors.secondaryColor
                                      : Colors.white,
                                  child: Center(
                                      child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 15),
                                          child: Text(
                                            category.name ?? '',
                                            style: TextStyle(
                                                color: index == 0
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontWeight: FontWeight.w500),
                                          )))),
                            );
                          }),
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 20),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Popular",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    ),
                    Expanded(
                        child: foods.isEmpty
                            ? Center(
                                child: Column(
                                  children: [
                                    Icon(Icons.emoji_people),
                                    CircularProgressIndicator(
                                      strokeWidth: 1,
                                      color: AppColors.primaryColor,
                                    )
                                  ],
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.75,
                                  mainAxisSpacing: 5.0,
                                  crossAxisSpacing: 7.0,
                                ),
                                itemCount: foods.isEmpty ? 0 : foods.length,
                                itemBuilder:
                                    (BuildContext context, int index) {}))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
