import 'package:flutter/material.dart';
import 'package:scared_symmetry/models/book.dart';
import 'package:neubrutalism_ui/neubrutalism_ui.dart';

class BookCard extends StatelessWidget {
  final AnimeBook book;
  final VoidCallback onTap;
  final bool isSelected;
  final double rotationAngle;

  const BookCard(
      {super.key,
      required this.book,
      required this.onTap,
      this.isSelected = false,
      this.rotationAngle = 0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Transform(
        transform: Matrix4.identity()..rotateX(rotationAngle),
        alignment: FractionalOffset.bottomCenter,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 270,
          child: NeuContainer(
            borderRadius: BorderRadius.circular(12),
            color: Colors.lightBlue[100],
            borderWidth: 3,
            borderColor: Colors.black,
            shadowColor: Colors.black,
            shadowBlurRadius: 0,
            child: Row(
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: NeuContainer(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      borderWidth: 3,
                      borderColor: Colors.black,
                      shadowColor: Colors.black,
                      shadowBlurRadius: 0,
                      child: Hero(
                        tag: book.id,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
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
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          book.zhoTitle,
                          style: const TextStyle(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
