import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);

  @override
  Widget build(BuildContext context) {
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
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.person_outline,
          ),
        ),
      ],
    );
  }
}
