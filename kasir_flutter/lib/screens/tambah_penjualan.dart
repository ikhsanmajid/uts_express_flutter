import 'package:flutter/material.dart';
import 'package:kasir_flutter/services/penjualan_service.dart';
import 'package:kasir_flutter/services/products_service.dart';
import 'package:kasir_flutter/model/products.dart';
import 'package:kasir_flutter/model/penjualan.dart';

class TambahPenjualan extends StatefulWidget {
  const TambahPenjualan({Key? key}) : super(key: key);

  @override
  State<TambahPenjualan> createState() => _TambahPenjualanState();
}

class _TambahPenjualanState extends State<TambahPenjualan> {
  final _formKey = GlobalKey<FormState>();
  final PenjualanService _penjualanService = PenjualanService();
  final ProductsService _productsService = ProductsService();

  int? _nonota;
  String? _selectedNobarcode;
  int? _jumlah;
  List<ProductsModel> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await _productsService.fetchProducts();
      setState(() {
        _products = products;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch products: $e')),
      );
    }
  }

  Future<void> _addPenjualan() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final penjualan = PenjualanModel(
        nonota: _nonota!,
        nobarcode: _selectedNobarcode!,
        jumlah: _jumlah!,
      );

      try {
        await _penjualanService.addPenjualan(penjualan);
        Navigator.pop(context, true); // Return to the previous page and refresh
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add penjualan: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Penjualan'),
        backgroundColor: Colors.blue[300],
      ),
      body: _products.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tambah Penjualan',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Isi Formulir Dibawah Ini Untuk Menambah Penjualan Baru',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const Divider(height: 32, thickness: 1),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'No Nota',
                        prefixIcon: const Icon(Icons.receipt),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        helperText: 'Masukkan No Nota Penjualan',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon masukkan nomor nota !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _nonota = int.tryParse(value!);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Nobarcode - Nama Barang',
                        prefixIcon: const Icon(Icons.qr_code),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        helperText: 'Pilih Barang Yang Dibeli'
                      ),
                      items: _products
                          .map((product) => DropdownMenuItem<String>(
                                value: product.nobarcode,
                                child: Text(
                                    '${product.nobarcode} - ${product.nama}'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedNobarcode = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon pilih barang dulu !';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Jumlah',
                        prefixIcon: const Icon(Icons.storage_rounded),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        helperText: 'Masukkan Jumlah',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mohon masukkan jumlah !';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _jumlah = int.tryParse(value!);
                      },
                    ),
                    const SizedBox(height: 24.0),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: _addPenjualan,
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: const Text(
                          'Tambah Penjualan',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[300],
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
