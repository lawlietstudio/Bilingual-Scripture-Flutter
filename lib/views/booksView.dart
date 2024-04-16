import 'package:flutter/material.dart';
import 'package:scared_symmetry/models/book.dart';
import 'package:scared_symmetry/views/bookCard.dart';
import 'package:scared_symmetry/views/bookView.dart';

class BooksView extends StatefulWidget {
  @override
  _BooksViewState createState() => _BooksViewState();
}

class _BooksViewState extends State<BooksView> {
  AnimeBook? selectedBook;

  void openBookDetail(AnimeBook book) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) =>
          BookView(show: true, animeBook: book, fileName: book.imageName),
    ));
  }

  @override
  Widget build(BuildContext context) {
    List<AnimeBook> books = getBooks();

    return Scaffold(
      appBar: AppBar(title: Text('Scripture')),
      body: ListWheelScrollView.useDelegate(
        itemExtent: 300,
        diameterRatio: 3.7,
        offAxisFraction: -0.4,
        childDelegate: ListWheelChildBuilderDelegate(
          builder: (BuildContext context, int index) {
            if (index < 0 || index >= books.length) return null;
            AnimeBook book = books[index];
            return BookCard(
              book: book,
              onTap: () => openBookDetail(book),
              isSelected: selectedBook == book,
              rotationAngle: selectedBook == book ? -0.2 : 0,
            );
          },
          childCount: books.length,
        ),
      ),
    );
  }

  List<AnimeBook> getBooks() {
    return [
      AnimeBook(
          id: "1",
          engTitle: "THE FIRST BOOK OF NEPHI",
          zhoTitle: "尼腓一書",
          imageName: "1-ne",
          period: "About 600 B.C."),
      AnimeBook(
          id: "2",
          engTitle: "THE SECOND BOOK OF NEPHI",
          zhoTitle: "尼腓二書",
          imageName: "2-ne",
          period: "About 588–570 B.C."),
      AnimeBook(
          id: "3",
          engTitle: "THE BOOK OF JACOB",
          zhoTitle: "雅各書",
          imageName: "jacob",
          period: "About 544–421 B.C."),
      AnimeBook(
          id: "4",
          engTitle: "THE BOOK OF ENOS",
          zhoTitle: "以挪士書",
          imageName: "enos",
          period: "About 420 B.C."),
      AnimeBook(
          id: "5",
          engTitle: "THE BOOK OF JAROM",
          zhoTitle: "雅龍書",
          imageName: "jarom",
          period: "About 399–361 B.C."),
      AnimeBook(
          id: "6",
          engTitle: "THE BOOK OF OMNI",
          zhoTitle: "奧姆乃書",
          imageName: "omni",
          period: "About 323–130 B.C."),
      AnimeBook(
          id: "7",
          engTitle: "THE WORDS OF MORMON",
          zhoTitle: "摩爾門語",
          imageName: "w-of-m",
          period: "About A.D. 385."),
      AnimeBook(
          id: "8",
          engTitle: "THE BOOK OF MOSIAH",
          zhoTitle: "摩賽亞書",
          imageName: "mosiah",
          period: "About 130–124 B.C."),
      AnimeBook(
          id: "9",
          engTitle: "THE BOOK OF ALMA",
          zhoTitle: "阿爾瑪書",
          imageName: "alma",
          period: "About 91–88 B.C."),
      AnimeBook(
          id: "10",
          engTitle: "THE BOOK OF HELAMAN",
          zhoTitle: "希拉曼書",
          imageName: "hel",
          period: "About 52–50 B.C."),
      AnimeBook(
          id: "11",
          engTitle: "THIRD NEPHI",
          zhoTitle: "尼腓三書",
          imageName: "3-ne",
          period: "About A.D. 1–4."),
      AnimeBook(
          id: "12",
          engTitle: "FOURTH NEPHI",
          zhoTitle: "尼腓四書",
          imageName: "4-ne",
          period: "About A.D. 35–321."),
      AnimeBook(
          id: "13",
          engTitle: "THE BOOK OF MORMON",
          zhoTitle: "摩爾門書",
          imageName: "morm",
          period: "About A.D. 321–26."),
      AnimeBook(
          id: "14",
          engTitle: "THE BOOK OF ETHER",
          zhoTitle: "以帖書",
          imageName: "ether",
          period: ""),
      AnimeBook(
          id: "15",
          engTitle: "THE BOOK OF MORONI",
          zhoTitle: "摩羅乃書",
          imageName: "moro",
          period: "About A.D. 401–21."),
      AnimeBook(
          id: "16",
          engTitle: "THE DOCTRINE AND COVENANTS",
          zhoTitle: "教義和聖約",
          imageName: "dc",
          period: ""),
    ];
  }
}
