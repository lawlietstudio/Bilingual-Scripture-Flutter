import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:scared_symmetry/components/custom_divider.dart';
import 'package:scared_symmetry/components/speak_button.dart';
import 'package:scared_symmetry/models/book.dart';
import 'package:scared_symmetry/uilts/speechUtils.dart';

class ChapterView extends StatefulWidget {
  final Chapter chapter;
  final MultilingualText bookTitle;

  ChapterView({required this.chapter, required this.bookTitle});

  @override
  _ChapterViewState createState() => _ChapterViewState();
}

class _ChapterViewState extends State<ChapterView> {
  @override
  void dispose() {
    SpeechUtil.share.stopSpeaking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            children: [
              Text("${widget.bookTitle.en} - Chapter ${widget.chapter.number}",
                  style: TextStyle(fontSize: 14)),
              Text("${widget.bookTitle.zh} - 第 ${widget.chapter.number} 章",
                  style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () {
              SpeechUtil.share.stopSpeaking();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Intro",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          const CustomDivider(),
          SpeakButton(
            text: widget.chapter.introduction.en,
            speechLang: SpeechLang.en,
          ),
          const Divider(
            indent: 20,
            endIndent: 20,
          ),
          SpeakButton(
            text: widget.chapter.introduction.zh,
            speechLang: SpeechLang.zh,
          ),
          ...widget.chapter.verses.map((verse) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomDivider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Verse ${verse.key}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const CustomDivider(),
                SpeakButton(
                  text: verse.text.en,
                  speechLang: SpeechLang.en,
                ),
                const CustomDivider(),
                SpeakButton(
                  text: verse.text.zh,
                  speechLang: SpeechLang.zh,
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
