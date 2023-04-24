import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/products.dart';
import './screens/home_screen.dart';
import './screens/add_product_screen.dart';

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
        title: 'Online Shop',
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
        routes: {
          HomeScreen.routeName: (ctx) => const HomeScreen(),
          AddProductScreen.routeName: (ctx) => const AddProductScreen(),
        },
      ),
    );
  }
}
