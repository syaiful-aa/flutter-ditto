import 'package:flutter/material.dart';
import 'package:third_parties/package_info.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _appInfo = '';

  @override
  void initState() {
    super.initState();
    _checkAppName();
  }

  Future<void> _checkAppName() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appInfo =
          '${packageInfo.appName} - v${packageInfo.version} (${packageInfo.buildNumber})';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(_appInfo),
        ),
      ),
    );
  }
}
