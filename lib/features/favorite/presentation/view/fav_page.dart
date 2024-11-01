import 'package:flutter/material.dart';

class FavPage extends StatelessWidget {
  const FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
       mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Center(child: Icon(Icons.heart_broken,size: 40,))

      ],
    );
  }
}
