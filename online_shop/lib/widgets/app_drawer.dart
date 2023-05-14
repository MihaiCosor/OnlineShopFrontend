import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';
import '../screens/home_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/cart_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    bool isAuth = user.isAuth;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            ),
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  'https://www.citypng.com/public/uploads/preview/black-user-member-guest-icon-31634946589seopngzc1t.png',
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(30.0),
            child: const Text(
              "Salut Cosmin!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 50),
          ListTile(
            contentPadding: const EdgeInsets.only(top: 10.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 30),
                Icon(Icons.home),
                SizedBox(width: 30),
                Text('Acasa'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(HomeScreen.routeName);
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(top: 10.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 30),
                Icon(Icons.account_box_outlined),
                SizedBox(width: 30),
                Text('Profilul meu'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(top: 10.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 30),
                Icon(Icons.shopping_cart_outlined),
                SizedBox(width: 30),
                Text('Cosul meu'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(top: 10.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(width: 30),
                Icon(Icons.local_shipping_outlined),
                SizedBox(width: 30),
                Text('Comenzile mele'),
              ],
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(OrdersScreen.routeName);
            },
          ),
          ListTile(
            contentPadding: const EdgeInsets.only(top: 150.0),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.surface,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    isAuth ? user.setIsLogged = false : user.setIsLogged = true;
                    Navigator.of(context).pop();
                  },
                  child: isAuth
                      ? const Text(
                          'Log out',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        )
                      : const Text(
                          'Log in',
                          style: TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                ),
                const SizedBox(width: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
