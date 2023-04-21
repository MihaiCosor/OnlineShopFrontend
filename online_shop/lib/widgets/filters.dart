import 'package:flutter/material.dart';

import './price_sub_filter.dart';

class Filters extends StatelessWidget {
  const Filters({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      width: 0.15 * width,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('Pret'),
              SizedBox(
                height: 10,
              ),
              PriceSubFilter(description: "Sub 1000"),
              PriceSubFilter(description: "1000 - 2000"),
              PriceSubFilter(description: "2000 - 3000"),
              PriceSubFilter(description: "Peste 3000"),
            ],
          ),
        ],
      ),
    );
  }
}
