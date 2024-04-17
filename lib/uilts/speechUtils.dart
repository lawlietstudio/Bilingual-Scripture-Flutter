import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SpeechLang { en, zh }

class SpeechUtil {
  static final SpeechUtil share = SpeechUtil();

  final FlutterTts _flutterTts = FlutterTts();

  SpeechUtil() {
    _flutterTts.setStartHandler(() {
      print("Speech started");
    });

    _flutterTts.setCompletionHandler(() {
      print("Speech completed");
    });

    _flutterTts.setErrorHandler((msg) {
      print("Speech error: $msg");
    });
  }

  void stopSpeaking() {
    _flutterTts.stop();
  }

  Future<void> speak(String text, SpeechLang speechLang) async {
    stopSpeaking(); // Ensure no other text is being spoken.

    String language;
    dynamic voice;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String selectedEngVoiceIdentifier =
        prefs.getString('selectedEngVoiceIdentifier') ?? "Samantha";
    String selectedZhoVoiceIdentifier =
        prefs.getString('selectedZhoVoiceIdentifier') ?? "Sinji";

    switch (speechLang) {
      case SpeechLang.en:
        language = "en-US";
        voice = await _getDefaultVoice(language, selectedEngVoiceIdentifier);
        break;
      case SpeechLang.zh:
        language = "zh-HK";
        voice = await _getDefaultVoice(language, selectedZhoVoiceIdentifier);
        break;
    }

    if (voice != null) {
      // Ensure the map has the correct types
      Map<String, String> voiceMap = {
        "name": voice["name"] ?? "",
        "locale": voice["locale"] ?? "",
        // Add more fields if needed, ensure non-null default values
      };

      await _flutterTts.setVoice(voiceMap);
      // await _flutterTts.setVoice(voice);
    } else {
      await _flutterTts.setLanguage(language);
    }

    await _flutterTts.speak(text);
  }

  Future<dynamic> _getDefaultVoice(
      String language, String defaultVoiceName) async {
    var voices = await _flutterTts.getVoices;
    if (voices == null) {
      return null;
    }
    var selectedVoice =
        voices.firstWhere((voice) => voice["name"] == defaultVoiceName);

    if (selectedVoice != null) {
      return selectedVoice;
    }

    return voices.firstWhere((voice) => voice["locale"] == language,
        orElse: () => null);
  }
}
