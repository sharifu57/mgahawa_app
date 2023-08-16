import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mgahawa_app/models/product.dart';
import 'package:mgahawa_app/screen/navigation/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../includes/colors.dart';

class CheckOut extends StatefulWidget {
  final double? totalCheckAmount;
  const CheckOut({super.key, required this.totalCheckAmount});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final Map<String, dynamic> _formData = {};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  List<Product> items = [];
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
        items = parsedCartItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      symbol: "Tzs ", // Replace with your desired currency symbol
      decimalDigits: 2,
    );
    var size = MediaQuery.of(context).size;
    final double labelTextFontSize = size.height / 80;
    final double hintTextFontSize = size.height / 80;
    final double inputTextFontSize = size.height / 60;
    final double errorTextFontSize = size.height / 80;
    final double prefixIconSize = size.height / 90;
    outlinedTextFieldBoarder() {
      return OutlineInputBorder(
        borderRadius:
            BorderRadius.circular(10.0), // Adjust the radius as needed
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading: Center(
            child: IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, "/cart");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext) => Cart()));
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 17,
                ))),
        title: Text(
          "Checkout",
          style: TextStyle(fontSize: 15),
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
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'One',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: Card(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryColor,
                        AppColors.secondaryColor
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        "total:",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      currencyFormatter
                                          .format(widget.totalCheckAmount),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              )),
                          const Divider(),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              "Items:",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${items.length}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.white),
                            ),
                          )
                        ],
                      )),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 30),
              child: const Text(
                "Customer Details",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: Form(
                    child: Column(
              children: [
                Expanded(
                    child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            hintText: "john doe",
                            hintStyle: TextStyle(
                                fontSize: hintTextFontSize,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xff005B29)),
                            labelStyle: TextStyle(
                                fontSize: labelTextFontSize,
                                color: const Color(0xff005B29)),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.person,
                              size: prefixIconSize,
                              color: const Color(0xff005B29),
                            ),
                            fillColor: Colors.white.withOpacity(0.0),
                            errorStyle: const TextStyle(fontSize: 10.0),
                            border: outlinedTextFieldBoarder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (value == null) {
                              return 'please provide your name';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _formData['customer_name'] = value;
                          },
                        )),
                    Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            hintText: "25571XXXXXXX",
                            hintStyle: TextStyle(
                                fontSize: hintTextFontSize,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xff005B29)),
                            labelStyle: TextStyle(
                                fontSize: labelTextFontSize,
                                color: const Color(0xff005B29)),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.phone_android,
                              size: prefixIconSize,
                              color: const Color(0xff005B29),
                            ),
                            fillColor: Colors.white.withOpacity(0.0),
                            errorStyle: const TextStyle(fontSize: 10.0),
                            border: outlinedTextFieldBoarder(),
                          ),
                          initialValue: '255',
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (value?.length != 12 ||
                                value == null ||
                                !RegExp(r"^[0-9]*$").hasMatch(value)) {
                              return 'Tafadhali ingiza namba ya simu ilio sahihi';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _formData['phone_number'] = value;
                          },
                        )),
                    Container(
                        padding: EdgeInsets.only(top: 20),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Location',
                            hintText: "current location",
                            hintStyle: TextStyle(
                                fontSize: hintTextFontSize,
                                fontWeight: FontWeight.w300,
                                color: const Color(0xff005B29)),
                            labelStyle: TextStyle(
                                fontSize: labelTextFontSize,
                                color: const Color(0xff005B29)),
                            filled: true,
                            prefixIcon: Icon(
                              Icons.location_city,
                              size: prefixIconSize,
                              color: const Color(0xff005B29),
                            ),
                            fillColor: Colors.white.withOpacity(0.0),
                            errorStyle: const TextStyle(fontSize: 10.0),
                            border: outlinedTextFieldBoarder(),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (String? value) {
                            if (value == null) {
                              return 'please provide your location';
                            }
                            return null;
                          },
                          onSaved: (String? value) {
                            _formData['location'] = value;
                          },
                        )),
                  ],
                )),
                InkWell(
                  splashColor: AppColors.secondaryColor,
                  focusColor: AppColors.primaryColor,
                  onTap: () {
                    print("____send order");
                  },
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: const Center(child: Text("Send Order")),
                    ),
                  ),
                )
              ],
            )))
          ],
        ),
      ),
    );
  }
}
