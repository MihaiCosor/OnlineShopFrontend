import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  const CartItem({
    super.key,
    required this.id,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                child: Text('$price lei'),
              ),
            ),
          ),
          title: Text(title),
          subtitle: Text('Total: ${price * quantity} lei'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 35,
                width: 35,
                child: FloatingActionButton(
                  onPressed: () {
                    if (quantity == 1) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Esti sigur?'),
                          content:
                              const Text('Vrei sa elimini produsul din cos?'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                                child: const Text('Nu')),
                            TextButton(
                                onPressed: () {
                                  Provider.of<Cart>(context, listen: false)
                                      .removeSingleItem(productId);
                                  Navigator.of(ctx).pop(true);
                                },
                                child: const Text('Da')),
                          ],
                        ),
                      );
                    } else {
                      Provider.of<Cart>(context, listen: false)
                          .removeSingleItem(productId);
                    }
                  },
                  backgroundColor: Theme.of(context).colorScheme.background,
                  child: const Icon(
                    Icons.remove,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Text('$quantity x'),
              ),
              SizedBox(
                height: 35,
                width: 35,
                child: FloatingActionButton(
                  onPressed: () {
                    Provider.of<Cart>(context, listen: false)
                        .addItem(productId, price, title);
                  },
                  backgroundColor: Theme.of(context).colorScheme.background,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 150),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Esti sigur?'),
                      content: const Text('Vrei sa elimini produsul din cos?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop(false);
                            },
                            child: const Text('Nu')),
                        TextButton(
                            onPressed: () {
                              Provider.of<Cart>(context, listen: false)
                                  .removeItem(productId);
                              Navigator.of(ctx).pop(true);
                            },
                            child: const Text('Da')),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 50),
            ],
          ),
        ),
      ),
    );
  }
}
