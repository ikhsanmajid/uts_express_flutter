import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kasir_flutter/model/penjualan.dart';

class PenjualanService {
  final String baseUrl = 'http://192.168.31.95:3000/api/v1/kasir/penjualan';

  Future<List<PenjualanModel>> fetchPenjualan() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200 || response.statusCode == 304) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> dataPenjualan = jsonResponse['data'];
      return dataPenjualan.map((data) => PenjualanModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load Penjualan');
    }
  }

  Future<void> addPenjualan(PenjualanModel penjualan) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tambah'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'nonota': penjualan.nonota,
        'nobarcode': penjualan.nobarcode,
        'jumlah': penjualan.jumlah,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add Penjualan');
    }
  }
}
