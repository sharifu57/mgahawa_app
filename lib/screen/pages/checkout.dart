import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mgahawa_app/models/product.dart';
import 'package:mgahawa_app/screen/navigation/cart.dart';
import 'package:mgahawa_app/services/api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../includes/colors.dart';
import '../../services/config.dart';

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
  String? orderNumber;

  @override
  void initState() {
    super.initState();
    getLocal();
    randomNumber();
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

  randomNumber() {
    int currentTime = DateTime.now().second;
    int randomValue = Random().nextInt(9999);

    String ordNumber = '${randomValue}${currentTime}';

    setState(() {
      orderNumber = ordNumber;
    });
    return orderNumber;
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(
      symbol: "Tzs ", // Replace with your desired currency symbol
      decimalDigits: 2,
    );

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
                icon: const Icon(
                  Icons.arrow_back,
                  size: 17,
                ))),
        title: const Text(
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    const Text(
                      "Order Number",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Text("${orderNumber}")
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Visibility(
                  // child: ListView.builder(
                  //     itemCount: items.length,
                  //     itemBuilder: (BuildContext context, index) {
                  //       Product item = items[index];
                  //       return Card(
                  //         child: Column(
                  //           children: <Widget>[
                  //             Container(
                  //               child: Text("Order Details"),
                  //             )
                  //           ],
                  //         ),
                  //       );
                  //     })
                  child: Card(
                    elevation: 1,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Order Details",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Divider(),
                          Container(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Total Price"),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    currencyFormatter
                                        .format(widget.totalCheckAmount),
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                alignment: Alignment.center,
                child: const Column(
                  children: [
                    Text("Fill your Details"),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white, // Adjust the color as needed
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor, // Set the background color
                ),
                onPressed: () {
                  // Add functionality for the first button
                  _openPopup(context);
                },
                child: Text(
                  "Customer Details",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 3), // Add spacing between the buttons
            Container(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Set the background color
                ),
                onPressed: () {
                  // Add functionality for the second button
                },
                child: Text(
                  "Confirm Order",
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openPopup(context) {
    bool isLoading = false;
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      isCloseButton: true,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      descTextAlign: TextAlign.start,
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      alertAlignment: Alignment.center,
    );

    double screenWidth = MediaQuery.of(context).size.width;
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

    Alert(
        context: context,
        title: "CUSTOMER INFO",
        style: alertStyle,
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'First Name',
                  hintText: "john",
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
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value == null) {
                    return 'please provide your first name';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _formData['first_name'] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  hintText: "john",
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
                ),
                keyboardType: TextInputType.text,
                validator: (String? value) {
                  if (value == null) {
                    return 'please provide your last name';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _formData['last_name'] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: "email",
                  hintStyle: TextStyle(
                      fontSize: hintTextFontSize,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xff005B29)),
                  labelStyle: TextStyle(
                      fontSize: labelTextFontSize,
                      color: const Color(0xff005B29)),
                  filled: true,
                  prefixIcon: Icon(
                    Icons.email,
                    size: prefixIconSize,
                    color: const Color(0xff005B29),
                  ),
                  fillColor: Colors.white.withOpacity(0.0),
                  errorStyle: const TextStyle(fontSize: 10.0),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value) {
                  if (value == null) {
                    return 'please provide your email';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _formData['email'] = value;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: "phone number",
                  hintStyle: TextStyle(
                      fontSize: hintTextFontSize,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xff005B29)),
                  labelStyle: TextStyle(
                      fontSize: labelTextFontSize,
                      color: const Color(0xff005B29)),
                  filled: true,
                  prefixIcon: Icon(
                    Icons.phone,
                    size: prefixIconSize,
                    color: const Color(0xff005B29),
                  ),
                  fillColor: Colors.white.withOpacity(0.0),
                  errorStyle: const TextStyle(fontSize: 10.0),
                ),
                keyboardType: TextInputType.phone,
                validator: (String? value) {
                  if (value == null) {
                    return 'please provide your email';
                  }
                  return null;
                },
                onSaved: (String? value) {
                  _formData['phone_number'] = value;
                },
              ),
            ],
          ),
        ),
        buttons: [
          DialogButton(
            // onPressed: () => Navigator.pop(context),
            onPressed: () {
              _createCustomer();
            },
            child: isLoading == false
                ? Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  )
                : CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
          )
        ]).show();
  }

  Future _createCustomer() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    var submittedData = {
      "username": _formData['username'],
    };

    print(submittedData);

    final endpoint = '${config['apiBaseUrl']}/login';
    final data = json.encode(submittedData);

    var response = await sendPostRequest(context, endpoint, data);

    // ignore: unnecessary_null_comparison

    if (response != null) {
      if (response['status'] == 201) {
        SharedPreferences pref = await SharedPreferences.getInstance();
        String data = jsonEncode(response);
        print("_________user response");
        await pref.setString('user', data);
        await pref.setString('_accessToken', response?['accessToken']);
        await pref.setString('_first_name', response?['user']['first_name']);
        await pref.setString('_last_name', response?['user']['last_name']);
        await pref.setString('_username', response?['user']['username']);
        await pref.setInt('_userId', response?['user']['id']);

        Navigator.restorablePushNamed(context, '/screen');
      } else {}
    } else {
      return null;
    }

    setState(() {
      _isLoading = false;
    });
  }
}
