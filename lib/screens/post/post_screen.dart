import 'package:flutter/material.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key, required this.number}) : super(key: key);

  final String number;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        number,
        style: const TextStyle(fontSize: 38),
      ),
    );
  }
}
