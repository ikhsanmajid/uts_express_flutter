import 'package:flutter/material.dart';
import 'package:kasir_flutter/model/suppliers.dart';
import 'package:kasir_flutter/services/suppliers_service.dart';

class SupplierDetail extends StatelessWidget {
  final SuppliersModel supplier;

  SupplierDetail({required this.supplier});

  final SuppliersService _suppliersService = SuppliersService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(supplier.nama),
        backgroundColor: Colors.blue[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${supplier.nama}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Address: ${supplier.alamat}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Phone: ${supplier.no_hp}', style: TextStyle(fontSize: 16)),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () async {
                bool confirm = await _showConfirmationDialog(context);
                if (confirm) {
                  await _deleteSupplier(context, supplier.id_sup);
                }
              },
              child: const Text('Delete Supplier'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteSupplier(BuildContext context, int supplierId) async {
    try {
      await _suppliersService.deleteSupplier(supplierId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Supplier deleted successfully')),
      );
      Navigator.pop(context); // Return to the previous screen
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete supplier: $e')),
      );
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Delete'),
              content: Text('Are you sure you want to delete this supplier?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text('Delete'),
                ),
              ],
            );
          },
        ) ??
        false;
  }
}
