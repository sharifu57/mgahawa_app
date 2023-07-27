import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/models/categoryModel.dart';
import 'package:mgahawa_app/models/foodModel.dart';
import 'package:mgahawa_app/screen/pages/checkout.dart';
import 'package:mgahawa_app/services/api.dart';
import 'package:mgahawa_app/services/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final categoriesApi = '${config['apiBaseUrl']}/categories';
  final foodItemApi = '${config['apiBaseUrl']}/fooditems';
  List<Category> categories = [];
  List<FoodItem> foods = [];
  List<FoodItem> _ckeckoutList = [];

  Future getFoodItems() async {
    final response = await getRequest(foodItemApi);

    if (response != null) {
      List<dynamic> responseData = response.data;
      if (responseData.isNotEmpty) {
        List<FoodItem> fetchedFoods = responseData
            .map((foodData) => FoodItem.fromJson(foodData))
            .toList();

        setState(() {
          foods = fetchedFoods;
        });
      }
    }
  }

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

  void handleItemClick(FoodItem item) {
    print("add new item____");
    setState(() {
      if (_ckeckoutList.contains(item)) {
        _ckeckoutList.remove(item);
      } else {
        _ckeckoutList.add(item);
      }
    });
    print("end of new item___");
  }

  void navigateToCheckoutList() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CheckoutListScreen(checkoutList: _ckeckoutList),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getCategories();
    getFoodItems();
    _getLocationPermission();
    _getCurrentLocation();
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
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart_checkout),
            color: AppColors.primaryColor,
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
                                onTap: () {
                                  print("______button_________****");
                                  print(
                                    "________card ${index}",
                                  );
                                },
                                child: IconButton(
                                    onPressed: () {
                                      print("______tapping one");
                                      navigateToCheckoutList;
                                    },
                                    icon: const Icon(
                                      Icons.shopping_cart_sharp,
                                      color: AppColors.primaryColor,
                                    )));
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
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 7.0,
                            ),
                            itemCount: foods.isEmpty ? 0 : foods.length,
                            itemBuilder: (BuildContext context, int index) {
                              FoodItem food = foods[index];
                              bool isSelected = _ckeckoutList.contains(food);
                              return IgnorePointer(
                                child: GestureDetector(
                                  onTap: () => handleItemClick(food),
                                  child: Card(
                                    elevation: isSelected ? 4.0 : 2.0,
                                    color: isSelected
                                        ? Colors.blue.withOpacity(0.3)
                                        : Colors.white,
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.network(
                                            '${food.image}',
                                            fit: BoxFit.contain,
                                            width: fullWidth,
                                            height: fullHeight / 4,
                                          ),
                                        )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${food.name}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Text(
                                                    "TZS ",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    "${food.price}",
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }))
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
