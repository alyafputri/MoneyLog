import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnggaranPage extends StatelessWidget {
  const AnggaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> anggaranList = [
      {'icon': Icons.fastfood, 'label': 'Makanan', 'jumlah': 500000},
      {'icon': Icons.directions_bus, 'label': 'Transportasi', 'jumlah': 200000},
      {'icon': Icons.shopping_cart, 'label': 'Belanja', 'jumlah': 300000},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Anggaran')),
      body: ListView.builder(
        itemCount: anggaranList.length,
        itemBuilder: (ctx, index) {
          final item = anggaranList[index];
          return ListTile(
            leading: Icon(item['icon']),
            title: Text(item['label']),
            trailing: Text(
              NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(item['jumlah']),
            ),
          );
        },
      ),
    );
  }
}