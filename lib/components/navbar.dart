import 'package:flutter/material.dart';
import 'package:mgahawa_app/includes/colors.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 10,
      leading: Center(
        child: Container(
          child: Text('Logo'),
        ),
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
                child: Text(
                  '0',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
