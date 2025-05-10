import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/transaksi.dart';
import '../widgets/transaksi_form.dart';
import '../widgets/transaksi_list.dart';
import '../widgets/chart.dart';
import 'kalender_page.dart';
import 'anggaran_page.dart';
import 'kebutuhan_page.dart';
import 'sumberdana_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Transaksi> _transaksiBox;
  final List<Transaksi> _userTransaksi = [];

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _initHive();
  }

  Future<void> _initHive() async {
    _transaksiBox = await Hive.openBox<Transaksi>('transaksi');
    setState(() {
      _userTransaksi.addAll(_transaksiBox.values);
    });
  }

  void _tambahTransaksi(String judul, double jumlah, DateTime tanggal, String tipe) {
    final newTx = Transaksi(
      id: DateTime.now().toString(),
      judul: judul,
      jumlah: jumlah,
      tanggal: tanggal,
      tipe: tipe,
    );

    setState(() {
      _userTransaksi.add(newTx);
      _transaksiBox.add(newTx);
    });
  }

  void _mulaiTambahTransaksi(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => TransaksiForm(_tambahTransaksi),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Chart(_userTransaksi),
          Expanded(child: TransaksiList(_userTransaksi)),
        ],
      ),
      KalenderPage(transaksi: _userTransaksi),
      const AnggaranPage(),
      const KebutuhanPage(),
      const SumberDanaPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Moneylog'),
        actions: [],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Kalender'),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Anggaran'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Kebutuhan'),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Sumber Dana'),
        ],
      ),
      floatingActionButton: _selectedIndex == 0
          ? FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _mulaiTambahTransaksi(context),
      )
          : null,
    );
  }
}