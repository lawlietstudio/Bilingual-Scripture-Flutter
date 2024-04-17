import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingView extends StatefulWidget {
  @override
  _SettingViewState createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  String? selectedEngVoiceIdentifier;
  String? selectedZhoVoiceIdentifier;
  late List<dynamic> englishVoices = [];
  late List<dynamic> chineseVoices = [];
  bool useDarkMode = false;

  @override
  void initState() {
    super.initState();
    loadVoices();
    _loadVoiceSetting();
  }

  void loadVoices() async {
    FlutterTts flutterTts = FlutterTts();
    var voices = await flutterTts.getVoices;

    var uniqueNames = HashSet<String>();

    setState(() {
      if (voices != null) {
        englishVoices = voices.where((voice) {
          return voice["locale"] != null &&
              voice["locale"].contains("en") &&
              uniqueNames.add(voice["name"]);
        }).toList();

        uniqueNames.clear(); // Clear the set for the next filtering

        chineseVoices = voices.where((voice) {
          return voice["locale"] != null &&
              (voice["locale"].contains("zh") ||
                  voice["locale"].contains("yue")) &&
              uniqueNames.add(voice["name"]);
        }).toList();
      }
    });
  }

  void _saveVoiceSetting(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  void _loadVoiceSetting() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedEngVoiceIdentifier =
          prefs.getString('selectedEngVoiceIdentifier');
      selectedZhoVoiceIdentifier =
          prefs.getString('selectedZhoVoiceIdentifier');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Column(
            children: [
              Text("Setting", style: TextStyle(fontSize: 14)),
              Text("設定", style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(useDarkMode ? Icons.wb_sunny : Icons.nights_stay),
        //     onPressed: () {
        //       setState(() {
        //         useDarkMode = !useDarkMode;
        //       });
        //     },
        //   )
        // ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Eng Voice:"),
                    ),
                    DropdownButton<String>(
                      value: selectedEngVoiceIdentifier,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedEngVoiceIdentifier = newValue;
                          });
                          _saveVoiceSetting(
                              'selectedEngVoiceIdentifier', newValue);
                        }
                      },
                      items:
                          englishVoices.map<DropdownMenuItem<String>>((voice) {
                        return DropdownMenuItem<String>(
                          value: voice["name"],
                          child: Text("${voice["name"]} (${voice["locale"]})"),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Zho Voice:"),
                    ),
                    DropdownButton<String>(
                      value: selectedZhoVoiceIdentifier,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            selectedZhoVoiceIdentifier = newValue;
                          });
                          _saveVoiceSetting(
                              'selectedZhoVoiceIdentifier', newValue);
                        }
                      },
                      items:
                          chineseVoices.map<DropdownMenuItem<String>>((voice) {
                        return DropdownMenuItem<String>(
                          value: voice["name"],
                          child: Text("${voice["name"]} (${voice["locale"]})"),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
