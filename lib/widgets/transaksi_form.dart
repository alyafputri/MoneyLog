import 'package:flutter/material.dart';

class TransaksiForm extends StatefulWidget {
  final Function(String, double, DateTime, String) onSubmit;

  const TransaksiForm(this.onSubmit, {super.key});

  @override
  State<TransaksiForm> createState() => _TransaksiFormState();
}

class _TransaksiFormState extends State<TransaksiForm> {
  final _judulController = TextEditingController();
  final _jumlahController = TextEditingController();
  DateTime? _tanggalTerpilih;
  String _tipe = 'pengeluaran';

  void _submitData() {
    if (_judulController.text.isEmpty ||
        _jumlahController.text.isEmpty ||
        _tanggalTerpilih == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lengkapi semua field!')),
      );
      return;
    }
    final jumlah = double.tryParse(_jumlahController.text) ?? 0.0;
    if (jumlah <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Jumlah harus lebih dari 0!')),
      );
      return;
    }
    widget.onSubmit(_judulController.text, jumlah, _tanggalTerpilih!, _tipe);
    Navigator.of(context).pop();
  }

  void _pilihTanggal() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _tanggalTerpilih = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Judul'),
              controller: _judulController,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Jumlah'),
              controller: _jumlahController,
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _tipe,
              onChanged: (value) {
                setState(() {
                  _tipe = value!;
                });
              },
              items: ['pemasukan', 'pengeluaran']
                  .map((tipe) => DropdownMenuItem(
                value: tipe,
                child: Text(tipe),
              ))
                  .toList(),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _tanggalTerpilih == null
                        ? 'Belum ada tanggal dipilih'
                        : 'Tanggal: ${_tanggalTerpilih!.toLocal().toString().split(' ')[0]}',
                  ),
                ),
                TextButton(
                  onPressed: _pilihTanggal,
                  child: const Text('Pilih Tanggal'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: _submitData,
                  child: const Text('Tambah Transaksi'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}