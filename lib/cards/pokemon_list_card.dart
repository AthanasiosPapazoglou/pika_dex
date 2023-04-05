// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:pika_dex/data/type_dynamics.dart';
import 'package:pika_dex/pages/pokemon_details_page.dart';

class PokemonListCard extends StatelessWidget {
  const PokemonListCard(
      {super.key,
      required this.parentalBuilderIndex,
      required this.pokemonJsonData});

  final int parentalBuilderIndex;
  final dynamic pokemonJsonData;

  @override
  Widget build(BuildContext context) {
    int pokemonId = parentalBuilderIndex + 1;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 32, 8),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokemonDetailsPage(
                  imagePath:
                      'assets/images/${imageNumberCorrector(pokemonId)}$pokemonId.png',
                  pokemonId: pokemonId,
                  pokemonJsonData: pokemonJsonData),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          width: double.maxFinite,
          height: 82,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: pokemonId,
                child: Image.asset(
                  'assets/images/${imageNumberCorrector(pokemonId)}$pokemonId.png',
                  height: 64,
                  width: 64,
                ),
              ),
              Text(
                pokemonJsonData['name']['english'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$pokemonId',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: pokemonTypeColors[
                parsePokemonTypeTextToIndex(pokemonJsonData['type'][0])],
          ),
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
