import 'package:flutter/material.dart';
import 'package:scared_symmetry/models/book.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class BookCard extends StatelessWidget {
  final AnimeBook book;
  final VoidCallback onTap;
  final bool isSelected;
  final double rotationAngle;
  final int index; // <-- Add this

  const BookCard({
    super.key,
    required this.book,
    required this.onTap,
    this.isSelected = false,
    this.rotationAngle = 0,
    required this.index, // <-- Add this
  });

  static const List<Color> cardColors = [
    Color(0xFFCC5500), // Beige
    Color(0xFFB8860B), // Acid Green
  ];

  @override
  Widget build(BuildContext context) {
    final Color cardColor = cardColors[index % cardColors.length];
    return GestureDetector(
      onTap: onTap,
      child: Transform(
        transform: Matrix4.identity()..rotateX(rotationAngle),
        alignment: FractionalOffset.bottomCenter,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 300,
          child: NeuContainer(
            borderRadius: BorderRadius.circular(12),
            color: cardColor, // <-- Use alternate color
            borderWidth: 4,
            borderColor: Colors.black,
            shadowColor: Colors.black,
            shadowBlurRadius: 0,
            child: Row(
              children: index % 2 == 1
                ? [
                  // Image on the left
                  Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: NeuContainer(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    borderWidth: 4,
                    borderColor: Colors.black,
                    shadowColor: Colors.black,
                    shadowBlurRadius: 0,
                    child: Hero(
                      tag: book.id,
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/${book.imageName}.png",
                        fit: BoxFit.cover,
                      ),
                      ),
                    ),
                    ),
                  ),
                  ),
                  Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      book.engTitle,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      Text(
                      book.zhoTitle,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      const Spacer(),
                      Text(
                      book.period,
                      style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                    ),
                  ),
                  ),
                ]
                : [
                  // Image on the right
                  Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                      book.engTitle,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      Text(
                      book.zhoTitle,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 51, 51, 51),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      const Spacer(),
                      Text(
                      book.period,
                      style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                    ),
                  ),
                  ),
                  Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: NeuContainer(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    borderWidth: 4,
                    borderColor: Colors.black,
                    shadowColor: Colors.black,
                    shadowBlurRadius: 0,
                    child: Hero(
                      tag: book.id,
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        "assets/images/${book.imageName}.png",
                        fit: BoxFit.cover,
                      ),
                      ),
                    ),
                    ),
                  ),
                  ),
                ],
            )
            ),
          ),
        ),
    );
  }
}
