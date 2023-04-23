import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({super.key});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    //final cart = Provider.of<Cart>(context, listen: false);

    return MouseRegion(
      onExit: (event) => setState(() {
        isHovering = false;
      }),
      onEnter: (event) => setState(() {
        isHovering = true;
      }),
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Colors.grey,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: isHovering ? 20 : 0,
        child: Column(
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Stack(
                children: [
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: 100,
                      width: double.infinity,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //   ProductDetailscreen.routeName,
                      //   arguments: product.id,
                      // );
                    },
                  ),
                  Consumer<Product>(
                    builder: (ctx, product, child) => IconButton(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      padding: const EdgeInsets.only(top: 15, left: 15),
                      icon: Icon(
                        product.isFavorite
                            ? Icons.favorite_outlined
                            : Icons.favorite_outline_outlined,
                      ),
                      onPressed: () {
                        product.toggleFavoriteStatus();
                      },
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                product.title,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...List.generate(5, (index) {
                    return Icon(
                      index < 3 //product.rating///////////////////////////////////////////////////////////////////////
                          ? Icons.star_outlined
                          : Icons.star_border_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  }),
                  const SizedBox(width: 10),
                  const Text(
                      "3.20 (10)") //${product.rating}///////////////////////////////////////////////////////
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 25),
              child: Row(
                children: [
                  Text(
                    "${product.price} lei",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Adauga in cos"),
                  IconButton(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onPressed: () {},
                    icon: const Icon(Icons.add_circle_outline_outlined),
                    color: Theme.of(context).colorScheme.background,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

    // return ClipRRect(
    //   borderRadius: BorderRadius.circular(10),
    //   child: GridTile(
    //     footer: GridTileBar(
    //       backgroundColor: Colors.black87,
    //       leading: Consumer<Product>(
    //         builder: (ctx, product, child) => IconButton(
    //           icon: Icon(
    //             product.isFavorite ? Icons.favorite : Icons.favorite_border,
    //           ),
    //           onPressed: () {
    //             product.toggleFavoriteStatus();
    //           },
    //           color: Theme.of(context).colorScheme.secondary,
    //         ),
    //       ),
    //       trailing: IconButton(
    //         icon: const Icon(Icons.shopping_cart),
    //         onPressed: () {
    //           //cart.addItem(product.id, product.price, product.title);
    //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
    //           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //             content: const Text('Added item to cart!'),
    //             action: SnackBarAction(
    //               label: 'UNDO',
    //               onPressed: () {
    //                 //cart.removeSingeItem(product.id);
    //               },
    //             ),
    //             duration: const Duration(milliseconds: 1500),
    //           ));
    //         },
    //         color: Theme.of(context).colorScheme.secondary,
    //       ),
    //     ),
    //   ),
    // );
  }
}
