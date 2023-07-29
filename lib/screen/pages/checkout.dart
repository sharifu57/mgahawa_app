import 'package:flutter/material.dart';
import 'package:mgahawa_app/models/foodModel.dart';

class CheckoutListScreen extends StatelessWidget {
  final List<FoodItem> checkoutList;

  CheckoutListScreen({required this.checkoutList});

  @override
  Widget build(BuildContext context) {
    // Build your UI to display the checkout list here
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        // title: Text('My Cart'),
        // title: Text(""),
        // leading: Container(
        //     child: Row(
        //   children: [
        //     IconButton(
        //         onPressed: () {}, icon: Icon(Icons.arrow_back_ios_new_sharp)),
        //     Text("My Cart"),
        //   ],
        // )),
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/screen');
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        title: Container(
          child: Text("My Cart"),
        ),
      ),
      body: ListView.builder(
        itemCount: checkoutList.length,
        itemBuilder: (context, index) {
          FoodItem food = checkoutList[index];
          return SingleChildScrollView(
            child: Card(
              // child: ListTile(
              //   title: Text('${food}'),
              //   subtitle: Text(''),
              //   trailing: Text('${food.price}'),
              // ),
              child: ListTile(
                leading: Container(),
              ),
            ),
          );
        },
      ),
    );
  }
}
