import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:scared_symmetry/components/speak_button.dart';
import 'package:scared_symmetry/models/book.dart';
import 'package:scared_symmetry/uilts/speechUtils.dart';
import 'package:scared_symmetry/views/chapter_view.dart';

class BookView extends StatefulWidget {
  final bool show;
  final AnimeBook animeBook;
  final String fileName;

  BookView(
      {required this.show, required this.animeBook, required this.fileName});

  @override
  _BookViewState createState() => _BookViewState();
}

class _BookViewState extends State<BookView> {
  Book? book; // Now nullable, since it's loaded asynchronously
  int selectedSegment = 1;
  bool animationContent = false; // Fixed typo
  bool offsetAnimation = false;
  bool isLoading = true; // Added to track loading state
  String? error; // Track errors if any during loading

  @override
  void initState() {
    super.initState();
    loadChapters();
  }

  @override
  void dispose() {
    // This is where you stop the speech when the widget is about to be disposed
    SpeechUtil.share.stopSpeaking();
    super.dispose();
  }

  void loadChapters() async {
    try {
      final String response = await rootBundle
          .loadString('assets/Scriptures/BookOfMormon/${widget.fileName}.json');
      final data = await json.decode(response);
      setState(() {
        book = Book.fromJson(data);
        isLoading = false;
        animationContent = true;
        Future.delayed(const Duration(milliseconds: 100), () {
          offsetAnimation = true;
        });
      });
    } catch (e) {
      setState(() {
        error = "Failed to load book data: $e";
        isLoading = false;
      });
    }
  }

  String showThemeOrIntro(String theme, String intro) {
    return theme.length > intro.length ? theme : intro;
  }

  @override
  Widget build(BuildContext context) {
    // if (isLoading) {
    //   return Scaffold(
    //     appBar: AppBar(title: Text('Loading...')),
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    // if (error != null) {
    //   return Scaffold(
    //     appBar: AppBar(title: Text('Error')),
    //     body: Center(child: Text(error!)),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.animeBook.engTitle, style: TextStyle(fontSize: 14)),
              Text(widget.animeBook.zhoTitle, style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.close),
        //   onPressed: () => Navigator.pop(context),
        // ),
        actions: [
          IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () {
              SpeechUtil.share.stopSpeaking();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Hero(
                  tag: widget.animeBook.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.asset(
                      'assets/images/${widget.animeBook.imageName}.png',
                      width: 200,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Aligns children across the main axis
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.animeBook.engTitle,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            Text(widget.animeBook.zhoTitle,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Text(widget.animeBook.period,
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height:
                              50), // This will push the content below to the bottom
                      SizedBox(
                        width: double.infinity,
                        child: CupertinoSegmentedControl<int>(
                          children: const {
                            0: SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text("Intro"),
                                )),
                            1: SizedBox(
                                width: double.infinity,
                                child: Center(
                                  child: Text("Chapters"),
                                )),
                          },
                          onValueChanged: (int value) {
                            setState(() {
                              selectedSegment = value;
                            });
                          },
                          groupValue: selectedSegment,
                          unselectedColor: Colors
                              .white, // Background color of unselected segments
                          selectedColor: Colors
                              .black, // Background color of selected segment
                          borderColor: Colors.black,
                          pressedColor: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 0),
          Expanded(
            child: book == null
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    // Ensuring the entire conditional content is scrollable
                    child: Column(
                      children: [
                        if (selectedSegment == 0) ...[
                          Column(
                            children: [
                              SpeakButton(
                                text: showThemeOrIntro(
                                    book!.theme.en, book!.introduction.en),
                                speechLang: SpeechLang.en,
                              ),
                              const Divider(
                                indent: 20,
                                endIndent: 20,
                              ),
                              SpeakButton(
                                text: showThemeOrIntro(
                                    book!.theme.zh, book!.introduction.zh),
                                speechLang: SpeechLang.zh,
                              ),
                            ],
                          )
                        ] else ...[
                          Container(
                            child: buildChaptersGrid(),
                          )
                        ],
                      ],
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Widget buildChaptersGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView.builder(
        shrinkWrap: true, // Use it inside a SingleChildScrollView
        physics:
            const NeverScrollableScrollPhysics(), // Disable scrolling in GridView
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 1.7,
        ),
        itemCount: book!.chapters.length,
        itemBuilder: (BuildContext context, int index) {
          Chapter chapter = book!.chapters[index];
          return InkWell(
            // Using InkWell to get visual feedback on tap
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChapterView(
                          chapter: chapter, bookTitle: book!.book)));
            },
            child: Card(
              color: Colors.black,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "${chapter.number}",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
