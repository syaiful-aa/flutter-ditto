import 'package:flutter/material.dart';
import 'package:third_parties/package_info.dart';
import 'package:third_parties/shorebird_code_push.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final ShorebirdCodePush codePush = ShorebirdCodePush();

  String _appVersion = '';
  bool _isLoggerEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkAppVersion();
    _checkIsLoggerEnabled();
  }

  Future<void> _checkAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final int patch = await codePush.currentPatchNumber() ?? 0;

    setState(() {
      _appVersion =
          '${packageInfo.appName} - v${packageInfo.version} (${packageInfo.buildNumber})';
    });

    if (patch > 0) {
      _appVersion += ' - patch $patch';
    }
  }

  void _checkIsLoggerEnabled() {
    bool result = const bool.fromEnvironment(
      'showMonitoring',
      defaultValue: false,
    );

    setState(() {
      _isLoggerEnabled = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Text(
                "Logger status: ${_isLoggerEnabled ? 'enabled' : 'disabled'}",
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 16,
              child: Text(
                _appVersion,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//