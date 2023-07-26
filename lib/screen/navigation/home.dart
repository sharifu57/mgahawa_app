import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/models/categoryModel.dart';
import 'package:mgahawa_app/services/api.dart';
import 'package:mgahawa_app/services/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final endpoint = '${config['apiBaseUrl']}/categories';
  List<Category> categories = [];

  Future getCategories() async {
    final response = await getRequest(endpoint);

    if (response != null) {
      List<dynamic> responseData = response.data;
      if (responseData.isNotEmpty) {
        List<Category> fetchedCategories = responseData
            .map((categoryData) => Category.fromJson(categoryData))
            .toList();

        setState(() {
          categories = fetchedCategories;
        });
        print("____show categories");
        print(categories);
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

      print("______show the name");
      print(locationName);
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getCategories();
    _getLocationPermission();
    _getCurrentLocation();
  }

  String? locationName;
  var padding = EdgeInsets.only(left: 30, right: 30, top: 20);

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
                style: TextStyle(fontSize: 13),
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
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20, top: 20),
                child: SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: Card(
                    color: AppColors.secondaryColor,
                    child: Text("Barners"),
                  ),
                ),
              ),
            ),
            Container(
              padding: padding,
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                  hintText: "Search here..",
                  prefixIcon: Icon(
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
                    Container(
                      height: 50,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.isEmpty ? 0 : categories.length,
                          itemBuilder: (BuildContext context, index) {
                            Category category = categories[index];
                            return Container(
                              child: Text(category.name ?? ''),
                            );
                          }),
                    )
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



// return SingleChildScrollView(
    //     child: Container(
    //   color: Colors.white,
    //   height: fullHeight,
    //   width: fullWidth,
    //   child: Scaffold(
    //     body: Column(
    //       children: [
    //         Container(
    //           padding: EdgeInsets.only(
    //             top: 50,
    //             left: 10,
    //             right: 10,
    //           ),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Container(
    //                   child: IconButton(
    //                 onPressed: () {},
    //                 icon: Icon(Icons.auto_awesome_mosaic_rounded),
    //                 color: AppColors.primaryColor,
    //               )),
    //               Container(
    //                 child: Column(
    //                   children: [Text("Location"), Text("${locationName}")],
    //                 ),
    //               ),
    //               Container(
    //                   child: IconButton(
    //                 onPressed: () {},
    //                 icon: Icon(Icons.shopping_cart_checkout),
    //                 color: AppColors.primaryColor,
    //               ))
    //             ],
    //           ),
    //         ),
    //         Container(
    //           padding: EdgeInsets.only(left: 20, right: 20, top: 20),
    //           child: SizedBox(
    //             height: 150,
    //             width: double.infinity,
    //             child: Card(
    //               color: AppColors.secondaryColor,
    //               child: Text("Barners"),
    //             ),
    //           ),
    //         ),
    //         Container(
    //           pContainer(
    //           padding: padding,
    //           child: ListView.builder(
    //             itemCount: categories.length,
    //             itemBuilder: (context, index) {
    //               Category category = categories[index];
    //               return ListTile(
    //                 title: Text(category.name ?? ""),
    //                 subtitle: Text(category.code ?? ""),
    //                 // Add any other widgets or UI components to display additional information about the category.
    //               );
    //             },
    //           ),
    //         )adding: padding,
    //           child: TextFormField(
    //             decoration: InputDecoration(
    //               contentPadding: EdgeInsets.symmetric(vertical: 15.0),
    //               hintText: "Search here..",
    //               prefixIcon: Icon(
    //                 Icons.search,
    //                 size: 14,
    //               ),
    //               border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(30)),
    //             ),
    //           ),
    //         ),
    //         Container(
    //           padding: padding,
    //           child: ListView.builder(
    //             itemCount: categories.length,
    //             itemBuilder: (context, index) {
    //               Category category = categories[index];
    //               return ListTile(
    //                 title: Text(category.name ?? ""),
    //                 subtitle: Text(category.code ?? ""),
    //                 // Add any other widgets or UI components to display additional information about the category.
    //               );
    //             },
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // ));
