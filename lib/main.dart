import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final MethodChannel platform = const MethodChannel('config_channel');

  String _flavor = '';

  @override
  void initState() {
    super.initState();
    _checkFlavor();
  }

  Future<void> _checkFlavor() async {
    try {
      final String result = await platform.invokeMethod('currentFlavor');
      setState(() {
        _flavor = result;
      });
    } catch (e) {
      throw ('failed to invoke currentFlavor: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(_flavor),
        ),
      ),
    );
  }
}
