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

  List<int> quadrupleDamage = [];
  List<int> doubleDamage = [];
  List<int> normalDamage = [];
  List<int> halfDamage = [];
  List<int> quarterDamage = [];

  List<int> pokemonTypesIndexes = [];

  void getPokemonTypeIndexes (){
    for (int i =0; i < widget.pokemonJsonData['type'].length; i++){
      pokemonTypesIndexes.add(parsePokemonTypeTextToIndex(widget.pokemonJsonData['type'][i])); 
    }
  }

  void populatePokemonDamageLists() {
    for (int i = 0; i < 18; i++) {
      double value = damageMultiplierCalculator(i, pokemonTypesIndexes);

      if(value == 4.0){
        quadrupleDamage.add(i);
      } else if (value == 2.0){
        doubleDamage.add(i);
      } else if (value == 1.0){
        normalDamage.add(i);
      } else if (value == (1/2)){
        halfDamage.add(i);
      } else {
        quarterDamage.add(i);
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
                      Text(
                        'x4 $quadrupleDamage',
                        style: TextStyle(color: Colors.blue),
                      ),
                      Text(
                        'x2 $doubleDamage',
                        style: TextStyle(color: Colors.green),
                      ),
                      Text(
                        'x1 $normalDamage',
                        style: TextStyle(color: Colors.yellow),
                      ),
                      Text(
                        'x1/2 $halfDamage',
                        style: TextStyle(color: Colors.orange),
                      ),
                      Text(
                        'x1/4 $quarterDamage',
                        style: TextStyle(color: Colors.red),
                      ),
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
}
