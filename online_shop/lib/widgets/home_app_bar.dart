import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';

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
  var _isLoginPopUp = true;

  String _email = "";
  String _password = "";

  Future<void> _submit() async {
    _form.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<User>(context, listen: false).login(_email, _password);
      print("trece pe aici?");
    } catch (error) {
      print("EROARE");
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
        Theme(
          data: Theme.of(context).copyWith(
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: PopupMenuButton(
            tooltip: "",
            onSelected: (selectedValue) {},
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('First Item'),
              ),
              const PopupMenuItem(
                child: Text('Second Item'),
              ),
            ],
            position: PopupMenuPosition.under,
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.shopping_cart_outlined,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 10,
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
                Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (ctx) {
                return _isLoading
                    ? const CircularProgressIndicator()
                    : AlertDialog(
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
                          height: 0.3 * height,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8),
                                child:
                                    Text('Introduceti datele de autentificare'),
                              ),
                              Form(
                                key: _form,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: TextFormField(
                                        decoration: const InputDecoration(
                                            labelText: 'Adresa de email'),
                                        textInputAction: TextInputAction.next,
                                        onSaved: (value) {
                                          _email = value!;
                                        },
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return 'Camp obligatoriu!';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: TextFormField(
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                            labelText: 'Parola'),
                                        textInputAction: TextInputAction.next,
                                        onSaved: (value) {
                                          _password = value!;
                                        },
                                        validator: (value) {
                                          if (value != null && value.isEmpty) {
                                            return 'Camp obligatoriu!';
                                          }
                                          return null;
                                        },
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
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text('Nu'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: TextButton(
                              onPressed: () {
                                if (_form.currentState!.validate()) {
                                  _submit();
                                  Navigator.of(ctx).pop();
                                }
                              },
                              child: const Text('Da'),
                            ),
                          ),
                        ],
                        actionsAlignment: MainAxisAlignment.center,
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
        IconButton(
          // TODO: DE SCOS
          onPressed: () {},
          icon: const Icon(
            Icons.person_outline,
          ),
        ),
      ],
    );
  }
}
