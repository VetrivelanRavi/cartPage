// ignore_for_file: prefer_const_constructors

import 'package:app_10_04_grocery/ViewModel1/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ViewModel>(
      builder: (context, Cartadd, child) => SizedBox(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            title: Text('Cart Page'),
            centerTitle: true,
          ),
          body: Cartadd.cartList.length == 0
              ? Center(
                  child: Text(
                  "Your Cart Is Empty",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ))
              : ListView.builder(
                  itemCount: Cartadd.cartList.length,
                  itemBuilder: (context, index) {
                    final products = Cartadd.cartList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          height: 70,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                products.image.toString(),
                                height: 50,
                              ),
                              Text(products.name.toString()),
                              Text(products.price.toString()),
                              TextButton.icon(
                                  onPressed: () {
                                    Cartadd.addItemToCart(products);
                                  },
                                  icon: Icon(Icons.delete_outline),
                                  label: Text('Delete'))
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
