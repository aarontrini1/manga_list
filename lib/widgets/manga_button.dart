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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
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
          backgroundColor: imagePath != null ? Colors.transparent : (backgroundColor ?? colorScheme.primaryContainer),
          foregroundColor: imagePath != null ? Colors.white : colorScheme.onPrimaryContainer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          minimumSize: const Size(double.infinity, 100),
          elevation: imagePath != null ? 0 : 5,
          padding: EdgeInsets.zero,
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: Container(
          width: double.infinity,
          height: height,
          alignment: Alignment.bottomRight,
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
          decoration: imagePath != null ? BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ) : null,
          child: Text(
            '$title >',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}