import 'package:flutter/material.dart';
import 'package:mgahawa_app/screen/navigation/cart.dart';

import '../../includes/colors.dart';

class CheckOut extends StatefulWidget {
  const CheckOut({super.key});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      print("____Cart clicked");
                    },
                    child: Text(
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
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30),
              child: Center(
                  child: Icon(
                Icons.wallet_membership,
                size: 100,
                color: AppColors.primaryColor,
              )),
            ),
            Container(
              child: Text(
                "12000 Tzs",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
                child: SizedBox(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    child: Text('Personal Information'),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
