import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mgahawa_app/components/navbar.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/models/product.dart';
import 'package:mgahawa_app/screen/pages/checkout.dart';
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
    final currencyFormatter = NumberFormat.currency(
      symbol: "Tzs ", // Replace with your desired currency symbol
      decimalDigits: 2,
    );
    double totalCartAmount = 0;
    // double price = double.tryParse(produc)
    for (var product in cartProducts) {
      double price = double.tryParse(product.price as String) ?? 0.0;
      int quantity = product.quantity as int;
      totalCartAmount += price * quantity;
    }

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
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/screen");
                        },
                        child: const Text("Home")),
                    const Text("/"),
                    const Text(
                      "Order Summary",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
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
                          int? quantity = cartProducts[index].quantity;
                          double price = double.tryParse(
                                  cartProducts[index].price ?? "0.0") ??
                              0.0;

                          double totalPrice = (quantity ?? 0) * price;

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
                                              ? const Text("")
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
                                                  "${currencyFormatter.format(price)},",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 10),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "X ${cartProducts[index].quantity}",
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "${currencyFormatter.format(totalPrice)},",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              )
                                            ],
                                          ),
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: IconButton(
                                            onPressed: () async {
                                              _showConfirmRemoveDialog(index);
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
                        height: 70,
                        child: InkWell(
                          onTap: () {
                            print("_____check out");
                          },
                          child: Card(
                            color: AppColors.primaryColor,
                            child: Center(
                                child: Row(
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                      padding: EdgeInsets.only(
                                        left: 15,
                                      ),
                                      child: Text(
                                        "${currencyFormatter.format(totalCartAmount)},",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: () {
                                        print("_____checkout");

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext) =>
                                                    CheckOut(
                                                        totalCheckAmount:
                                                            totalCartAmount)));
                                      },
                                      child: Card(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          child: const Text(
                                            "Check Out",
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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

  Future<void> _showConfirmRemoveDialog(int index) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text("Confirm Removal"),
            content: SingleChildScrollView(
              child: ListBody(children: <Widget>[
                Text(
                    'Are you sure you want to remove this item from the cart?'),
              ]),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(dialogContext).pop(); // Close the dialog
                },
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () async {
                  Navigator.of(dialogContext).pop(); // Close the dialog
                  await removeItemFromCart(index); // Remove the item from cart
                  await updateLocalCart(); // Update the local storage
                },
              ),
            ],
          );
        });
  }

  removeItemFromCart(int index) async {
    cartProducts.removeAt(index);
  }

  Future<void> updateLocalCart() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> cartList = cartProducts
        .map((item) =>
            item.toJson()) // Assuming you have a toJson method in Product model
        .toList();

    String cartJson = jsonEncode(cartList);
    await prefs.setString("cart", cartJson);

    setState(() {}); // Refresh the UI
  }
}
