import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pika_dex/cards/pokemon_list_card.dart';
import 'package:pika_dex/models/pokemon.dart';
import 'package:pika_dex/themes/app_colors.dart';

class MainPokemonList extends StatefulWidget {
  const MainPokemonList({super.key});

  @override
  State<MainPokemonList> createState() => _MainPokemonListState();
}

populateModelisedList(dynamic jsonList, List<Pokemon> modelisedList) {
  for (int i = 0; i < 809; i++) {
    modelisedList.add(Pokemon.fromJson(jsonList[i]));
  }
}

class _MainPokemonListState extends State<MainPokemonList> {
  late var decodedPokemonList;
  late List<Pokemon> modelisedPokemonList;

  Future<String> getJsonFromFile() async {
    final String response = await rootBundle.loadString('assets/pokedex.json');
    final items = jsonDecode(response);
    setState(() {
      decodedPokemonList = items;
    });
    return response;
  }

  @override
  void initState() {
    super.initState();
    getJsonFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 64,
              color: Colors.green,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 808,
                itemBuilder: (context, index) {
                  return PokemonListCard(
                    parentalBuilderIndex: index,
                    pokemonJsonData: decodedPokemonList[index],
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
            size: 45,
          ),
        ),
      ),
    );
  }
}
