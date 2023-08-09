import 'package:breadcrumbs/breadcrumbs.dart';
import 'package:flutter/material.dart';
import 'package:mgahawa_app/components/navbar.dart';
import 'package:mgahawa_app/models/categoryModel.dart';
import 'package:mgahawa_app/models/product.dart';
import 'package:mgahawa_app/services/api.dart';

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
  late List<Product> products;
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

        print("Fetched Products:");
        print(products);
      }
    }
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
      body: Container(
        padding: EdgeInsets.only(left: 0, right: 20, top: 0),
        child: Column(
          children: [
            Container(
                child: Row(
              children: [
                Container(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/screen");
                      },
                      child: Text("Home")),
                ),
                Container(
                  child: Text("/"),
                ),
                Container(
                  child: Text("${widget.categoryName}"),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
