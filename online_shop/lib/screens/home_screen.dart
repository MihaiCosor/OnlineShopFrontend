import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/user.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/products_grid.dart';
import '../widgets/filters.dart';
import '../widgets/app_drawer.dart';
import '../screens/add_product_screen.dart';

enum FilterOptions {
  favorites,
  all,
}

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = false;
  var _isLoading = false;

  Map<String, List<String>> _filters = {
    'price': [],
    'rating': [],
    'numberOfReviews': [],
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  applyFilters(Map<String, List<String>> filters) {
    setState(() {
      _filters = filters;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    bool isAuth = user.isAuth;
    bool isAdmin = user.isAdmin;

    return Scaffold(
      appBar: const HomeAppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              children: [
                Filters(applyFilters: applyFilters),
                ProductsGrid(
                  filters: _filters,
                ),
              ],
            ),
      drawer: const AppDrawer(),
      floatingActionButton: isAuth && isAdmin
          ? FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddProductScreen.routeName);
              },
              tooltip: 'Add Product!',
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
