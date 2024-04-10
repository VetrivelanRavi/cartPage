// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:app_10_04_grocery/View1/view2.dart';
import 'package:app_10_04_grocery/ViewModel1/viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ViewModel>(
      builder: (context, AccessData, child) => SizedBox(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: Text('Grocery App'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CartPage(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.shopping_basket_outlined,
                  size: 30,
                ),
              ),
            ],
          ),
          body: FutureBuilder(
            future: Provider.of<ViewModel>(context).fetchDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('error:${snapshot.error}');
              } else {
                return ListView.builder(
                  itemCount: AccessData.ProductList.length,
                  itemBuilder: (context, index) {
                    final Product = AccessData.ProductList[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Container(
                          height: 230,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  Product.name.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ),
                              Image.network(
                                Product.image.toString(),
                                height: 70,
                              ),
                              Text(Product.price.toString()),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  Product.category.toString(),
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 120,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        AccessData.addItemToCart(Product);
                                      },
                                      child: Text(
                                        'Add To Cart',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        elevation: 10,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
