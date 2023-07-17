import 'package:flutter/material.dart';

import 'Screens/CameraFreq.dart';
import 'Screens/DecayTimer.dart';
import 'Screens/MainMenu.dart';
import 'Screens/RaidCalculator.dart';
import 'Screens/Settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: '',
      initialRoute: '/home',
      routes: {
        '/home': (context) => const MainMenu(),
        '/decayTimer': (context) => const DecayTimer(),
        '/cameraFreq': (context) => const CamerasFreq(),
        '/settingsMenu': (context) => const SettingsMenu(),
        '/raidCalculator': (context) => const RaidCalculator(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const MainMenu(),
      ),
    ),
  );
}
