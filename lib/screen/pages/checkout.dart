import 'package:flutter/material.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/models/foodModel.dart';

class CheckoutListScreen extends StatelessWidget {
  final List<FoodItem> checkoutList;
  final Function(FoodItem) onDismiss;

  CheckoutListScreen({required this.checkoutList, required this.onDismiss});

  handleDismis() {}

  @override
  Widget build(BuildContext context) {
    // Build your UI to display the checkout list here

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text(
          "My Cart",
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: checkoutList.length,
              itemBuilder: (context, index) {
                FoodItem food = checkoutList[index];

                return Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Dismissible(
                    key: ValueKey(food.name), // Use a unique key for each item
                    onDismissed: (direction) {
                      // Remove the item from the data source.
                      // setState(() {
                      //   checkoutList.removeAt(index);
                      // });

                      onDismiss(food);

                      // Then show a snackbar.
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${food.name} dismissed')),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text("${food.name}"),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Card(
              color: AppColors.primaryColor,
              child: Text("Proceed"),
            ),
          )
        ],
      ),
    );
  }
}
