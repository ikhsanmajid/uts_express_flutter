import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kasir_flutter/model/suppliers.dart';
import 'package:http/http.dart' as http;

class SuppliersService {
  Future<List<SuppliersModel>> fetchSuppliers() async {
    final response =
        await http.get(Uri.parse('http://192.168.181.95:3000/api/v1/kasir/supplier'));
    if (response.statusCode == 200 || response.statusCode == 304) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> dataSuppliers = jsonResponse['data'];
      return dataSuppliers.map((data) => SuppliersModel.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load Suppliers');
    }
  }
}

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
                          leading: const Icon(Icons.person), // Person icon here
                          title: Text(snapshot.data![index].nama),
                          subtitle: Text('Alamat: ${snapshot.data![index].alamat}\nNo HP: ${snapshot.data![index].no_hp}'),
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
    );
  }
}
