import 'package:flutter/material.dart';
import 'package:kasir_flutter/model/suppliers.dart';
import 'package:kasir_flutter/screens/supplier_detail.dart';
import 'package:kasir_flutter/screens/tambah_supplier.dart';
import 'package:kasir_flutter/services/suppliers_service.dart';

class SuppliersKasir extends StatefulWidget {
  const SuppliersKasir({super.key});

  @override
  SuppliersKasirState createState() => SuppliersKasirState();
}

class SuppliersKasirState extends State<SuppliersKasir> {
  late Future<List<SuppliersModel>> futureSuppliers;
  final SuppliersService suppliersService = SuppliersService();

  @override
  void initState() {
    super.initState();
    futureSuppliers = suppliersService.fetchSuppliers();
  }

  Future<void> _refreshSuppliers() async {
    setState(() {
      futureSuppliers = suppliersService.fetchSuppliers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
        backgroundColor: Colors.blue[300],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshSuppliers,
        child: FutureBuilder<List<SuppliersModel>>(
          future: futureSuppliers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No suppliers found'));
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
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: const Icon(Icons.warehouse),
                          title: Text(snapshot.data![index].nama),
                          subtitle: Text(
                              'Alamat: ${snapshot.data![index].alamat}\nNo HP: ${snapshot.data![index].no_hp}'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SupplierDetail(supplier: snapshot.data![index]),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navigate to the TambahSupplier page
          bool? isAdded = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TambahSupplier()),
          );
          if (isAdded == true) {
            // Refresh the suppliers list if a new supplier was added
            _refreshSuppliers();
          }
        },
        backgroundColor: Colors.blue[300],
        child: const Icon(Icons.add),
      ),
    );
  }
}
