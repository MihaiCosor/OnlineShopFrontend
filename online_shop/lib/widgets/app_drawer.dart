import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/user.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/cart_screen.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _form = GlobalKey<FormState>();

  var _isLoading = false;
  var _isAuthPopup = true;

  String _name = "";
  String _surname = "";
  String _email = "";
  String _password = "";

  Future<void> _submit() async {
    _form.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    try {
      _isAuthPopup
          ? await Provider.of<User>(context, listen: false)
              .login(_email, _password)
          : await Provider.of<User>(context, listen: false)
              .register(_name, _surname, _email, _password);
    } catch (error) {
      // await showDialog<void>(
      //   context: context,
      //   builder: (ctx) => AlertDialog(
      //     title: const Text('An error occured!'),
      //     content: const Text('Something went wrong.'),
      //     actions: [
      //       TextButton(
      //         onPressed: () {
      //           Navigator.of(ctx).pop();
      //         },
      //         child: const Text('Okay'),
      //       ),
      //     ],
      //   ),
      // );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final user = Provider.of<User>(context);
    final cart = Provider.of<Cart>(context);
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
            child: isAuth
                ? Text(
                    "Salut ${user.name}!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Text(
                    "Salut! Creaza-ti un cont pentru o experienta mai buna!",
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
              if (isAuth) {
                Navigator.of(context).pushNamed(ProfileScreen.routeName);
              } else {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return StatefulBuilder(
                      builder: (ctx2, setState) {
                        return _isLoading
                            ? const CircularProgressIndicator()
                            : _isAuthPopup
                                ? AlertDialog(
                                    title: SizedBox(
                                      width: 0.2 * width,
                                      height: 0.05 * height,
                                      child: const Text(
                                        'Autentificare',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    content: SizedBox(
                                      width: 0.2 * width,
                                      height: 0.6 * height,
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Text(
                                                'Introduceti datele de autentificare'),
                                          ),
                                          Form(
                                            key: _form,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Adresa de email'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _email = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Parola'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _password = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (_form.currentState!
                                                          .validate()) {
                                                        _submit();
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: const Text('Submit'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: _isAuthPopup
                                              ? ElevatedButton(
                                                  onPressed: () {
                                                    if (!_isAuthPopup) {
                                                      setState(() {
                                                        _isAuthPopup = true;
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Autentificare'),
                                                )
                                              : OutlinedButton(
                                                  onPressed: () {
                                                    if (!_isAuthPopup) {
                                                      setState(() {
                                                        _isAuthPopup = true;
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Autentificare'),
                                                )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: _isAuthPopup
                                            ? OutlinedButton(
                                                onPressed: () {
                                                  if (_isAuthPopup) {
                                                    setState(() {
                                                      _isAuthPopup = false;
                                                    });
                                                  }
                                                },
                                                child:
                                                    const Text('Inregistrare'),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  if (_isAuthPopup) {
                                                    setState(() {
                                                      _isAuthPopup = false;
                                                    });
                                                  }
                                                },
                                                child:
                                                    const Text('Inregistrare'),
                                              ),
                                      ),
                                    ],
                                    actionsAlignment:
                                        MainAxisAlignment.spaceAround,
                                  )
                                : AlertDialog(
                                    title: SizedBox(
                                      width: 0.2 * width,
                                      height: 0.05 * height,
                                      child: const Text(
                                        'Inregistrare',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    content: SizedBox(
                                      width: 0.2 * width,
                                      height: 0.6 * height,
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Text(
                                                'Introduceti datele de inregistrare'),
                                          ),
                                          Form(
                                            key: _form,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: 'Nume'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _surname = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Prenume'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _name = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Adresa de email'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _email = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Parola'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _password = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (_form.currentState!
                                                          .validate()) {
                                                        _submit();
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: const Text('Submit'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: _isAuthPopup
                                              ? ElevatedButton(
                                                  onPressed: () {
                                                    if (!_isAuthPopup) {
                                                      setState(() {
                                                        _isAuthPopup = true;
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Autentificare'),
                                                )
                                              : OutlinedButton(
                                                  onPressed: () {
                                                    if (!_isAuthPopup) {
                                                      setState(() {
                                                        _isAuthPopup = true;
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Autentificare'),
                                                )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: _isAuthPopup
                                            ? OutlinedButton(
                                                onPressed: () {
                                                  if (_isAuthPopup) {
                                                    setState(() {
                                                      _isAuthPopup = false;
                                                    });
                                                  }
                                                },
                                                child:
                                                    const Text('Inregistrare'),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  if (_isAuthPopup) {
                                                    setState(() {
                                                      _isAuthPopup = false;
                                                    });
                                                  }
                                                },
                                                child:
                                                    const Text('Inregistrare'),
                                              ),
                                      ),
                                    ],
                                    actionsAlignment:
                                        MainAxisAlignment.spaceAround,
                                  );
                      },
                    );
                  },
                );
              }
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
              if (isAuth) {
                Navigator.of(context).pushNamed(OrdersScreen.routeName);
              } else {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return StatefulBuilder(
                      builder: (ctx2, setState) {
                        return _isLoading
                            ? const CircularProgressIndicator()
                            : _isAuthPopup
                                ? AlertDialog(
                                    title: SizedBox(
                                      width: 0.2 * width,
                                      height: 0.05 * height,
                                      child: const Text(
                                        'Autentificare',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    content: SizedBox(
                                      width: 0.2 * width,
                                      height: 0.6 * height,
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Text(
                                                'Introduceti datele de autentificare'),
                                          ),
                                          Form(
                                            key: _form,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Adresa de email'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _email = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Parola'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _password = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (_form.currentState!
                                                          .validate()) {
                                                        _submit();
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: const Text('Submit'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: _isAuthPopup
                                              ? ElevatedButton(
                                                  onPressed: () {
                                                    if (!_isAuthPopup) {
                                                      setState(() {
                                                        _isAuthPopup = true;
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Autentificare'),
                                                )
                                              : OutlinedButton(
                                                  onPressed: () {
                                                    if (!_isAuthPopup) {
                                                      setState(() {
                                                        _isAuthPopup = true;
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Autentificare'),
                                                )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: _isAuthPopup
                                            ? OutlinedButton(
                                                onPressed: () {
                                                  if (_isAuthPopup) {
                                                    setState(() {
                                                      _isAuthPopup = false;
                                                    });
                                                  }
                                                },
                                                child:
                                                    const Text('Inregistrare'),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  if (_isAuthPopup) {
                                                    setState(() {
                                                      _isAuthPopup = false;
                                                    });
                                                  }
                                                },
                                                child:
                                                    const Text('Inregistrare'),
                                              ),
                                      ),
                                    ],
                                    actionsAlignment:
                                        MainAxisAlignment.spaceAround,
                                  )
                                : AlertDialog(
                                    title: SizedBox(
                                      width: 0.2 * width,
                                      height: 0.05 * height,
                                      child: const Text(
                                        'Inregistrare',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    content: SizedBox(
                                      width: 0.2 * width,
                                      height: 0.6 * height,
                                      child: Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(bottom: 8),
                                            child: Text(
                                                'Introduceti datele de inregistrare'),
                                          ),
                                          Form(
                                            key: _form,
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: 'Nume'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _surname = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Prenume'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _name = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Adresa de email'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _email = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: TextFormField(
                                                    obscureText: true,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText:
                                                                'Parola'),
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    onSaved: (value) {
                                                      _password = value!;
                                                    },
                                                    validator: (value) {
                                                      if (value != null &&
                                                          value.isEmpty) {
                                                        return 'Camp obligatoriu!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (_form.currentState!
                                                          .validate()) {
                                                        _submit();
                                                        Navigator.of(context)
                                                            .pop();
                                                      }
                                                    },
                                                    child: const Text('Submit'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: _isAuthPopup
                                              ? ElevatedButton(
                                                  onPressed: () {
                                                    if (!_isAuthPopup) {
                                                      setState(() {
                                                        _isAuthPopup = true;
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Autentificare'),
                                                )
                                              : OutlinedButton(
                                                  onPressed: () {
                                                    if (!_isAuthPopup) {
                                                      setState(() {
                                                        _isAuthPopup = true;
                                                      });
                                                    }
                                                  },
                                                  child: const Text(
                                                      'Autentificare'),
                                                )),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: _isAuthPopup
                                            ? OutlinedButton(
                                                onPressed: () {
                                                  if (_isAuthPopup) {
                                                    setState(() {
                                                      _isAuthPopup = false;
                                                    });
                                                  }
                                                },
                                                child:
                                                    const Text('Inregistrare'),
                                              )
                                            : ElevatedButton(
                                                onPressed: () {
                                                  if (_isAuthPopup) {
                                                    setState(() {
                                                      _isAuthPopup = false;
                                                    });
                                                  }
                                                },
                                                child:
                                                    const Text('Inregistrare'),
                                              ),
                                      ),
                                    ],
                                    actionsAlignment:
                                        MainAxisAlignment.spaceAround,
                                  );
                      },
                    );
                  },
                );
              }
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
                    Navigator.of(context).pop();
                    if (!isAuth) {
                      showDialog(
                        context: context,
                        builder: (ctx) {
                          return StatefulBuilder(
                            builder: (ctx2, setState) {
                              return _isLoading
                                  ? const CircularProgressIndicator()
                                  : _isAuthPopup
                                      ? AlertDialog(
                                          title: SizedBox(
                                            width: 0.2 * width,
                                            height: 0.05 * height,
                                            child: const Text(
                                              'Autentificare',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          content: SizedBox(
                                            width: 0.2 * width,
                                            height: 0.6 * height,
                                            child: Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 8),
                                                  child: Text(
                                                      'Introduceti datele de autentificare'),
                                                ),
                                                Form(
                                                  key: _form,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: TextFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      'Adresa de email'),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          onSaved: (value) {
                                                            _email = value!;
                                                          },
                                                          validator: (value) {
                                                            if (value != null &&
                                                                value.isEmpty) {
                                                              return 'Camp obligatoriu!';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: TextFormField(
                                                          obscureText: true,
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      'Parola'),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          onSaved: (value) {
                                                            _password = value!;
                                                          },
                                                          validator: (value) {
                                                            if (value != null &&
                                                                value.isEmpty) {
                                                              return 'Camp obligatoriu!';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 20),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            if (_form
                                                                .currentState!
                                                                .validate()) {
                                                              _submit();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Submit'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: _isAuthPopup
                                                    ? ElevatedButton(
                                                        onPressed: () {
                                                          if (!_isAuthPopup) {
                                                            setState(() {
                                                              _isAuthPopup =
                                                                  true;
                                                            });
                                                          }
                                                        },
                                                        child: const Text(
                                                            'Autentificare'),
                                                      )
                                                    : OutlinedButton(
                                                        onPressed: () {
                                                          if (!_isAuthPopup) {
                                                            setState(() {
                                                              _isAuthPopup =
                                                                  true;
                                                            });
                                                          }
                                                        },
                                                        child: const Text(
                                                            'Autentificare'),
                                                      )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: _isAuthPopup
                                                  ? OutlinedButton(
                                                      onPressed: () {
                                                        if (_isAuthPopup) {
                                                          setState(() {
                                                            _isAuthPopup =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                      child: const Text(
                                                          'Inregistrare'),
                                                    )
                                                  : ElevatedButton(
                                                      onPressed: () {
                                                        if (_isAuthPopup) {
                                                          setState(() {
                                                            _isAuthPopup =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                      child: const Text(
                                                          'Inregistrare'),
                                                    ),
                                            ),
                                          ],
                                          actionsAlignment:
                                              MainAxisAlignment.spaceAround,
                                        )
                                      : AlertDialog(
                                          title: SizedBox(
                                            width: 0.2 * width,
                                            height: 0.05 * height,
                                            child: const Text(
                                              'Inregistrare',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          content: SizedBox(
                                            width: 0.2 * width,
                                            height: 0.6 * height,
                                            child: Column(
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 8),
                                                  child: Text(
                                                      'Introduceti datele de inregistrare'),
                                                ),
                                                Form(
                                                  key: _form,
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: TextFormField(
                                                          obscureText: true,
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      'Nume'),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          onSaved: (value) {
                                                            _surname = value!;
                                                          },
                                                          validator: (value) {
                                                            if (value != null &&
                                                                value.isEmpty) {
                                                              return 'Camp obligatoriu!';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: TextFormField(
                                                          obscureText: true,
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      'Prenume'),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          onSaved: (value) {
                                                            _name = value!;
                                                          },
                                                          validator: (value) {
                                                            if (value != null &&
                                                                value.isEmpty) {
                                                              return 'Camp obligatoriu!';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: TextFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      'Adresa de email'),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          onSaved: (value) {
                                                            _email = value!;
                                                          },
                                                          validator: (value) {
                                                            if (value != null &&
                                                                value.isEmpty) {
                                                              return 'Camp obligatoriu!';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: TextFormField(
                                                          obscureText: true,
                                                          decoration:
                                                              const InputDecoration(
                                                                  labelText:
                                                                      'Parola'),
                                                          textInputAction:
                                                              TextInputAction
                                                                  .next,
                                                          onSaved: (value) {
                                                            _password = value!;
                                                          },
                                                          validator: (value) {
                                                            if (value != null &&
                                                                value.isEmpty) {
                                                              return 'Camp obligatoriu!';
                                                            }
                                                            return null;
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 20),
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            if (_form
                                                                .currentState!
                                                                .validate()) {
                                                              _submit();
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }
                                                          },
                                                          child: const Text(
                                                              'Submit'),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: _isAuthPopup
                                                    ? ElevatedButton(
                                                        onPressed: () {
                                                          if (!_isAuthPopup) {
                                                            setState(() {
                                                              _isAuthPopup =
                                                                  true;
                                                            });
                                                          }
                                                        },
                                                        child: const Text(
                                                            'Autentificare'),
                                                      )
                                                    : OutlinedButton(
                                                        onPressed: () {
                                                          if (!_isAuthPopup) {
                                                            setState(() {
                                                              _isAuthPopup =
                                                                  true;
                                                            });
                                                          }
                                                        },
                                                        child: const Text(
                                                            'Autentificare'),
                                                      )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8),
                                              child: _isAuthPopup
                                                  ? OutlinedButton(
                                                      onPressed: () {
                                                        if (_isAuthPopup) {
                                                          setState(() {
                                                            _isAuthPopup =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                      child: const Text(
                                                          'Inregistrare'),
                                                    )
                                                  : ElevatedButton(
                                                      onPressed: () {
                                                        if (_isAuthPopup) {
                                                          setState(() {
                                                            _isAuthPopup =
                                                                false;
                                                          });
                                                        }
                                                      },
                                                      child: const Text(
                                                          'Inregistrare'),
                                                    ),
                                            ),
                                          ],
                                          actionsAlignment:
                                              MainAxisAlignment.spaceAround,
                                        );
                            },
                          );
                        },
                      );
                    } else {
                      user.logout();
                      cart.clearCart();
                    }
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
