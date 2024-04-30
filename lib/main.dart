import 'package:app_medicamentos/utils/forwarder.dart';
import 'package:flutter/material.dart';
import 'package:app_medicamentos/pages/start_page.dart';
import 'package:app_medicamentos/pages/home_page.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:app_medicamentos/provider/patprovider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Forwarder(),
    );
  }

  Future<void> select(BuildContext context) async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'medicamentos.db'),
      version: 1,
      onCreate: (db, version) {
        // Aquí puedes definir la estructura de tu base de datos
        return db.execute(
          'CREATE TABLE Usuario(id INTEGER PRIMARY KEY, nombre TEXT)',
        );
      },
    );

    final List<Map<String, dynamic>> map1 = await database.rawQuery(
      'SELECT * FROM Usuario LIMIT 1',
    );

    if (map1.isNotEmpty) {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const HomePage(),
        ),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => const StartPage(),
        ),
        (route) => false,
      );
    }
  }
}
