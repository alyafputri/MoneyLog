import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.account_circle, size: 40),
            ),
            accountName: const Text('Versi dasar'),
            accountEmail: null,
          ),
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(Icons.dashboard, 'Ikhtisar', context, route: '/home'),
                _buildDrawerItem(Icons.list_alt, 'Ringkasan', context, route: '/ringkasan'),
                _buildDrawerItem(Icons.swap_horiz, 'Transaksi', context, route: '/home'),
                _buildDrawerItem(Icons.schedule, 'Transaksi Terjadwal', context, route: '/terjadwal'),
                const Divider(),
                _buildDrawerItem(Icons.account_balance, 'Rekening', context, route: '/rekening'),
                _buildDrawerItem(Icons.credit_card, 'Kartu Kredit', context, route: '/kartu'),
                _buildDrawerItem(Icons.pie_chart, 'Anggaran', context, route: '/anggaran'),
                _buildDrawerItem(Icons.access_time, 'Hutang', context, route: '/hutang'),
                const Divider(),
                _buildDrawerItem(Icons.bar_chart, 'Diagram', context, route: '/diagram'),
                _buildDrawerItem(Icons.calendar_today, 'Kalender', context, route: '/kalender'),
                _buildDrawerItem(Icons.handyman, 'Peralatan', context, route: '/peralatan'),
              ],
            ),
          ),
          Container(
            color: Colors.orange,
            child: ListTile(
              leading: const Icon(Icons.store, color: Colors.black),
              title: const Text('Toko', style: TextStyle(color: Colors.black)),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildDrawerItem(
      IconData icon, String title, BuildContext context,
      {String? route}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: route != null
          ? () => Navigator.pushNamed(context, route)
          : () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$title belum diimplementasikan')),
      ),
    );
  }
}