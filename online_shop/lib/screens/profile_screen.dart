import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilul meu'),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const CircleAvatar(
            radius: 100,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 145,
              backgroundImage: NetworkImage(
                'https://www.citypng.com/public/uploads/preview/black-user-member-guest-icon-31634946589seopngzc1t.png',
              ),
            ),
          ),
          Column(
            children: const [
              Text(
                'Nume',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                'Telefon',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
