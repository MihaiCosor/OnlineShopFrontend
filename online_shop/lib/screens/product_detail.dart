import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:online_shop/widgets/home_app_bar.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/user.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  static const routeName = '/product-detail';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _form = GlobalKey<FormState>();

  double _rating = 0.0;
  String _idProd = "";
  String _idUser = "";

  bool submitError = false;

  Future<void> _submitRating() async {
    final isLogged = Provider.of<User>(context, listen: false).isAuth;
    if (!isLogged) {
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          content: const Text('Va rugam sa va logati inainte de a da review'),
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
      await Provider.of<User>(context, listen: false)
          .rating(_rating, _idProd, _idUser);
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
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final idUser = Provider.of<User>(context, listen: false).id;
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
                Image.network(
                  product.imageUrl,
                  width: 300,
                  height: 400,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Descriere:',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  product.description,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'Review-ul tau:',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 15),
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      RatingBar.builder(
                        initialRating: _rating,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        onRatingUpdate: (rating) => {
                          setState(() => {
                            submitError = false,
                                _rating = rating,
                                _idProd = product.id,
                                _idUser = idUser,
                                print(_rating),
                                print(_idProd),
                                print(_idUser),
                              })
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (_form.currentState!.validate() &&
                                _rating != 0) {
                              _submitRating();
                            } else {
                              setState(() {
                                submitError = true;
                              });
                            }
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                      SizedBox(height: 0.01 * height),
                      submitError
                          ? const Text(
                              'Va rugam sa introduceti un numar de review-uri!',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 20),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ...List.generate(5, (index) {
                      return Icon(
                        index <= product.rating - 1
                            ? Icons.star_outlined
                            : Icons.star_border_outlined,
                        color: Theme.of(context).colorScheme.primary,
                        size: 30,
                      );
                    }),
                    const SizedBox(width: 10),
                    Text(
                      "${product.rating} (${product.numberOfReviews})",
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
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
