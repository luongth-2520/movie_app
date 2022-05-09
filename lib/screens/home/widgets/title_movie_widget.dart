import 'package:flutter/material.dart';

import '../../../constants/constanst.dart';

class TitleMovie extends StatelessWidget {
  const TitleMovie({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: AppSize.size_25),
        ),
        const Text(
          'See all',
          style: TextStyle(
            fontSize: AppSize.size_15,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
