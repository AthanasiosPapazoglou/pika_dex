import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pika_dex/cards/pokemon_list_card.dart';
import 'package:pika_dex/models/pokemon.dart';

class MainPokemonList extends StatefulWidget {
  const MainPokemonList({super.key});

  @override
  State<MainPokemonList> createState() => _MainPokemonListState();
}

class _MainPokemonListState extends State<MainPokemonList> {

   late var stringifiedJsonData;

  Future<String> getJsonFromFile() async {
    final String response =
        await rootBundle.loadString('assets/json_files/pokedex.json');
    return response;
  }

  @override
  void initState() {
    super.initState();
    getJsonFromFile().then((value) {
      setState(() {
        stringifiedJsonData = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    print(stringifiedJsonData);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 82,
              color: Colors.green,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 809,
                itemBuilder: (context, index) {
                  return PokemonListCard(parentalBuilderIndex: index);
                },
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 48,
              color: Colors.orange,
            )
          ],
        ),
      ),
    );
  }
}
