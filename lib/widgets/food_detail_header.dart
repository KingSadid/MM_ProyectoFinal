import 'package:flutter/material.dart';

class FoodDetailHeader extends StatelessWidget {
  final String imageUrl;

  const FoodDetailHeader({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      child: Image.network(
        imageUrl,
        height: 320,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 320,
          color: Colors.grey[300],
          child: const Icon(Icons.image_not_supported, size: 64),
        ),
      ),
    );
  }
}
