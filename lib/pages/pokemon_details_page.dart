import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:pika_dex/data/type_dynamics.dart';
import 'package:pika_dex/models/moves.dart';
import 'package:pika_dex/models/pokemon.dart';
import 'package:pika_dex/themes/app_themes.dart';
import 'package:pika_dex/utils/dismiss_swipe.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class PokemonDetailsPage extends StatefulWidget {
  const PokemonDetailsPage(
      {super.key,
      required this.imagePath,
      required this.modelisedPokemon,
      required this.formattedPokemonMovesList,
      required this.allMoves});

  final String imagePath;
  final Pokemon modelisedPokemon;
  final List<String> formattedPokemonMovesList;
  final List<Move> allMoves;

  @override
  State<PokemonDetailsPage> createState() => _PokemonDetailsPageState();
}

class _PokemonDetailsPageState extends State<PokemonDetailsPage>
    with SingleTickerProviderStateMixin {
  TextStyle graphStyle = TextStyle(fontSize: 20);
  TextStyle tabStyle = TextStyle(
      fontSize: 18,
      color: AppThemes.darkTheme.primaryColor,
      fontWeight: FontWeight.bold);
  TextStyle statTitleStyle = TextStyle(
    fontSize: 18,
    color: AppThemes.darkTheme.primaryColor,
  );

  late TabController tabController;

  List<String> quadrupleDamage = [];
  List<String> doubleDamage = [];
  List<String> normalDamage = [];
  List<String> halfDamage = [];
  List<String> quarterDamage = [];
  List<String> immune = [];

  List<String> pokemonTypeTexts = [];
  List<int> pokemonTypeIndexes = [];

  late List<Move> modelisedSpecificPokemonMoves;

  bool isNameAscending = true;
  bool isAccuracyAscending = false;
  bool isDamageProfileAscending = false;
  bool isMoveTypeAscending = true;

  void getPokemonTypes() {
    for (int i = 0; i < (widget.modelisedPokemon.type?.length ?? 1); i++) {
      pokemonTypeIndexes.add(
          parsePokemonTypeTextToIndex(widget.modelisedPokemon.type?[i] ?? ''));
      pokemonTypeTexts.add(widget.modelisedPokemon.type?[i] ?? '');
    }
  }

  void populatePokemonDamageLists() {
    for (int i = 0; i < 18; i++) {
      double value = damageMultiplierCalculator(i, pokemonTypeIndexes,
          checkIfPokemonIsLevitating(widget.modelisedPokemon.id ?? 0));

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

  int appropriateColorIndex(double value, int max) {
    if (value / max * 4 < 1) {
      return 0;
    } else if (value / max * 4 > 3) {
      return 4;
    } else {
      return ((value / max) * 4).floor();
    }
  }

  isMoveInJson(int index) => (widget.allMoves.indexWhere((element) =>
          element.ename == widget.formattedPokemonMovesList[index]) !=
      -1);

  sortByName(bool isAscending) {
    int order = isAscending ? 1 : -1;
    modelisedSpecificPokemonMoves
        .sort((a, b) => a.ename!.compareTo(b.ename!) * order);
  }

  // sortByAccuracy(bool isAscending) {
  //   int order = isAscending ? 1 : -1;
  //   modelisedSpecificPokemonMoves
  //       .sort((a, b) => a.accuracy!.compareTo(b.accuracy!) * order);
  // }

  // sortByDamageProfile(bool isAscending) {
  //   int order = isAscending ? 1 : -1;
  //   modelisedSpecificPokemonMoves
  //       .sort((a, b) => a.ename!.compareTo(b.ename!) * order);
  // }

  sortByType(bool isAscending) {
    int order = isAscending ? 1 : -1;
    modelisedSpecificPokemonMoves
        .sort((a, b) => a.type!.compareTo(b.type!) * order);
  }

  @override
  void initState() {
    super.initState();
    getPokemonTypes();
    populatePokemonDamageLists();
    tabController = TabController(length: 3, vsync: this);
    modelisedSpecificPokemonMoves = [];

    for (int i = 0; i < widget.formattedPokemonMovesList.length; i++) {
      if (isMoveInJson(i)) {
        modelisedSpecificPokemonMoves.add(widget.allMoves[widget.allMoves
            .indexWhere((element) =>
                element.ename == widget.formattedPokemonMovesList[i])]);
      } else {
        modelisedSpecificPokemonMoves.add(Move(
          accuracy: -1,
          category: 'Unknown',
          cname: 'Unknown',
          ename: widget.formattedPokemonMovesList[i],
          id: -1,
          jname: 'Unknown',
          power: -1,
          pp: -1,
          type: 'zUnknown',
        ));
      }
    }
    sortByType(true);
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
                      child: Padding(
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
                      style: TextStyle(
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
              TabBar(
                  indicatorColor: AppThemes.darkTheme.primaryColor,
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.white,
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: Text(
                        'Damage Taken',
                        textAlign: TextAlign.center,
                        style: tabStyle,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Base Stats',
                        textAlign: TextAlign.center,
                        style: tabStyle,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Moves',
                        textAlign: TextAlign.center,
                        style: tabStyle,
                      ),
                    )
                  ]),
              SizedBox(
                height: 3,
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          greyAreaTypesPlacement('x4', scalableColorPalet[4],
                              quadrupleDamage, context),
                          greyAreaTypesPlacement('x2', scalableColorPalet[3],
                              doubleDamage, context),
                          greyAreaTypesPlacement('x1', scalableColorPalet[2],
                              normalDamage, context),
                          greyAreaTypesPlacement('x0.5', scalableColorPalet[1],
                              halfDamage, context),
                          greyAreaTypesPlacement('x0.25', scalableColorPalet[0],
                              quarterDamage, context),
                          greyAreaTypesPlacement(
                              'x0', Colors.grey.shade600, immune, context),
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          pokemonStatRow(
                              context,
                              'HP',
                              (widget.modelisedPokemon.base?.hP ?? 0.0)
                                  .toDouble(),
                              maxValuesPerStatistic[0]),
                          pokemonStatRow(
                              context,
                              'Attack',
                              (widget.modelisedPokemon.base?.attack ?? 0.0)
                                  .toDouble(),
                              maxValuesPerStatistic[1]),
                          pokemonStatRow(
                              context,
                              'Defense',
                              (widget.modelisedPokemon.base?.defense ?? 0.0)
                                  .toDouble(),
                              maxValuesPerStatistic[2]),
                          pokemonStatRow(
                              context,
                              'Sp. Attack',
                              (widget.modelisedPokemon.base?.spAttack ?? 0.0)
                                  .toDouble(),
                              maxValuesPerStatistic[3]),
                          pokemonStatRow(
                              context,
                              'Sp. Defense',
                              (widget.modelisedPokemon.base?.spDefense ?? 0.0)
                                  .toDouble(),
                              maxValuesPerStatistic[4]),
                          pokemonStatRow(
                              context,
                              'Speed',
                              (widget.modelisedPokemon.base?.speed ?? 0.0)
                                  .toDouble(),
                              maxValuesPerStatistic[5]),
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    isNameAscending = !isNameAscending;
                                    sortByName(isNameAscending);
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text('Move Name'),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // isAccuracyAscending = !isAccuracyAscending;
                                    // sortByAccuracy(isAccuracyAscending);
                                    // setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text('Accuracy %'),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    // isDamageProfileAscending =
                                    //     !isDamageProfileAscending;
                                    // sortByDamageProfile(
                                    //     isDamageProfileAscending);
                                    // setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text('Type | Dmg'),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    isMoveTypeAscending = !isMoveTypeAscending;
                                    sortByType(isMoveTypeAscending);
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Text('Move Type'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: modelisedSpecificPokemonMoves.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 80,
                                          child: Text(
                                            modelisedSpecificPokemonMoves[index]
                                                    .ename ??
                                                'Unknown',
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text(
                                          '${modelisedSpecificPokemonMoves[index].accuracy ?? ' - '}',
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          '${modelisedSpecificPokemonMoves[index].category!.substring(0, 3).toUpperCase()} | ${modelisedSpecificPokemonMoves[index].power}',
                                          textAlign: TextAlign.center,
                                        ),
                                        (modelisedSpecificPokemonMoves[index]
                                                    .type ==
                                                'zUnknown')
                                            ? Text('Unknown')
                                            : Image.asset(
                                                'assets/type_badges/${modelisedSpecificPokemonMoves[index].type}.png',
                                                width: 70,
                                                height: 20,
                                              )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
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

  Widget pokemonStatRow(
      BuildContext context, String text, double value, int max) {
    return Flexible(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Container(
                child: Text(
                  text,
                  style: statTitleStyle,
                ),
                width: 120,
              ),
            ),
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width - 152,
                  child: FAProgressBar(
                    animatedDuration: Duration(milliseconds: 700),
                    currentValue: value,
                    maxValue: max.toDouble(),
                    // displayText: '',
                    displayTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),

                    progressColor:
                        scalableColorPalet[appropriateColorIndex(value, max)],
                    backgroundColor: Colors.white,
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${value.toInt()} / $max',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
