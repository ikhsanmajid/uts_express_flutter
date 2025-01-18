import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kasir_flutter/widgets/custom_barcode_widget.dart';
import 'package:kasir_flutter/model/products.dart';
import 'package:http/http.dart' as http;

class ProductsService {
  Future<List<ProductsModel>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://192.168.31.95:3000/api/v1/kasir/barang'));
    if (response.statusCode == 200 || response.statusCode == 304) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> dataProducts = jsonResponse['data'];
      return dataProducts.map((data) => ProductsModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }
}

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
                        ))));
                },
              );
            }
          },
        ),
      ),
    );
  }
}
