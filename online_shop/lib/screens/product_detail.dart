import 'package:flutter/material.dart';

import '../widgets/home_app_bar.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';

  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      body: Center(
        child: Container(
          child: Text("Test"),
        ),
      ),
    );
  }
}
