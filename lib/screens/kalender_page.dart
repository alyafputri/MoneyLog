import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/transaksi.dart';

class KalenderPage extends StatefulWidget {
  final List<Transaksi> transaksi;
  const KalenderPage({super.key, required this.transaksi});

  @override
  _KalenderPageState createState() => _KalenderPageState();
}

class _KalenderPageState extends State<KalenderPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  Map<DateTime, List<Transaksi>> _getEvents() {
    final events = <DateTime, List<Transaksi>>{};
    for (var tx in widget.transaksi) {
      final date = DateTime(tx.tanggal.year, tx.tanggal.month, tx.tanggal.day);
      events[date] = events[date] ?? [];
      events[date]!.add(tx);
    }
    return events;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalender')),
      body: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        eventLoader: (day) => _getEvents()[DateTime(day.year, day.month, day.day)] ?? [],
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _selectedDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }
}