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
        title: Text('Checkout List'),
      ),
      body: ListView.builder(
        itemCount: checkoutList.length,
        itemBuilder: (context, index) {
          FoodItem food = checkoutList[index];
          return ListTile(
            title: Text(''),
            subtitle: Text(''),
            trailing: Text('${food.price}'),
          );
        },
      ),
    );
  }
}
