import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaksi.dart';

class TransaksiList extends StatelessWidget {
  final List<Transaksi> transaksi;

  const TransaksiList(this.transaksi, {super.key});

  @override
  Widget build(BuildContext context) {
    return transaksi.isEmpty
        ? const Center(child: Text('Belum ada transaksi'))
        : ListView.builder(
      itemCount: transaksi.length,
      itemBuilder: (ctx, index) {
        final tx = transaksi[index];
        return Dismissible(
          key: Key(tx.id),
          onDismissed: (direction) {
            // Logika hapus akan ditambahkan di HomeScreen
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.pink[100],
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text(
                      NumberFormat.currency(locale: 'id', symbol: 'Rp ').format(tx.jumlah),
                    ),
                  ),
                ),
              ),
              title: Text(
                tx.judul,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Text(DateFormat.yMMMd().format(tx.tanggal)),
            ),
          ),
        );
      },
    );
  }
}