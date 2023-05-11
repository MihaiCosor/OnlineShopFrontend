import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/product.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  final Map<String, List<String>> _filters;

  const ProductsGrid({super.key, required Map<String, List<String>> filters})
      : _filters = filters;

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    List<Product> products = productsData.items;

    _filters.forEach((key, value) {
      List<Product> tmp = [];
      for (String filter in value) {
        tmp.addAll(products.where((product) {
          switch (key) {
            case "price":
              switch (filter) {
                case "Sub 50":
                  return product.price < 50;
                case "51 - 100":
                  return product.price >= 51 && product.price <= 100;
                case "101 - 200":
                  return product.price >= 101 && product.price <= 200;
                case "Peste 200":
                  return product.price > 200;
                default:
                  return true;
              }
            case "rating":
              switch (filter) {
                case "Sub 2.5":
                  return product.rating < 2.5;
                case "2.5 - 3.5":
                  return product.rating >= 2.5 && product.rating <= 3.5;
                case "3.6 - 4.5":
                  return product.rating >= 3.6 && product.rating <= 4.5;
                case "Peste 4.5":
                  return product.rating > 4.5;
                default:
                  return true;
              }
            case "numberOfReviews":
              switch (filter) {
                case "Sub 10":
                  return product.numberOfReviews < 10;
                case "11 - 100":
                  return product.numberOfReviews >= 11 &&
                      product.numberOfReviews <= 100;
                case "101 - 500":
                  return product.numberOfReviews >= 101 &&
                      product.numberOfReviews <= 500;
                case "501 - 1000":
                  return product.numberOfReviews >= 501 &&
                      product.numberOfReviews <= 1000;
                case "Peste 1000":
                  return product.numberOfReviews > 1000;
                default:
                  return true;
              }
            default:
              return false;
          }
        }).toList());
      }

      if (value.isNotEmpty) {
        products = tmp;
        products.toSet().toList();
      }
    });

    double width = MediaQuery.of(context).size.width;

    return Container(
      width: 0.85 * width,
      color: Theme.of(context).colorScheme.background,
      child: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (ctx, index) => ProductItem(product: products[index]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.9,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
      ),
    );
  }
}
