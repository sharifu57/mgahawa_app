import 'package:flutter/material.dart';
import 'package:mgahawa_app/includes/colors.dart';
import 'package:mgahawa_app/screen/navigation/cart.dart';
import 'package:mgahawa_app/screen/navigation/home.dart';
import 'package:mgahawa_app/screen/navigation/index.dart';
import 'package:mgahawa_app/screen/navigation/profile.dart';
import 'package:mgahawa_app/screen/navigation/search.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabs = [
      Center(
        child: IndexPage(),
      ),
      Center(child: Search()),
      Center(
        child: Cart(),
      ),
      Center(
        child: Profile(),
      )
    ];

    return Scaffold(
        body: Center(
          child: tabs.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 0, blurRadius: 20),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
              child: Container(
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.shifting,
                  elevation: 10,
                  iconSize: 13,

                  selectedIconTheme: const IconThemeData(
                      color: AppColors.secondaryColor, size: 15),
                  selectedItemColor: AppColors.primaryColor,
                  mouseCursor: SystemMouseCursors.grab,
                  selectedLabelStyle: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 12),
                  unselectedIconTheme: const IconThemeData(
                    color: Colors.black54,
                  ),
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                        color: AppColors.primaryColor,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search,
                        color: AppColors.primaryColor,
                      ),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.shopping_cart,
                        color: AppColors.primaryColor,
                      ),
                      label: 'Cart',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(
                        Icons.person_4_outlined,
                        color: AppColors.primaryColor,
                      ),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: _selectedIndex, //New
                  onTap: _onItemTapped,
                ),
              ),
            )));
  }
}
