import 'package:flutter/material.dart';
import 'package:scared_symmetry/models/book.dart';

class BookCard extends StatelessWidget {
  final AnimeBook book;
  final VoidCallback onTap;
  final bool isSelected;
  final double rotationAngle;

  const BookCard(
      {Key? key,
      required this.book,
      required this.onTap,
      this.isSelected = false,
      this.rotationAngle = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform(
        transform: Matrix4.identity()..rotateX(rotationAngle),
        alignment: FractionalOffset.bottomCenter,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 270,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(5, 5),
                  blurRadius: 10)
            ],
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(book.engTitle,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Text(book.zhoTitle,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text(book.period, style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Hero(
                  tag: book.id,
                  child: Image.asset("assets/images/" + book.imageName + ".png",
                      fit: BoxFit.cover),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
