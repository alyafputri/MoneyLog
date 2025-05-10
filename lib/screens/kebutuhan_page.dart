import 'package:flutter/material.dart';

class Kebutuhan {
  final IconData icon;
  final String label;
  final String status;

  Kebutuhan({
    required this.icon,
    required this.label,
    required this.status,
  });
}

class KebutuhanPage extends StatelessWidget {
  const KebutuhanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Kebutuhan> kebutuhanList = [
      Kebutuhan(icon: Icons.book, label: 'Buku Kuliah', status: 'Belum'),
      Kebutuhan(icon: Icons.lightbulb, label: 'Bayar Listrik', status: 'Sudah'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Kebutuhan')),
      body: ListView.builder(
        itemCount: kebutuhanList.length,
        itemBuilder: (ctx, index) {
          final item = kebutuhanList[index];
          return ListTile(
            leading: Icon(item.icon),
            title: Text(item.label),
            subtitle: Text('Status: ${item.status}'),
          );
        },
      ),
    );
  }
}