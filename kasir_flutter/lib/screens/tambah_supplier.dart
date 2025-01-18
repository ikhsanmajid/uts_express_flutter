import 'package:flutter/material.dart';
import 'package:kasir_flutter/model/suppliers.dart';
import 'package:kasir_flutter/services/suppliers_service.dart';

class TambahSupplier extends StatefulWidget {
  @override
  _TambahSupplierState createState() => _TambahSupplierState();
}

class _TambahSupplierState extends State<TambahSupplier> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _noHpController = TextEditingController();
  final SuppliersService _suppliersService = SuppliersService();

  Future<void> _addSupplier() async {
    if (_formKey.currentState!.validate()) {
      final supplier = SuppliersModel(
        nama: _namaController.text,
        alamat: _alamatController.text,
        no_hp: _noHpController.text,
      );

      try {
        await _suppliersService.addSupplier(supplier);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Supplier added successfully')),
        );
        Navigator.pop(context, true); // Return success
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add supplier: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Supplier',
          style: const TextStyle(fontWeight: FontWeight.w300),
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
                'Tambah Supplier',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Isi Formulir Dibawah Ini Untuk Menambah Supplier Baru',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Divider(height: 32, thickness: 1),
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Supplier',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  helperText: 'Masukkan Nama Supplier',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Mohon masukkan nama supplier !' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  helperText: 'Masukkan Nama Supplier',
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Mohon masukkan nama supplier !' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noHpController,
                decoration: InputDecoration(
                  labelText: 'No HP',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  helperText: 'Masukkan Nomor HP Supplier',
                ),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.isEmpty ? 'Mohon masukkan no hp supplier !' : null,
              ),
              const SizedBox(height: 24),
              Center(
                child: ElevatedButton.icon(
                  onPressed: _addSupplier,
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text(
                    'Add Supplier',
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
