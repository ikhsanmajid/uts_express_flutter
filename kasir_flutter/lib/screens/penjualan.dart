import 'package:flutter/material.dart';
import 'package:kasir_flutter/model/penjualan.dart';
import 'package:kasir_flutter/screens/tambah_penjualan.dart';
import 'package:kasir_flutter/services/penjualan_service.dart';

class PenjualanKasir extends StatefulWidget {
  const PenjualanKasir({super.key});

  @override
  _PenjualanKasirState createState() => _PenjualanKasirState();
}

class _PenjualanKasirState extends State<PenjualanKasir> {
  late Future<List<PenjualanModel>> futurePenjualan;
  final PenjualanService penjualanService = PenjualanService();

  @override
  void initState() {
    super.initState();
    futurePenjualan = penjualanService.fetchPenjualan();
  }

  Future<void> _refreshPenjualan() async {
    setState(() {
      futurePenjualan = penjualanService.fetchPenjualan();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Penjualan',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
        backgroundColor: Colors.blue[300],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshPenjualan,
        child: FutureBuilder<List<PenjualanModel>>(
          future: futurePenjualan,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No sales data found'));
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final penjualan = snapshot.data![index];
                  return SizedBox(
                    height: 100,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: ListTile(
                          leading: const Icon(Icons.receipt_long_rounded),
                          title: Text('No Nota: ${penjualan.nonota}'),
                          subtitle: Text(
                              'No Barcode: ${penjualan.nobarcode}\nJumlah: ${penjualan.jumlah}'),
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
          // Navigate to the TambahPenjualan page
          bool? isAdded = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahPenjualan()),
          );
          if (isAdded == true) {
            // Refresh the sales list if a new sale was added
            _refreshPenjualan();
          }
        },
        backgroundColor: Colors.blue[300],
        child: const Icon(Icons.add),
      ),
    );
  }
}
