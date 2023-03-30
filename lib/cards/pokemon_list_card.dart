// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class PokemonListCard extends StatelessWidget {
  const PokemonListCard({super.key, required this.parentalBuilderIndex});

  final int parentalBuilderIndex;

  @override
  Widget build(BuildContext context) {
    int pokemonId = parentalBuilderIndex + 1;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 12.0,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        width: double.maxFinite,
        height: 82,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/${imageNumberCorrector(pokemonId)}$pokemonId.png',
              height: 64,
              width: 64,
            ),
            Text('$pokemonId')
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.yellow,
        ),
      ),
    );
  }

  imageNumberCorrector(int pokemonId) {
    if (pokemonId < 10) {
      return '00';
    } else if (pokemonId < 100) {
      return '0';
    } else {
      return '';
    }
  }
}
