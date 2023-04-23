import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  void _incrementCounter() {
    setState(() {
      final url = Uri.parse('http://localhost:8080/products');
      final response = http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({
          'id': id,
          'title': title,
          'description': description,
          'price': price,
          'imageUrl': imageUrl,
        }),
      );

      print(response);
    });
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
