import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/anggaran_page.dart';
import 'screens/kalender_page.dart';
import 'models/transaksi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TransaksiAdapter());
  runApp(const MoneylogApp());
}

class MoneylogApp extends StatelessWidget {
  const MoneylogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Moneylog',
      theme: ThemeData(
        primaryColor: Colors.pink[100],
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.pinkAccent,
          secondary: Colors.purpleAccent,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.purple,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/anggaran': (context) => const AnggaranPage(),
        '/kalender': (context) => const KalenderPage(transaksi: []),
        '/ringkasan': (context) => const Scaffold(body: Center(child: Text('Ringkasan'))),
        '/terjadwal': (context) => const Scaffold(body: Center(child: Text('Terjadwal'))),
        '/rekening': (context) => const Scaffold(body: Center(child: Text('Rekening'))),
        '/kartu': (context) => const Scaffold(body: Center(child: Text('Kartu Kredit'))),
        '/hutang': (context) => const Scaffold(body: Center(child: Text('Hutang'))),
        '/diagram': (context) => const Scaffold(body: Center(child: Text('Diagram'))),
        '/peralatan': (context) => const Scaffold(body: Center(child: Text('Peralatan'))),
      },
    );
  }
}