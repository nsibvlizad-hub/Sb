import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about.dart';

void main() {
  runApp(const SettingsApp());
}

class SettingsApp extends StatelessWidget {
  const SettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Settings Clone",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SettingsHome(),
    );
  }
}

class SettingsHome extends StatelessWidget {
  const SettingsHome({super.key});

  final List<Map<String, dynamic>> settingsItems = const [
    {"icon": Icons.wifi, "title": "Connections", "url": "android.settings.WIFI_SETTINGS"},
    {"icon": Icons.devices, "title": "Connected devices", "url": "android.settings.BLUETOOTH_SETTINGS"},
    {"icon": Icons.volume_up, "title": "Sounds and vibration", "url": "android.settings.SOUND_SETTINGS"},
    {"icon": Icons.notifications, "title": "Notifications", "url": "android.settings.NOTIFICATION_SETTINGS"},
    {"icon": Icons.brightness_6, "title": "Display", "url": "android.settings.DISPLAY_SETTINGS"},
    {"icon": Icons.wallpaper, "title": "Wallpaper and style", "url": "android.settings.WALLPAPER_SETTINGS"},
    {"icon": Icons.security, "title": "Privacy & Security", "url": "android.settings.PRIVACY_SETTINGS"},
    {"icon": Icons.phone_android, "title": "About Phone", "url": "about"},
  ];

  Future<void> _openSystemSetting(String url, BuildContext context) async {
    if (url == "about") {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutPage()));
    } else {
      final uri = Uri(scheme: "android", host: "intent", queryParameters: {"action": url});
      if (!await launchUrl(uri)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Could not open $url")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView.builder(
        itemCount: settingsItems.length,
        itemBuilder: (context, index) {
          final item = settingsItems[index];
          return ListTile(
            leading: Icon(item["icon"], color: Colors.blue),
            title: Text(item["title"]),
            onTap: () => _openSystemSetting(item["url"], context),
          );
        },
      ),
    );
  }
}
