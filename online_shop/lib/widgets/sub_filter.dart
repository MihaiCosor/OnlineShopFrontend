import 'package:flutter/material.dart';

import './filters.dart';

class SubFilter extends StatelessWidget {
  final Function(FilterType, String) updateFilters;
  final FilterType _filterType;
  final String _description;
  final bool _isChecked;

  const SubFilter(
      {super.key,
      required this.updateFilters,
      required FilterType filterType,
      required String description,
      required bool isChecked})
      : _filterType = filterType,
        _description = description,
        _isChecked = isChecked;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 0.0325 * width,
        ),
        IconButton(
          iconSize: 0.026 * height,
          icon: Icon(
            _isChecked
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            updateFilters(_filterType, _description);
          },
        ),
        Text(_description),
      ],
    );
  }
}
