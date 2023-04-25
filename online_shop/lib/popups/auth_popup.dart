import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user.dart';
import '../providers/auth_register_popup_.dart';

class AuthPopup extends StatefulWidget {
  const AuthPopup({super.key});

  @override
  State<AuthPopup> createState() => _AuthPopupState();
}

class _AuthPopupState extends State<AuthPopup> {
  final _form = GlobalKey<FormState>();

  var _isLoading = false;

  String _email = "";
  String _password = "";

  Future<void> _submit() async {
    _form.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<User>(context, listen: false).login(_email, _password);
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
              height: 0.5 * height,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Text('Introduceti datele de autentificare'),
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
                            decoration:
                                const InputDecoration(labelText: 'Parola'),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_form.currentState!.validate()) {
                                _submit();
                                Navigator.of(context).pop();
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
                padding: const EdgeInsets.only(bottom: 8),
                child: ElevatedButton(
                  onPressed: () {
                    if (!Provider.of<AuthRegister>(context, listen: false)
                        .isLoginPopUp) {
                      Provider.of<AuthRegister>(context, listen: false)
                          .setIsLoginPopUp(true);
                    }
                  },
                  child: const Text('Autentificare'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: OutlinedButton(
                  onPressed: () {
                    if (Provider.of<AuthRegister>(context, listen: false)
                        .isLoginPopUp) {
                      Provider.of<AuthRegister>(context, listen: false)
                          .setIsLoginPopUp(false);
                    }
                  },
                  child: const Text('Inregistrare'),
                ),
              ),
            ],
            actionsAlignment: MainAxisAlignment.spaceAround,
          );
  }
}
