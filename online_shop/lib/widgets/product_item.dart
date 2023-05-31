import 'dart:async';

import 'package:flutter/material.dart';
import '../providers/user.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/cart.dart';
import '../screens/product_detail.dart';

class ProductItem extends StatefulWidget {
  final Product product;

  const ProductItem({super.key, required this.product});

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isHovering = false;
  final _form = GlobalKey<FormState>();

  String _idProd = "";
  String _idUser = "";

  Future<void> _submitFavorite() async {
    final isLogged = Provider.of<User>(context, listen: false).isAuth;
    if (!isLogged) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          content: const Text(
              'Va rugam sa va logati inainte de a selecta un produs favorit'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    _form.currentState?.save();

    try {
      if (widget.product.isFav(Provider.of<User>(context, listen: false).favoriteItems)) {
        await Provider.of<User>(context, listen: false)
            .favorite(_idProd, _idUser);
      } else {
        await Provider.of<User>(context, listen: false)
            .unfavorite(_idProd, _idUser);
      }
    } catch (error) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('An error occured!'),
          content: const Text('Something went wrong.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final idUser = Provider.of<User>(context).id;
    final favIds = Provider.of<User>(context).favoriteItems;

    Timer timer;
    bool isSnackbarTapped = false;

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
                        widget.product.imageUrl,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        ProductDetailScreen.routeName,
                        arguments: widget.product,
                      );
                    },
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    icon: Icon(
                      widget.product.isFav(favIds)
                          ? Icons.favorite_outlined
                          : Icons.favorite_outline_outlined,
                    ),
                    onPressed: () {
                      Provider.of<User>(context, listen: false).isAuth
                          ? (widget.product.isFav(favIds)
                          ? favIds.remove(widget.product.id) : favIds.add(widget.product.id))
                          : const SizedBox(
                              height: 0,
                            );
                      _idProd = widget.product.id;
                      _idUser = idUser;
                      _submitFavorite();
                      print(_idProd);
                      print(_idUser);
                    },
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Text(
                widget.product.title,
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
                      index <= widget.product.rating - 1
                          ? Icons.star_outlined
                          : Icons.star_border_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    );
                  }),
                  const SizedBox(width: 10),
                  Text(
                      "${widget.product.rating} (${widget.product.numberOfReviews})")
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 25),
              child: Row(
                children: [
                  Text(
                    "${widget.product.price} lei",
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
                    onPressed: () {
                      cart.addItem(widget.product.id, widget.product.price,
                          widget.product.title, Provider.of<User>(context, listen: false).id);
                      if (!isSnackbarTapped) {
                        isSnackbarTapped = true;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          content: const Text('Added item to cart!'),
                          action: SnackBarAction(
                            label: 'UNDO',
                            onPressed: () {
                              cart.removeSingleItem(widget.product.id, idUser);
                            },
                            textColor: Theme.of(context).colorScheme.surface,
                          ),
                          duration: const Duration(milliseconds: 1500),
                        ));
                        timer = Timer(const Duration(milliseconds: 1500), () {
                          isSnackbarTapped = false;
                        });
                      }
                    },
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
  }
}
