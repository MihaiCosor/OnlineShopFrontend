import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final int numberOfReviews;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.numberOfReviews,
    this.isFavorite = false,
  });

  bool isFav(List<String> prodId) {
    return prodId.contains(id);
  }
}
