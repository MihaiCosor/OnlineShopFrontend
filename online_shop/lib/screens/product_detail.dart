import 'package:flutter/material.dart';
import '../providers/product.dart';

import '../widgets/home_app_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: HomeAppBar(),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product image
              Expanded(
                flex: 2,
                child: Image.network(
                  product.imageUrl,
                  height: double.infinity,
                ),
              ),
              // Product title, description, and price
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product title
                      Text(
                        product.title,
                        style: Theme.of(context)
                            .textTheme
                            .headline6
                            ?.copyWith(fontSize: 24),
                      ),
                      SizedBox(height: 16),
                      // Product description
                      Text(
                        product.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.copyWith(fontSize: 16),
                      ),
                      SizedBox(height: 16),
                      // Product price
                      Text(
                        product.price.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headline5
                            ?.copyWith(fontSize: 36),
                      ),
                      SizedBox(height: 16),
                      // Add to cart button
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Add to Cart',
                            style: Theme.of(context)
                                .textTheme
                                .button
                                ?.copyWith(fontSize: 20)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
     ),
    );
  }
}
