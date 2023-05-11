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

  var _editedProduct = Product(
    id: "",
    title: "",
    description: "",
    price: 0.0,
    imageUrl: "",
    rating: 0.0,
    numberOfReviews: 0,
  );

  Future<void> _addProdduct() async {
    _form.currentState!.save();

    try {
      await Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct);
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
                  _editedProduct = Product(
                    id: value!,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    rating: _editedProduct.rating,
                    numberOfReviews: _editedProduct.numberOfReviews,
                  );
                },
              ),
              TextFormField(
                initialValue: "",
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: value!,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    rating: _editedProduct.rating,
                    numberOfReviews: _editedProduct.numberOfReviews,
                  );
                },
              ),
              TextFormField(
                initialValue: "",
                decoration: const InputDecoration(labelText: 'Description'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: value!,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    rating: _editedProduct.rating,
                    numberOfReviews: _editedProduct.numberOfReviews,
                  );
                },
              ),
              TextFormField(
                initialValue: "",
                decoration: const InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value!),
                    imageUrl: _editedProduct.imageUrl,
                    rating: _editedProduct.rating,
                    numberOfReviews: _editedProduct.numberOfReviews,
                  );
                },
              ),
              TextFormField(
                initialValue: "",
                decoration: const InputDecoration(labelText: 'Image Url'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: value!,
                    rating: _editedProduct.rating,
                    numberOfReviews: _editedProduct.numberOfReviews,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProdduct,
        tooltip: 'Add Product',
        child: const Icon(Icons.add),
      ),
    );
  }
}
