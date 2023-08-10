import 'package:flutter/material.dart';
import 'package:mgahawa_app/components/navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
    return Scaffold(
        appBar: NavBar(),
        body: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Order Summary",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                  child: Visibility(
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ListView.builder(
                          itemCount: carts?.length ?? 0,
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                                leading: const Icon(Icons.list),
                                trailing: const Text(
                                  "GFG",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 15),
                                ),
                                title: Text("List item $index"));
                          })))
            ],
          ),
        ));
    // body: SingleChildScrollView(
    //   physics: BouncingScrollPhysics(),
    //   child: Container(
    //     height: MediaQuery.of(context).size.height,
    //     width: MediaQuery.of(context).size.width,
    //     padding: EdgeInsets.all(20),
    //     child: Column(
    //       children: [
    //         Container(
    //           child: Text(
    //             "Order Summary",
    //             style: TextStyle(fontWeight: FontWeight.w600),
    //           ),
    //         ),
    //         ListView.builder(
    //             itemCount: 5,
    //             itemBuilder: (BuildContext context, int index) {
    //               return ListTile(
    //                   leading: const Icon(Icons.list),
    //                   trailing: const Text(
    //                     "GFG",
    //                     style: TextStyle(color: Colors.green, fontSize: 15),
    //                   ),
    //                   title: Text("List item $index"));
    //             }),
    //       ],
    //     ),
    //   ),
    // ));
  }
}
