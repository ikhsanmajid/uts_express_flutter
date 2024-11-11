import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: onTap,
      indicatorColor: Colors.blue[300],
      selectedIndex: currentIndex,
      destinations: const <Widget>[
        NavigationDestination(
          icon: Icon(Icons.inventory_2_outlined),
          label: 'Products',
          selectedIcon: Icon(Icons.inventory),
        ),
        NavigationDestination(
          icon: Icon(Icons.warehouse_outlined),
          label: 'Supplier',
          selectedIcon: Icon(Icons.warehouse),
        )
      ],
    );
  }
}
