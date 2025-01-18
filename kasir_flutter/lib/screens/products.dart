// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kasir_flutter/widgets/custom_barcode_widget.dart';
import 'package:kasir_flutter/model/products.dart';
import 'package:kasir_flutter/services/products_service.dart';
import 'package:kasir_flutter/screens/product_detail.dart';
import 'package:kasir_flutter/screens/tambah_product.dart';

class ProductsKasir extends StatefulWidget {
  const ProductsKasir({super.key});
  @override
  ProductsKasirState createState() => ProductsKasirState();
}

class ProductsKasirState extends State<ProductsKasir> {
  late Future<List<ProductsModel>> futureProducts;
  final ProductsService productsService = ProductsService();

  @override
  void initState() {
    super.initState();
    futureProducts = productsService.fetchProducts();
  }

  Future<void> _refreshProducts() async {
    setState(() {
      futureProducts = productsService.fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
        backgroundColor: Colors.blue[300],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
        child: FutureBuilder<List<ProductsModel>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found'));
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                    height: 100,
                    child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Center(
                            child: ListTile(
                          leading: const Icon(Icons.inventory),
                          title: Text(snapshot.data![index].nama),
                          subtitle: Text('Rp ${snapshot.data![index].harga}'),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: CustomBarcodeWidget(
                                          barcode:
                                              snapshot.data![index].nobarcode)
                                      .build()),
                            ],
                          ),
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  product: snapshot.data![index],
                                )
                              )
                            );
                            if (result == true) {
                              _refreshProducts(); // Reload the products list
                            }
                          },
                        ))));
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the AddProduct page
          bool? isAdded = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahProduct()),
          );
          if (isAdded == true) {
            _refreshProducts(); // Reload the products list
          }
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue[300],
      ),
    );
  }
}
