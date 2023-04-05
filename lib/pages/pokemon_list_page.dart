import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pika_dex/cards/pokemon_list_card.dart';
import 'package:pika_dex/models/pokemon.dart';
import 'package:pika_dex/themes/app_colors.dart';
import 'package:pika_dex/themes/app_themes.dart';

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
            Padding(
              padding: EdgeInsets.only(top: 6),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                width: MediaQuery.of(context).size.width - 32,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppThemes.darkTheme.hintColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.search_rounded, size: 28, color: Colors.white,),
                    Icon(Icons.settings_rounded, size: 28, color: Colors.white,)
                  ],
                ),
              ),
            ),
            Expanded(
              child: Scrollbar(
                thickness: 26.0,
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
