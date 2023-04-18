// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pika_dex/cards/pokemon_list_card.dart';
import 'package:pika_dex/components/common.dart';
import 'package:pika_dex/data/type_dynamics.dart';
import 'package:pika_dex/modals/type_filtering.dart';
import 'package:pika_dex/models/pokemon.dart';
import 'package:pika_dex/themes/app_themes.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MainPokemonList extends StatefulWidget {
  const MainPokemonList({
    super.key,
  });

  @override
  State<MainPokemonList> createState() => _MainPokemonListState();
}

class _MainPokemonListState extends State<MainPokemonList>
    with TickerProviderStateMixin {
  //! Flags
  bool isFirstBuild = true;
  int textFieldInputLength = 0;

  //! Json Data
  late var decodedPokemonList;

  //! Modelised Lists
  List<Pokemon> modelisedPokemonList = [];
  List<Pokemon> filteredPokemonList = [];

  //! Flag List
  List<bool> activeTypeFilters = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
  ];

  //! Controllers
  late ScrollController _scrollbarController;
  late TextEditingController _textfieldController;
  late Animation<double> _animation;
  late AnimationController _animationController;

  //! Callbacks
  void changeFilterListCallback(int indexNum) {
    setState(() {
      activeTypeFilters[indexNum] = !activeTypeFilters[indexNum];
    });
  }

  void filterModalSheetLogicCoordinator() {
    setState(() {
      resetFilteredList();
      for (int i = 0; i < 18; i++) {
        if (!activeTypeFilters[i]) {
          filteredPokemonList.removeWhere(
              (element) => (element.type ?? []).contains(pokemonTypes[i]));
        }
      }
    });
  }

  //! Functions
  Future<String> getJsonFromFile() async {
    final String response = await rootBundle.loadString('assets/pokedex.json');
    final items = jsonDecode(response);
    setState(() {
      decodedPokemonList = items;
    });
    return response;
  }

  void populateModelisedList() {
    for (int i = 0; i < 809; i++) {
      modelisedPokemonList.add(Pokemon.fromJson(decodedPokemonList[i]));
    }
  }

  void processFilteredList() {
    isNumeric(_textfieldController.text)
        ? filteredPokemonList.removeWhere((element) =>
            !(element.id ?? '').toString().contains(_textfieldController.text))
        : filteredPokemonList.removeWhere((element) =>
            !(element.name!.english ?? '')
                .toLowerCase()
                .contains((_textfieldController.text).toLowerCase()));
  }

  void resetFilteredList() {
    filteredPokemonList.clear();
    filteredPokemonList = List.from(modelisedPokemonList);
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }

  void firstBuildDataInitilizer() {
    if (isFirstBuild) {
      setState(() {
        populateModelisedList();
        resetFilteredList();
        isFirstBuild = false;
      });
    } else {
      return;
    }
  }

  void textFieldInputLogicCoordinator() {
    setState(() {
      if (_textfieldController.text.length < textFieldInputLength) {
        resetFilteredList();
        textFieldInputLength--;
      } else {
        textFieldInputLength++;
      }
      processFilteredList();
    });
  }

  //! Init/Dispose
  @override
  void initState() {
    super.initState();
    getJsonFromFile();
    _scrollbarController = ScrollController();
    _textfieldController = TextEditingController();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollbarController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    firstBuildDataInitilizer();
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                    controller: _textfieldController,
                    onChanged: (value) => textFieldInputLogicCoordinator(),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Pokemon Name or Id',
                      hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: setThemePrimary(),
                            context: context,
                            builder: (BuildContext context) {
                              return TypeFilteringModal(
                                filterListCallback: changeFilterListCallback,
                                modalSheetLogicCoordinator:
                                    filterModalSheetLogicCoordinator,
                                copyOfFilterList: List.from(activeTypeFilters),
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.edit_note_rounded,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 30,
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
                alwaysVisibleScrollThumb: true,
                labelTextBuilder: (double offset) => Text("${offset ~/ 100}"),
                controller: _scrollbarController,
                backgroundColor: AppThemes.darkTheme.primaryColor,
                child: ListView.builder(
                  controller: _scrollbarController,
                  itemCount: filteredPokemonList.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) {},
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: Icons.favorite_rounded,
                            borderRadius: BorderRadius.circular(10),
                            label: 'Set As Favorite',
                          ),
                        ],
                      ),
                      child: PokemonListCard(
                        modelisedPokemon: filteredPokemonList[index],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionBubble(
        items: <Bubble>[
          Bubble(
            title: "Pokemons",
            iconColor: setThemePrimary(),
            bubbleColor: setThemeBackground(),
            icon: Icons.pets_rounded,
            titleStyle: TextStyle(fontSize: 16, color: setThemePrimary()),
            onPress: () {
              _animationController.reverse();
            },
          ),
          Bubble(
            title: "Favorites",
            iconColor: setThemePrimary(),
            bubbleColor: setThemeBackground(),
            icon: Icons.favorite_rounded,
            titleStyle: TextStyle(fontSize: 16, color: setThemePrimary()),
            onPress: () {
              _animationController.reverse();
            },
          ),
          Bubble(
            title: "Trainers",
            iconColor: setThemePrimary(),
            bubbleColor: setThemeBackground(),
            icon: Icons.people,
            titleStyle: TextStyle(fontSize: 16, color: setThemePrimary()),
            onPress: () {
              _animationController.reverse();
            },
          ),
        ],
        animation: _animation,
        onPress: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),
        iconColor: setThemePrimary(),
        iconData: Icons.sort_rounded,
        backGroundColor: setThemeBackground(),
      ),
    );
  }
}
