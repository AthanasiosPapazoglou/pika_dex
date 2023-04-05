import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pika_dex/data/type_dynamics.dart';
import 'package:pika_dex/utils/dismiss_swipe.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage(
      {super.key,
      required this.imagePath,
      required this.pokemonId,
      required this.pokemonJsonData});

  final String imagePath;
  final int pokemonId;
  final dynamic pokemonJsonData;

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage> {
  TextStyle graphStyle = TextStyle(fontSize: 20);

  List<String> quadrupleDamage = [];
  List<String> doubleDamage = [];
  List<String> normalDamage = [];
  List<String> halfDamage = [];
  List<String> quarterDamage = [];
  List<String> immune = [];

  List<int> pokemonTypesIndexes = [];

  void getPokemonTypeIndexes() {
    for (int i = 0; i < widget.pokemonJsonData['type'].length; i++) {
      pokemonTypesIndexes
          .add(parsePokemonTypeTextToIndex(widget.pokemonJsonData['type'][i]));
    }
  }

  void populatePokemonDamageLists() {
    for (int i = 0; i < 18; i++) {
      double value = damageMultiplierCalculator(i, pokemonTypesIndexes, checkIfPokemonIsLevitating(widget.pokemonId));

      if (value == 4.0) {
        quadrupleDamage.add(pokemonTypes[i]);
      } else if (value == 2.0) {
        doubleDamage.add(pokemonTypes[i]);
      } else if (value == 1.0) {
        normalDamage.add(pokemonTypes[i]);
      } else if (value == (1 / 2)) {
        halfDamage.add(pokemonTypes[i]);
      } else if (value == (1 / 4)) {
        quarterDamage.add(pokemonTypes[i]);
      } else {
        immune.add(pokemonTypes[i]);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getPokemonTypeIndexes();
    populatePokemonDamageLists();
  }

  @override
  Widget build(BuildContext context) {
    return DismissingWrapper(
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 64,
                color: Colors.green,
              ),
              Container(
                color: Colors.green,
                child: Hero(
                  tag: widget.pokemonId,
                  child: Image.asset(
                    widget.imagePath,
                    height: 250,
                    width: 250,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  color: Colors.blueGrey.shade200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      greyAreaTypesPlacement(
                          'x4', Colors.blue, quadrupleDamage, context),
                      greyAreaTypesPlacement(
                          'x2', Colors.green, doubleDamage, context),
                      greyAreaTypesPlacement(
                          'x1', Colors.yellow, normalDamage, context),
                      greyAreaTypesPlacement(
                          'x1/2', Colors.orange, halfDamage, context),
                      greyAreaTypesPlacement(
                          'x1/4', Colors.red, quarterDamage, context),
                      greyAreaTypesPlacement(
                          'x0', Colors.grey.shade600, immune, context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget greyAreaTypesPlacement(String multiplier, Color colorData,
      List<String> badgeTitlesRow, BuildContext context) {
    // return Flexible(
    //   child: Container(
    //     height: double.maxFinite,
    //     width: double.maxFinite,
    //     color: colorData,
    //     child: Row(
    //       children: [
    //         Container(
    //           width: 64,
    //           child: Center(
    //             child: Text(
    //               multiplier,
    //               style: TextStyle(color: Colors.black),
    //             ),
    //           ),
    //         ),
    //         Flexible(
    //           child: Stack(
    //             children: [
    //               Container(
    //                 height: 64,
    //                 width: MediaQuery.of(context).size.width - 80,
    //                 decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(6),
    //                   color: Colors.grey.shade400,
    //                 ),
    //               ),
    //               Wrap(
    //                 children: List.generate(
    //                   badgeTitlesRow.length,
    //                   (index) => Padding(
    //                     padding:
    //                         EdgeInsets.symmetric(vertical: 2, horizontal: 4),
    //                     child: Image.asset(
    //                       'assets/type_badges/${badgeTitlesRow[index]}.png',
    //                       scale: 1.7,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return Flexible(
      child: Container(
        width: double.maxFinite,
        color: colorData,
        child: Row(
          children: [
            Container(
              width: 64,
              child: Center(
                child: Text(
                  multiplier,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Stack(
                  children: [
                    Container(
                      height: 64,
                      width: MediaQuery.of(context).size.width - 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Wrap(
                      children: List.generate(
                        badgeTitlesRow.length,
                        (index) => Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                          child: Image.asset(
                            'assets/type_badges/${badgeTitlesRow[index]}.png',
                            scale: 1.7,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
