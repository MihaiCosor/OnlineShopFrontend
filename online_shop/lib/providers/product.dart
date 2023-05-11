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

  void _setFavValue(bool newValue) {
    isFavorite = newValue;

    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    //   final url = Uri.parse(
    //       'https://shop-app-20317-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
    //   final oldStatus = isFavorite; // Optimistic updating

    isFavorite = !isFavorite;
    notifyListeners();

    //   try {
    //     final response = await http.patch(
    //       url,
    //       body: json.encode({
    //         'isFavorite': isFavorite,
    //       }),
    //     );

    //     if (response.statusCode >= 400) {
    //       _setFavValue(oldStatus);
    //     }
    //   } catch (error) {
    //     _setFavValue(oldStatus);
    //   }
  }
}
