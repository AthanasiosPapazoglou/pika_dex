import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pika_dex/data/type_dynamics.dart';
import 'package:pika_dex/models/pokemon.dart';
import 'package:pika_dex/themes/app_colors.dart';
import 'package:pika_dex/themes/app_themes.dart';
import 'package:pika_dex/utils/dismiss_swipe.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage(
      {super.key,
      required this.imagePath,
      required this.modelisedPokemon});

  final String imagePath;
  final Pokemon modelisedPokemon;

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

  List<String> pokemonTypeTexts = [];
  List<int> pokemonTypeIndexes = [];

  void getPokemonTypes() {
    for (int i = 0; i < (widget.modelisedPokemon.type?.length ?? 1); i++) {
      pokemonTypeIndexes
          .add(parsePokemonTypeTextToIndex(widget.modelisedPokemon.type?[i] ?? ''));
      pokemonTypeTexts.add(widget.modelisedPokemon.type?[i] ?? '');
    }
  }

  void populatePokemonDamageLists() {
    for (int i = 0; i < 18; i++) {
      double value = damageMultiplierCalculator(
          i, pokemonTypeIndexes, checkIfPokemonIsLevitating(widget.modelisedPokemon.id ?? 0));

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
    getPokemonTypes();
    populatePokemonDamageLists();
  }

  @override
  Widget build(BuildContext context) {
    return DismissingWrapper(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.maxFinite,
                height: 64,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child:  Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 35,
                          color: AppThemes.darkTheme.primaryColor,
                        ),
                      ),
                    ),
                    Text(
                      widget.modelisedPokemon.name?.english ?? '',
                      style:  TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppThemes.darkTheme.primaryColor,
                      ),
                    ),
                    const SizedBox(
                      width: 48,
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: pokemonTypeColors[parsePokemonTypeTextToIndex(
                        widget.modelisedPokemon.type?[0] ?? '')]),
                child: Hero(
                  tag: widget.modelisedPokemon.id ?? 0,
                  child: Image.asset(
                    widget.imagePath,
                    height: 250,
                    width: 250,
                  ),
                ),
              ),
              pokemonTypeBadgetsRow(context),
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text(
                        'Damage Taken:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppThemes.darkTheme.primaryColor,
                        ),
                      ),
                      greyAreaTypesPlacement(
                          'x4', Colors.blue, quadrupleDamage, context),
                      greyAreaTypesPlacement(
                          'x2', Colors.green, doubleDamage, context),
                      greyAreaTypesPlacement(
                          'x1', Colors.yellow, normalDamage, context),
                      greyAreaTypesPlacement(
                          'x0.5', Colors.orange, halfDamage, context),
                      greyAreaTypesPlacement(
                          'x0.25', Colors.red, quarterDamage, context),
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
                  style: TextStyle(
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
                      height: (badgeTitlesRow.length > 15) ? 72 : 54,
                      width: MediaQuery.of(context).size.width - 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppThemes.darkTheme.hintColor,
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
                            scale: 2.2,
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

  Widget pokemonTypeBadgetsRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 64,
      child: Center(
        child: Column(
          children: [
             Text(
              'Types:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppThemes.darkTheme.primaryColor,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  pokemonTypeTexts.length,
                  (index) => Image.asset(
                      'assets/type_badges/${pokemonTypeTexts[index]}.png')),
            ),
          ],
        ),
      ),
    );
  }
}
