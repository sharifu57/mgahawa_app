import 'package:flutter/material.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/screen/navigation/cart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  _NavBarState createState() => _NavBarState();

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // Adjust the height as needed
}

class _NavBarState extends State<NavBar> {
  String? carts;
  @override
  void initState() {
    super.initState();
    getLocal();
  }

  getLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localcart = prefs.getString("cart");

    print("___carts");
    print(localcart);
    print("___end print cart");

    setState(() {
      carts = localcart;
    });
  }

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
                Cart();
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
                    Navigator.pushNamed(context, '/cart');
                  },
                  child: Text(
                    '${carts?.length ?? 0}',
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
    );
  }
}
