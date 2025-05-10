import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../models/transaksi.dart';

class Chart extends StatelessWidget {
  final List<Transaksi> transaksiTerbaru;

  const Chart(this.transaksiTerbaru, {super.key});

  List<Map<String, Object>> get dataMingguan {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));

      double totalHariIni = transaksiTerbaru.where((tx) {
        return tx.tanggal.day == weekday.day &&
            tx.tanggal.month == weekday.month &&
            tx.tanggal.year == weekday.year &&
            tx.tipe == 'pengeluaran';
      }).fold(0.0, (sum, item) => sum + item.jumlah);

      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalHariIni,
      };
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    final maxAmount = dataMingguan.isEmpty
        ? 100.0
        : dataMingguan
        .map((data) => data['amount'] as double)
        .reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: maxAmount == 0 ? 100 : maxAmount + 10,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < dataMingguan.length) {
                    return Text(
                      dataMingguan[index]['day'].toString(),
                      style: const TextStyle(fontSize: 10),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
                reservedSize: 20,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: dataMingguan.asMap().entries.map((entry) {
            final index = entry.key;
            final data = entry.value;
            final amount = data['amount'] as double;
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: amount,
                  width: 14,
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.pinkAccent,
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}