import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import './providers/products.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(248, 43, 166, 19),
            secondary: const Color.fromARGB(249, 1, 70, 143),
            tertiary: const Color.fromARGB(248, 68, 74, 81),
            background: const Color.fromARGB(248, 255, 255, 255),
            surface: const Color.fromARGB(250, 0, 0, 0),
          ),
          //fontFamily: 'Lato',
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _form = GlobalKey<FormState>();

  String username = '';
  String password = '';

  void _incrementCounter() {
    setState(() {
      _counter++;
      final url = Uri.parse('http://localhost:8080/users');
      final response = http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({
          'name': username,
          'surname': password,
          'email': 'randomEmail',
        }),
      );

      print(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                initialValue: "",
                decoration: const InputDecoration(labelText: 'Username'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  username = value!;
                },
              ),
              TextFormField(
                initialValue: "",
                decoration: const InputDecoration(labelText: 'Parola'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  password = value!;
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
