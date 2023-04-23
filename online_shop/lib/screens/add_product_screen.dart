import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products.dart';

class AddProductScreen extends StatefulWidget {
  static const routeName = '/add-product';

  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _form = GlobalKey<FormState>();

  String id = "";
  String title = "";
  String description = "";
  double price = 0.0;
  String imageUrl = "";

  Future<void> _incrementCounter() async {
    var editedProduct = Product(
      id: id,
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
      isFavorite: false,
    );
    try {
      await Provider.of<Products>(context, listen: false)
          .addProduct(editedProduct);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: "",
                decoration: const InputDecoration(labelText: 'Id'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  id = value!;
                },
              ),
              TextFormField(
                initialValue: "",
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  title = value!;
                },
              ),
              TextFormField(
                initialValue: "",
                decoration: const InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  description = value!;
                },
              ),
              TextFormField(
                initialValue: "",
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  price = double.parse(value!);
                },
              ),
              TextFormField(
                initialValue: "",
                decoration: const InputDecoration(labelText: 'Image Url'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  imageUrl = value!;
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
