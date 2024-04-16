import 'package:flutter/material.dart';
import 'package:scared_symmetry/models/book.dart';
import 'package:scared_symmetry/views/bookCard.dart';
import 'package:scared_symmetry/views/bookView.dart';
import 'package:scared_symmetry/views/booksView.dart';

void main() {
  runApp(BooksApp());
}

class BooksApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scripture',
      home: BooksView(),
    );
  }
}
