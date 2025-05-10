import 'package:hive/hive.dart';

part 'transaksi.g.dart';

@HiveType(typeId: 0)
class Transaksi {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String judul;

  @HiveField(2)
  final double jumlah;

  @HiveField(3)
  final DateTime tanggal;

  @HiveField(4)
  final String tipe; // pemasukan atau pengeluaran

  Transaksi({
    required this.id,
    required this.judul,
    required this.jumlah,
    required this.tanggal,
    required this.tipe,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'judul': judul,
    'jumlah': jumlah,
    'tanggal': tanggal.toIso8601String(),
    'tipe': tipe,
  };

  factory Transaksi.fromJson(Map<String, dynamic> json) => Transaksi(
    id: json['id'],
    judul: json['judul'],
    jumlah: json['jumlah'],
    tanggal: DateTime.parse(json['tanggal']),
    tipe: json['tipe'],
  );
}