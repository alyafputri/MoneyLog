import 'package:flutter/material.dart';

class SumberDana {
  final IconData icon;
  final String label;

  SumberDana({
    required this.icon,
    required this.label,
  });
}

class SumberDanaPage extends StatelessWidget {
  const SumberDanaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SumberDana> sumberDana = [
      SumberDana(icon: Icons.monetization_on, label: 'Gaji'),
      SumberDana(icon: Icons.work, label: 'Freelance'),
      SumberDana(icon: Icons.school, label: 'Uang Saku'),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Sumber Dana')),
      body: ListView.builder(
        itemCount: sumberDana.length,
        itemBuilder: (ctx, index) {
          final item = sumberDana[index];
          return ListTile(
            leading: Icon(item.icon),
            title: Text(item.label),
          );
        },
      ),
    );
  }
}