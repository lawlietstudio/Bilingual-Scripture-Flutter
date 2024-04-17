import 'package:flutter/material.dart';
import 'package:scared_symmetry/uilts/speechUtils.dart';

class SpeakButton extends StatelessWidget {
  final String text;
  final SpeechLang speechLang;
  final TextStyle? style;

  const SpeakButton({
    Key? key,
    required this.text,
    required this.speechLang,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => SpeechUtil.share.speak(text, speechLang),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, // Background color
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent, // No shadow
        elevation: 0,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: style ??
              TextStyle(
                  fontSize: 14), // Default to font size 14 if no style provided
        ),
      ),
    );
  }
}
