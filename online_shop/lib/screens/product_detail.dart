import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:online_shop/widgets/home_app_bar.dart';

import '../providers/product.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const HomeAppBar(),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
                Image.network(
                  product.imageUrl,
                  width: 300,
                  height: 400,
                ),
                const SizedBox(height: 40),
                const Text(
                  'Descriere:',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '${product.price} lei',
                  style: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const RatingBarList(),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Adauga in cos',
                      style: TextStyle(
                        fontSize: 30,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RatingBarList extends StatefulWidget {
  const RatingBarList({super.key});

  @override
  State<RatingBarList> createState() => _RatingState();
}

class _RatingState extends State<RatingBarList> {
  double rating = 0;

  void showRating() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: const [
              Center(
                child: Text(
                  'Va rugam sa lasati un rating acestui produs',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              )
            ],
          ),
          actions: [
            Center(child: buildRating()),
            const SizedBox(height: 5),
            Center(
              child: TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      );

  Widget buildRating() => RatingBar.builder(
        initialRating: rating,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.yellow,
        ),
        onRatingUpdate: (rating) => {
          setState(() => {
                this.rating = rating,
              })
        },
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => showRating(),
          child: const Center(
            child: Text(
              'Rating',
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
      ],
    );
  }
}
