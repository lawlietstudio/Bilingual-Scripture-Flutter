import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:scared_symmetry/models/book.dart';

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
  int selectedSegment = 0;
  bool animationContent = false; // Fixed typo
  bool offsetAnimation = false;
  bool isLoading = true; // Added to track loading state
  String? error; // Track errors if any during loading

  @override
  void initState() {
    super.initState();
    loadChapters();
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
        Future.delayed(Duration(milliseconds: 100), () {
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
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text('Loading...')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: Text('Error')),
        body: Center(child: Text(error!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.animeBook.engTitle),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: AnimatedOpacity(
        opacity: animationContent ? 1 : 0,
        duration: Duration(milliseconds: 350),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Hero(
                      tag: widget.animeBook.id,
                      child: Image.asset(
                        'assets/images/${widget.animeBook.imageName}.png',
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Flexible(
                    //   // Use Expanded here
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(0),
                    //     child: Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text(widget.animeBook.engTitle,
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.bold)),
                    //         Text(widget.animeBook.zhoTitle,
                    //             style: TextStyle(
                    //                 fontSize: 20, fontWeight: FontWeight.bold)),
                    //         SizedBox(height: 10),
                    //         Text(widget.animeBook.period,
                    //             style: TextStyle(color: Colors.grey)),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: CupertinoSegmentedControl<int>(
                  children: {
                    0: Text("Intro"),
                    1: Text("Chapters"),
                  },
                  onValueChanged: (int value) {
                    setState(() {
                      selectedSegment = value;
                    });
                  },
                  groupValue: selectedSegment,
                ),
              ),
              SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child:
              //       Text(book!.introduction.en, style: TextStyle(fontSize: 16)),
              // ),
              // Additional UI as per your SwiftUI layout
              if (book != null) ...[
                if (selectedSegment == 0) ...[
                  Text(showThemeOrIntro(book!.theme.en, book!.introduction.en)),
                  Text(showThemeOrIntro(book!.theme.zh, book!.introduction.zh)),
                ] else ...[
                  buildChaptersGrid()
                ],
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChaptersGrid() {
    return GridView.builder(
      shrinkWrap: true, // Use it inside a SingleChildScrollView
      physics: NeverScrollableScrollPhysics(), // Disable scrolling in GridView
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 3,
      ),
      itemCount: book!.chapters.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Center(child: Text("${book!.chapters[index].number}")),
        );
      },
    );
  }
}
