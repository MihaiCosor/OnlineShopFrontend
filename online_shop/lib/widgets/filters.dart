import 'package:flutter/material.dart';

import 'sub_filter.dart';

enum FilterType {
  price,
  rating,
  numberOfReviews,
}

const prices = [
  "Sub 50",
  "51 - 100",
  "101 - 200",
  "Peste 200",
];

const ratings = [
  "Sub 2.5",
  "2.5 - 3.5",
  "3.6 - 4.5",
  "Peste 4.5",
];

const numberOfReviews = [
  "Sub 10",
  "11 - 100",
  "101 - 500",
  "501 - 1000",
  "Peste 1000",
];

class Filters extends StatefulWidget {
  final Function(Map<String, List<String>>) applyFilters;

  const Filters({super.key, required this.applyFilters});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  final Map<String, List<String>> _filters = {
    'price': [],
    'rating': [],
    'numberOfReviews': [],
  };

  updateFilters(FilterType type, String description) {
    setState(() {
      switch (type) {
        case FilterType.price:
          if (_filters['price']!.contains(description)) {
            _filters['price']!.remove(description);
          } else {
            _filters['price']!.add(description);
          }
          break;
        case FilterType.rating:
          if (_filters['rating']!.contains(description)) {
            _filters['rating']!.remove(description);
          } else {
            _filters['rating']!.add(description);
          }
          break;
        case FilterType.numberOfReviews:
          if (_filters['numberOfReviews']!.contains(description)) {
            _filters['numberOfReviews']!.remove(description);
          } else {
            _filters['numberOfReviews']!.add(description);
          }
          break;
        default:
          break;
      }
    });

    widget.applyFilters(_filters);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: 0.15 * width,
      color: Theme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('Pret'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...prices.map((price) {
                    return SubFilter(
                        filterType: FilterType.price,
                        updateFilters: updateFilters,
                        description: price,
                        isChecked:
                            _filters['price']!.contains(price) ? true : false);
                  }).toList(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('Rating'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...ratings.map((rating) {
                    return SubFilter(
                        filterType: FilterType.rating,
                        updateFilters: updateFilters,
                        description: rating,
                        isChecked: _filters['rating']!.contains(rating)
                            ? true
                            : false);
                  }).toList(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              right: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('Numar de recenzii'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ...numberOfReviews.map((rating) {
                    return SubFilter(
                        filterType: FilterType.numberOfReviews,
                        updateFilters: updateFilters,
                        description: rating,
                        isChecked: _filters['numberOfReviews']!.contains(rating)
                            ? true
                            : false);
                  }).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
