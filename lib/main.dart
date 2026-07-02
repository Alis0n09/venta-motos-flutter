import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/config/app_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: AppConfig.envFileName);
  runApp(const ProviderScope(child: VentaMotosApp()));
}

class VentaMotosApp extends StatelessWidget {
  const VentaMotosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      home: const Scaffold(
        body: Center(child: Text('Venta Motos App — en construcción')),
      ),
    );
  }
}