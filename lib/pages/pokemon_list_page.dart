// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pika_dex/cards/pokemon_list_card.dart';
import 'package:pika_dex/models/pokemon.dart';
import 'package:pika_dex/themes/app_colors.dart';
import 'package:pika_dex/themes/app_themes.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';

class MainPokemonList extends StatefulWidget {
  const MainPokemonList({
    super.key,
  });


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
  late var filteredPokemonList;

  List<Pokemon> modelisedPokemonList = [];
  late ScrollController _scrollbarController;
  late TextEditingController _textfieldController;

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
    _scrollbarController = ScrollController();
    _textfieldController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollbarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    populateModelisedList(decodedPokemonList, modelisedPokemonList);
    print(modelisedPokemonList[24].name!.english);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                width: MediaQuery.of(context).size.width - 32,
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppThemes.darkTheme.hintColor,
                ),
                child: Center(
                  child: TextField(
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Pokemon Name or Id',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.settings_rounded,
                          color: Colors.black,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                      ),
                      contentPadding:
                          EdgeInsetsDirectional.fromSTEB(0, 10, 0, 8),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: DraggableScrollbar.arrows(
                labelTextBuilder: (double offset) => Text("${offset ~/ 100}"),
                controller: _scrollbarController,
                backgroundColor: AppThemes.darkTheme.primaryColor,
                child: ListView.builder(
                  controller: _scrollbarController,
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
