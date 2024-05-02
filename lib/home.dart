import 'package:flutter/material.dart';
import 'package:pokemon/pokelist.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Pokelist(),
      title: 'Pokedex',
    );
    // return const Scaffold(
    //   body: Pokelist()
    //   );
  }
} 