import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import '../screens/cart_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/profile_screen.dart';
import './my_badge.dart';

class HomeAppBar extends StatefulWidget with PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  final _form = GlobalKey<FormState>();

  var _isLoading = false;
  var _isAuthPopup = true;

  String _name = "";
  String _surname = "";
  String _email = "";
  String _password = "";

  String _sortOption = SortOptions.defaultSort;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _searchController.addListener(_onSearchInputChange);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _searchController.dispose();
    super.dispose();
  }

  _onSearchInputChange() {
    Provider.of<Products>(context, listen: false).searchQuery =
        _searchController.text;
  }

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

  _setSortOption(String sortOption) {
    setState(() {
      _sortOption = sortOption;
      Provider.of<Products>(context, listen: false).sortOption = sortOption;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final user = Provider.of<User>(context);
    bool isAuth = user.isAuth;

    return AppBar(
      title: Row(
        children: const [
          SizedBox(
            width: 100,
          ),
          Text('Shop', style: TextStyle(color: Colors.black)),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      foregroundColor: Theme.of(context).colorScheme.surface,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 25.0, right: 15.0),
          child: Text(
            'Sorteaza dupa ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.surface,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Theme(
          data: Theme.of(context).copyWith(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: PopupMenuButton(
            tooltip: "",
            onSelected: (selectedValue) {
              switch (selectedValue) {
                case 0:
                  _setSortOption(SortOptions.priceLowToHigh);
                  break;
                case 1:
                  _setSortOption(SortOptions.priceHighToLow);
                  break;
                case 2:
                  _setSortOption(SortOptions.ratingLowToHigh);
                  break;
                case 3:
                  _setSortOption(SortOptions.ratingHighToLow);
                  break;
                case 4:
                  _setSortOption(SortOptions.numberOfReviewsLowToHigh);
                  break;
                case 5:
                  _setSortOption(SortOptions.numberOfReviewsHighToLow);
                  break;
                case 6:
                  _setSortOption(SortOptions.defaultSort);
                  break;
                default:
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                value: 0,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    SortOptions.priceLowToHigh.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    SortOptions.priceHighToLow.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 2,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    SortOptions.ratingLowToHigh.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 3,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    SortOptions.ratingHighToLow.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 4,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    SortOptions.numberOfReviewsLowToHigh.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              PopupMenuItem(
                value: 5,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    SortOptions.numberOfReviewsHighToLow.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const PopupMenuItem(
                value: 6,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Nesortat",
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
            position: PopupMenuPosition.under,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                padding: const EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(0.5),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  _sortOption.toString(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: AnimSearchBar(
            boxShadow: false,
            helpText: "Cauta produsul dorit ...",
            width: 400,
            color: Theme.of(context).colorScheme.primary,
            textController: _searchController,
            onSuffixTap: () {
              setState(() {
                _searchController.clear();
              });
            },
            onSubmitted: (value) {},
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
          child: Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              SizedBox(
                width: 50,
                child: Consumer<Cart>(
                  builder: (_, cart, ch) => MyBadge(
                    value: cart.itemCount.toString(),
                    color: Theme.of(context).colorScheme.background,
                    child: ch!,
                  ),
                  child: const Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                'Cosul meu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.surface,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        isAuth
            ? TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ProfileScreen.routeName);
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.person_outline,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Contul meu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )
            : TextButton(
                onPressed: () {
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
                                              padding:
                                                  EdgeInsets.only(bottom: 8),
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
                                                      child:
                                                          const Text('Submit'),
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
                                                  child: const Text(
                                                      'Inregistrare'),
                                                )
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    if (_isAuthPopup) {
                                                      setState(() {
                                                        _isAuthPopup = false;
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
                                              padding:
                                                  EdgeInsets.only(bottom: 8),
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
                                                              labelText:
                                                                  'Nume'),
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
                                                      child:
                                                          const Text('Submit'),
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
                                                  child: const Text(
                                                      'Inregistrare'),
                                                )
                                              : ElevatedButton(
                                                  onPressed: () {
                                                    if (_isAuthPopup) {
                                                      setState(() {
                                                        _isAuthPopup = false;
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
                },
                child: Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.person_outline,
                      size: 30,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Contul meu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
