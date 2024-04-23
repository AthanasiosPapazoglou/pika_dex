// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:pika_dex/data/type_dynamics.dart';
import 'package:pika_dex/models/moves.dart';
import 'package:pika_dex/models/pokemon.dart';
import 'package:pika_dex/pages/pokemon_details_page.dart';
import 'package:pika_dex/services.dart';

String formatMoveString(String input) {
  // Split the input string by '-' and capitalize each word
  List<String> words = input.split('-').map((word) {
    return word.substring(0, 1).toUpperCase() + word.substring(1);
  }).toList();

  // Join the words with spaces
  String pascalString = words.join(' ');

  // Capitalize the first letter of the string
  pascalString =
      pascalString.substring(0, 1).toUpperCase() + pascalString.substring(1);

  return pascalString;
}

class PokemonListCard extends StatelessWidget {
  PokemonListCard(
      {super.key,
      required this.modelisedPokemon,
      required this.viewType,
      required this.allMoves});

  final Pokemon modelisedPokemon;
  final PokemonListViewType viewType;
  final List<Move> allMoves;

  List<String> formattedPokemonMovesList = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: InkWell(
        onTap: () async {
          Map<String, dynamic> pokemonReturnObject = await fetchPokemon(
              modelisedPokemon.name?.english?.toLowerCase() ?? '');
          for (int i = 0; i < pokemonReturnObject['moves'].length; i++) {
            formattedPokemonMovesList.add(formatMoveString(
                pokemonReturnObject['moves'][i]['move']['name']));
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PokemonDetailsPage(
                  imagePath: ((modelisedPokemon.id ?? 0) < 810)
                      ? 'assets/images/${imageNumberCorrector(modelisedPokemon.id ?? 0)}${(modelisedPokemon.id ?? 0)}.png'
                      : 'assets/app_icon.jpeg',
                  modelisedPokemon: modelisedPokemon,
                  formattedPokemonMovesList: formattedPokemonMovesList,
                  allMoves: allMoves),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          width: double.maxFinite,
          height: isMultiplePokemonViewType() ? double.maxFinite : 82,
          child: isMultiplePokemonViewType()
              ? multiplePokemonViewCard()
              : singlePokemonViewCard(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: pokemonTypeColors[
                parsePokemonTypeTextToIndex(modelisedPokemon.type?[0] ?? '')],
          ),
        ),
      ),
    );
  }

  //! Methods

  imageNumberCorrector(int pokemonId) {
    if (pokemonId < 10) {
      return '00';
    } else if (pokemonId < 100) {
      return '0';
    } else {
      return '';
    }
  }

  bool isMultiplePokemonViewType() => (viewType == PokemonListViewType.double ||
      viewType == PokemonListViewType.triple);

  multiplePokemonViewCard() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hero(
          tag: modelisedPokemon.id ?? 0,
          child: Image.asset(
            'assets/images/${imageNumberCorrector(modelisedPokemon.id ?? 0)}${(modelisedPokemon.id ?? 0)}.png',
            height: viewType == PokemonListViewType.double ? 125 : 60,
            width: viewType == PokemonListViewType.double ? 125 : 60,
          ),
        ),
        Column(
          children: [
            FittedBox(
              child: Text(
                modelisedPokemon.name?.english ?? '',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '${(modelisedPokemon.id ?? 0)}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        )
      ],
    );
  }

  singlePokemonViewCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Hero(
          tag: modelisedPokemon.id ?? 0,
          child: Image.asset(
            ((modelisedPokemon.id ?? 0) < 810)
                ? 'assets/images/${imageNumberCorrector(modelisedPokemon.id ?? 0)}${(modelisedPokemon.id ?? 0)}.png'
                : 'assets/app_icon.jpeg',
            height: 64,
            width: 64,
          ),
        ),
        Text(
          modelisedPokemon.name?.english ?? '',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${(modelisedPokemon.id ?? 0)}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}
