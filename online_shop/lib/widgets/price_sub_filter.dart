import 'package:flutter/material.dart';

class PriceSubFilter extends StatefulWidget {
  final String description;

  const PriceSubFilter({super.key, required this.description});

  @override
  State<PriceSubFilter> createState() => _PriceSubFilterState();
}

class _PriceSubFilterState extends State<PriceSubFilter> {
  var _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 50,
        ),
        IconButton(
          iconSize: 20,
          icon: Icon(
            _isChecked
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            setState(() {
              _isChecked = !_isChecked;
            });
          },
        ),
        Text(widget.description),
      ],
    );
  }
}
