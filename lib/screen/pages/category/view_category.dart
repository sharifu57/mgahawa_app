import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mgahawa_app/components/navbar.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/models/product.dart';
import 'package:mgahawa_app/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/config.dart';

class ViewCategory extends StatefulWidget {
  final String? category;
  final String? categoryId;
  final String? categoryName;
  const ViewCategory(
      {super.key,
      required this.category,
      required this.categoryId,
      required this.categoryName});

  @override
  State<ViewCategory> createState() => _ViewCategoryState();
}

class _ViewCategoryState extends State<ViewCategory> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  List<Product>? products;
  List<Product> cart = [];
  final productsApi = '${config['apiBaseUrl']}/products/';
  Future getProducts() async {
    String url = "$productsApi${widget.categoryId}/";
    final response = await getRequest(url);
    if (response != null) {
      List<dynamic> responseData = response.data;
      if (responseData.isNotEmpty) {
        List<Product> fetchedProducts = responseData
            .map((productData) => Product.fromJson(productData))
            .toList();

        setState(() {
          products = fetchedProducts;
        });
      }
    }
  }

  Future<void> updateProductQuantity(int index, int newQuantity) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (products != null) {
      setState(() {
        products![index].quantity = newQuantity;
      });

      // Save the updated quantity to local storage
      await prefs.setInt('${products![index].id}_quantity', newQuantity);
    }
  }

  Future<void> updateProductInLocalStorage(
      int index, Product updatedProduct) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (products != null) {
      setState(() {
        products![index] = updatedProduct;
      });

      // Convert the updated product to JSON and save to local storage
      String productJson = jsonEncode(updatedProduct.toJson());
      await prefs.setString('${updatedProduct.id}_product', productJson);
    }
  }

  Future<void> addToCart(Product product) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cart.add(product);

    // Convert the cart list to JSON and save to local storage
    String cartJson =
        jsonEncode(cart.map((product) => product.toJson()).toList());
    await prefs.setString('cart', cartJson);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor: AppColors.primaryColor,
          content: Text("${product.name} added to cart")),
    );
  }

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBar(),
        body: RefreshIndicator(
          key: _refreshIndicatorKey,
          color: Colors.white,
          backgroundColor: AppColors.primaryColor,
          strokeWidth: 3.0,
          onRefresh: () async {
            // Replace this delay with the code to be executed during refresh
            // and return a Future when code finishes execution.
            await getProducts();
            return Future<void>.delayed(const Duration(seconds: 3));
          },
          child: Container(
            padding: EdgeInsets.only(left: 0, right: 0, top: 0),
            child: Column(
              children: [
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/screen");
                        },
                        child: const Text("Home")),
                    const Text("/"),
                    Text("${widget.categoryName}")
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: products != null
                      ? Container(
                          padding: const EdgeInsets.only(top: 0),
                          child: const SizedBox(
                            child: Card(
                              child: TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    size: 15,
                                  ),
                                  hintText: 'Search...',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Set border color to transparent
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(
                                          8.0), // Customize the top left border radius
                                      topRight: Radius.circular(
                                          8.0), // Customize the top right border radius
                                      bottomLeft: Radius.circular(
                                          8.0), // Set bottom left border radius to 0
                                      bottomRight: Radius.circular(
                                          8.0), // Set bottom right border radius to 0
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ))
                      : Container(),
                ),
                Expanded(
                    child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  // ignore: unrelated_type_equality_checks
                  child: products != null
                      ? GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            mainAxisSpacing: 1,
                            crossAxisSpacing: 10.0,
                          ),
                          shrinkWrap: true,
                          // ignore: unrelated_type_equality_checks
                          itemCount: products!.isEmpty ? 0 : products!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      '$path${products?[index].image}',
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(top: 0),
                                    child: Text(
                                      "${products?[index].name}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            30), // Adjust the radius as needed
                                        child: IconButton(
                                          onPressed: () async {
                                            if (products != null &&
                                                products![index].quantity! >
                                                    0) {
                                              Product updatedProduct =
                                                  products![index].copyWith(
                                                quantity:
                                                    products![index].quantity! -
                                                        1,
                                              );
                                              await updateProductInLocalStorage(
                                                  index, updatedProduct);
                                            }
                                          },
                                          icon: const Icon(Icons.remove),
                                          color: AppColors.primaryColor,
                                          iconSize: 20,
                                          visualDensity:
                                              VisualDensity.comfortable,
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                            "${products![index].quantity}"),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            30), // Adjust the radius as needed
                                        child: IconButton(
                                          onPressed: () async {
                                            Product updatedProduct =
                                                products![index].copyWith(
                                              quantity:
                                                  products![index].quantity! +
                                                      1,
                                            );
                                            await updateProductInLocalStorage(
                                                index, updatedProduct);
                                          },
                                          icon: const Icon(Icons.add_outlined),
                                          color: AppColors.primaryColor,
                                          iconSize: 20,
                                          visualDensity:
                                              VisualDensity.comfortable,
                                        ),
                                      )
                                    ],
                                  ),

                                  // ignore: sized_box_for_whitespace
                                  Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: GestureDetector(
                                        onTap: () {
                                          addToCart(products![
                                              index]); // Add the product to the cart
                                        },
                                        child: const SizedBox(
                                          height: 35,
                                          child: Card(
                                            color: AppColors.primaryColor,
                                            child: Center(
                                                child: Text(
                                              "Add to Cart",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                          ),
                                        ),
                                      ))
                                ],
                              ),
                            );
                          })
                      : const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        ),
                ))
              ],
            ),
          ),
        ));
  }
}
