import 'package:flutter/material.dart';
import 'package:kasir_flutter/screens/products.dart';
import 'package:kasir_flutter/screens/suppliers.dart';
import 'widgets/navbar.dart';

void main() => runApp(const KasirApp());

class KasirApp extends StatelessWidget {
  const KasirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasir App',
      theme: ThemeData(useMaterial3: true),
      home: const NavigationKasir(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NavigationKasir extends StatefulWidget {
  const NavigationKasir({super.key});

  @override
  State<NavigationKasir> createState() => _NavigationKasirState();
}

class _NavigationKasirState extends State<NavigationKasir> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
          currentIndex: _currentPageIndex,
          onTap: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          }),
      body: <Widget>[
        const ProductsKasir(),
        const SuppliersKasir()
      ].elementAt(_currentPageIndex),
    );
  }
}
