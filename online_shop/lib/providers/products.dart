import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'product.dart';

class SortOptions {
  static String get priceLowToHigh => "Pret Crescator";
  static String get priceHighToLow => "Pret Descrescator";
  static String get ratingLowToHigh => "Rating Crescator";
  static String get ratingHighToLow => "Rating Descrescator";
  static String get numberOfReviewsLowToHigh => "Numar de review-uri Crescator";
  static String get numberOfReviewsHighToLow =>
      "Numar de review-uri Descrescator";
  static String get defaultSort => "              ";
}

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      rating: 3.7,
      numberOfReviews: 888,
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      rating: 3.2,
      numberOfReviews: 657,
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
      rating: 5.0,
      numberOfReviews: 7,
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      rating: 2.3,
      numberOfReviews: 52,
    ),
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      rating: 3.7,
      numberOfReviews: 51,
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      rating: 3.2,
      numberOfReviews: 234,
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
      rating: 5.0,
      numberOfReviews: 123,
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      rating: 2.3,
      numberOfReviews: 123123,
    ),
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      rating: 3.7,
      numberOfReviews: 678,
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      rating: 3.2,
      numberOfReviews: 456,
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
      rating: 5.0,
      numberOfReviews: 25,
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
      rating: 2.3,
      numberOfReviews: 5,
    ),
  ];

  String _sortOption = SortOptions.defaultSort;
  String _searchQuery = "";

  List<Product> get items {
    if (_searchQuery != "") {
      return [..._items]
          .where(
              (element) => element.title.toLowerCase().contains(_searchQuery))
          .toList();
    }

    return [..._items];
  }

  List<Product> sortItems(List<Product> items) {
    switch (_sortOption) {
      case "              ":
        return [...items];
      case "Pret Crescator":
        return [...items]..sort((a, b) => a.price.compareTo(b.price));
      case "Pret Descrescator":
        return [...items]..sort((a, b) => b.price.compareTo(a.price));
      case "Rating Crescator":
        return [...items]..sort((a, b) => a.rating.compareTo(b.rating));
      case "Rating Descrescator":
        return [...items]..sort((a, b) => b.rating.compareTo(a.rating));
      case "Numar de review-uri Crescator":
        return [...items]
          ..sort((a, b) => a.numberOfReviews.compareTo(b.numberOfReviews));
      case "Numar de review-uri Descrescator":
        return [...items]
          ..sort((a, b) => b.numberOfReviews.compareTo(a.numberOfReviews));
      default:
        return [...items];
    }
  }

  List<Product> get favoriteItems {
    // !!!!!
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findById(String id) {
    // !!!!!
    return _items.firstWhere((product) => product.id == id);
  }

  set setSortOption(String sortOption) {
    _sortOption = sortOption;
    notifyListeners();
  }

  set setSearchQuery(String searchQuery) {
    _searchQuery = searchQuery;
    notifyListeners();
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse('http://localhost:8080/products');

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as List<dynamic>;

      // if (extractedData == null) {
      //   return;
      // }

      final List<Product> loadedProducts = [];
      for (var prodData in extractedData) {
        loadedProducts.add(Product(
          id: prodData['id'],
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: false,
          imageUrl: prodData['imageUrl'],
          rating: prodData['rating'],
          numberOfReviews: prodData['numberOfReviews'],
        ));
      }

      _items = loadedProducts;

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse('http://localhost:8080/products');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
        }),
      );

      final newProduct = Product(
        id: product.id, // DE REPARAT
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        rating: 0,
        numberOfReviews: 0,
      );
      _items.add(newProduct);

      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    // final prodIndex = _items.indexWhere((prod) => prod.id == id);
    // if (prodIndex >= 0) {
    //   final url = Uri.parse(
    //       'https://shop-app-20317-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');
    //   await http.patch(
    //     url,
    //     body: json.encode({
    //       'title': newProduct.title,
    //       'description': newProduct.description,
    //       'imageUrl': newProduct.imageUrl,
    //       'price': newProduct.price,
    //     }),
    //   );

    //   _items[prodIndex] = newProduct;

    //   notifyListeners();
    // } else {
    //   print('Ai gresit ceva calumea');
    // }
  }

  Future<void> deleteProduct(String id) async {
    // final url = Uri.parse(
    //     'https://shop-app-20317-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json');

    // final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    // Product? existingProduct = _items[existingProductIndex];

    // _items.removeAt(existingProductIndex);

    // notifyListeners();

    // final response = await http.delete(url);
    // if (response.statusCode >= 400) {
    //   _items.insert(
    //       existingProductIndex, existingProduct); // Optimistic Updating

    //   notifyListeners();
    //   throw HttpException('Could not delete product.');
    // }

    // existingProduct = null;
  }
}
