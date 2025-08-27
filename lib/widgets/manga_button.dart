import 'package:flutter/material.dart';

class MangaButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final double height;
  final String mangaKey;
  final String? imagePath;

  const MangaButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.imagePath,
    this.backgroundColor,
    this.height = 100,
    required this.mangaKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: imagePath != null 
          ? DecorationImage(
              image: AssetImage(imagePath!),
              fit: BoxFit.cover,
            )
          : null,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        key: Key(mangaKey),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue.shade800,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          minimumSize: const Size(double.infinity, 100),
          elevation: 5,
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          height: height,
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.all(12),
          child: Text(
            '$title >',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
