import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mgahawa_app/components/navbar.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/config.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Product> cartProducts = [];
  @override
  void initState() {
    super.initState();
    getLocal();
  }

  getLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localCartJson = prefs.getString("cart");

    if (localCartJson != null) {
      List<dynamic> cartList = jsonDecode(localCartJson);

      List<Product> parsedCartItems = cartList.map((item) {
        return Product.fromJson(
            item); // Assuming you have a fromJson method in Product model
      }).toList();

      setState(() {
        cartProducts = parsedCartItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBar(),
        body: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(bottom: 10),
                child: const Text(
                  "Order Summary",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Visibility(
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ListView.builder(
                        itemCount: cartProducts.length,
                        itemBuilder: (BuildContext context, index) {
                          return SizedBox(
                            height: 120,
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          child: cartProducts[index].image ==
                                                  null
                                              ? Container(
                                                  child: Text(""),
                                                )
                                              : Image.network(
                                                  '$path${cartProducts[index].image}',
                                                  fit: BoxFit.cover,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height,
                                                ),
                                        )),
                                    Expanded(
                                        flex: 6,
                                        child: Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "${cartProducts[index].name}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  " Tzs ${cartProducts[index].price}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 20),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "X ${cartProducts[index].quantity}",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                            onPressed: () {
                                              print(
                                                  "____remove from cart ${cartProducts[index]}");
                                            },
                                            icon: const Icon(
                                              Icons.cancel_outlined,
                                              color: AppColors.primaryColor,
                                            )))
                                  ],
                                ),
                              ),
                            ),
                          );
                        })),
              ),
              SizedBox(
                width: double.infinity,
                // ignore: unnecessary_null_comparison
                child: cartProducts.length != 0
                    ? SizedBox(
                        height: 50,
                        child: InkWell(
                          onTap: () {
                            print("_____check out");
                          },
                          child: const Card(
                            color: AppColors.primaryColor,
                            child: Center(
                                child: Text(
                              "Check Out",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        ),
                      )
                    : Container(),
              )
            ],
          ),
        ));
  }
}
