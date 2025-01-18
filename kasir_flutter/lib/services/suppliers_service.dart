import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kasir_flutter/model/suppliers.dart';

class SuppliersService {
  final String baseUrl = 'http://192.168.31.95:3000/api/v1/kasir/supplier';

  Future<List<SuppliersModel>> fetchSuppliers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200 || response.statusCode == 304) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> dataSuppliers = jsonResponse['data'];
      return dataSuppliers.map((data) => SuppliersModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load Suppliers');
    }
  }

  Future<void> deleteSupplier(int supplierId) async {
    final response = await http.delete(Uri.parse('$baseUrl/hapus/$supplierId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete supplier');
    }
  }

  Future<void> addSupplier(SuppliersModel supplier) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tambah'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nama': supplier.nama,
        'alamat': supplier.alamat,
        'no_hp': supplier.no_hp,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add supplier');
    }
  }

  Future<void> editSupplier(SuppliersModel supplier) async {
    final response = await http.put(
      Uri.parse('$baseUrl/ubah/${supplier.id_sup}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nama': supplier.nama,
        'alamat': supplier.alamat,
        'no_hp': supplier.no_hp,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to edit supplier');
    }
  }
}
