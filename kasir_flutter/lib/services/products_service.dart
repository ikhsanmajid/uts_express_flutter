import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kasir_flutter/model/products.dart';

class ProductsService {
  final String baseUrl = 'http://192.168.211.138:3000/api/v1/kasir/barang';

  // Fetch all products
  Future<List<ProductsModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200 || response.statusCode == 304) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> dataProducts = jsonResponse['data'];
      return dataProducts.map((data) => ProductsModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Delete a product by barcode
  Future<void> deleteProduct(String nobarcode) async {
    final response = await http.delete(Uri.parse('$baseUrl/hapus/$nobarcode'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }

  // Add a new product
  Future<void> addProduct(ProductsModel product) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tambah'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nobarcode': product.nobarcode,
        'nama': product.nama,
        'harga': product.harga,
        'stok': product.stok,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add product');
    }
  }

  // Update an existing product
  Future<void> updateProduct(ProductsModel product) async {
    final response = await http.put(
      Uri.parse('$baseUrl/ubah/${product.nobarcode}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nama': product.nama,
        'harga': product.harga,
        'stok': product.stok,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update product');
    }
  }
}
