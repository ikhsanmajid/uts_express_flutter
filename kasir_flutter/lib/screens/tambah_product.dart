import 'package:flutter/material.dart';
import 'package:kasir_flutter/model/products.dart';
import 'package:kasir_flutter/services/products_service.dart';

class TambahProduct extends StatefulWidget {
  @override
  _TambahProductState createState() => _TambahProductState();
}

class _TambahProductState extends State<TambahProduct> {
  final _formKey = GlobalKey<FormState>();
  final _barcodeController = TextEditingController();
  final _namaController = TextEditingController();
  final _hargaController = TextEditingController();
  final _stokController = TextEditingController();
  final ProductsService _productsService = ProductsService();

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      final product = ProductsModel(
        nobarcode: _barcodeController.text,
        nama: _namaController.text,
        harga: int.parse(_hargaController.text),
        stok: int.parse(_stokController.text),
      );

      try {
        await _productsService.addProduct(product);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );
        Navigator.pop(context, true); // Return success
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Product',
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        backgroundColor: Colors.blue[300],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Isi Formulir Dibawah Ini Untuk Menambah Product Baru',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Divider(height: 32, thickness: 1),
              TextFormField(
                controller: _barcodeController,
                decoration: InputDecoration(
                  labelText: 'No Barcode',
                  prefixIcon: const Icon(Icons.qr_code),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  helperText: 'Masukkan Nomor Barcode.',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Mohon masukkan nomor barcode !' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  prefixIcon: const Icon(Icons.label),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  helperText: 'Masukkan Nama Barang.',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Mohon masukkan nama barang !' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _hargaController,
                decoration: InputDecoration(
                  labelText: 'Harga',
                  prefixIcon: const Icon(Icons.money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  helperText: 'Masukkan Harga Barang',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Mohon masukkan harga barang !';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Mohon masukkan angka !';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _stokController,
                decoration: InputDecoration(
                  labelText: 'Stok',
                  prefixIcon: const Icon(Icons.storage),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  helperText: 'Masukkan Jumlah Stok.',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Mohon masukkan stok barang !';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Mohon masukkan angka !';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _addProduct,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Add Product',
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
