
import 'package:flutter/material.dart';

/// Offense Board Map
Map<String, List<double>> offenseBoard = {"": []};


/// Defence Board Map
Map<String, List<double>> defenseBoard = {"": []};

/// Max value per statistic 
List<int> maxValuesPerStatistic = [
  255, //HP
  181, //ATTACK
  230, //DEF
  180, //SP ATT
  230, //SP.DEF
  200, //SPEED
];

/// Statistic colors 
List<MaterialColor> scalableColorPalet = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.green,
  Colors.blue

];

/// Pokemon Type Colors for Pokemon List Card background coloring
List<Color> pokemonTypeColors = [
   Color(0xFFA8A77A),
   Color(0xFFEE8130),
   Color(0xFF6390F0),
   Color(0xFF7AC74C),
   Color(0xFFF7D02C),
   Color(0xFF96D9D6),
   Color(0xFFC22E28),
   Color(0xFFA33EA1),
   Color(0xFFE2BF65),
   Color(0xFFA98FF3),
   Color(0xFFF95587),
   Color(0xFFA6B91A),
   Color(0xFFB6A136),
   Color(0xFF735797),
   Color(0xFF6F35FC),
   Color(0xFF705746),
   Color(0xFFB7B7CE),
   Color(0xFFD685AD),
]; 

/// All pokemon with levitating passive
List<int> levitatingPokemons = [
  92,
  93,
  109,
  110,
  200,
  201,
  329,
  330,
  337,
  338,
  343,
  344,
  355,
  358,
  380,
  381,
  429,
  433,
  436,
  437,
  455,
  479,
  480,
  481,
  482,
  487,
  488,
  602,
  603,
  604,
  615,
  635,
  738,
];

//! Example
const cols = 18;
const rows = 18;
final array = List.generate(rows,
    (i) => List.generate(cols + 1, (j) => i + j * cols + 1, growable: false),
    growable: false);

/// List of pokemon Types
List<String> pokemonTypes = ['Normal','Fire','Water','Grass','Electric','Ice','Fighting','Poison','Ground','Flying','Psychic','Bug','Rock','Ghost','Dragon','Dark','Steel','Fairy',];


/// Status Graph for all pokemon types
List<List<double>> pokemonTypeChart = [
  [1,1,1,1,1,1,1,1,1,1,1,1,(1/2),0,1,1,(1/2),1],                      // 0 Normal
  [1,(1/2),(1/2),2,1,2,1,1,1,1,1,2,(1/2),1,(1/2),1,2,1],              // 1 Fire
  [1,2,(1/2),(1/2),1,1,1,1,2,1,1,1,2,1,(1/2),1,1,1],                  // 2 Water
  [1,(1/2),2,(1/2),1,1,1,(1/2),2,(1/2),1,(1/2),2,1,(1/2),1,(1/2),1],  // 3 Grass
  [1,1,2,(1/2),(1/2),1,1,1,0,2,1,1,1,1,(1/2),1,1,1],                  // 4 Electric
  [1,(1/2),(1/2),2,1,(1/2),1,1,2,2,1,1,1,1,2,1,(1/2),1],              // 5 Ice
  [2,1,1,1,1,2,1,(1/2),1,(1/2),(1/2),(1/2),2,0,1,2,2,(1/2)],          // 6 Fighting
  [1,1,1,2,1,1,1,(1/2),(1/2),1,1,1,(1/2),(1/2),1,1,0,2],              // 7 Poison
  [1,2,1,(1/2),2,1,1,2,1,0,1,(1/2),2,1,1,1,2,1],                      // 8 Ground
  [1,1,1,2,(1/2),1,2,1,1,1,1,2,(1/2),1,1,1,(1/2),1],                  // 9 Flying
  [1,1,1,1,1,1,2,2,1,1,(1/2),1,1,1,1,0,(1/2),1],                      // 10 Psychic
  [1,(1/2),1,2,1,1,(1/2),(1/2),1,(1/2),2,1,1,(1/2),1,2,(1/2),(1/2)],  // 11 Bug
  [1,2,1,1,1,2,(1/2),1,(1/2),2,1,2,1,1,1,1,(1/2),1],                  // 12 Rock
  [0,1,1,1,1,1,1,1,1,1,2,1,1,2,1,(1/2),1,1],                          // 13 Ghost
  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,(1/2),0],                          // 14 Dragon
  [1,1,1,1,1,1,(1/2),1,1,1,2,1,1,2,1,(1/2),1,(1/2)],                  // 15 Dark
  [1,(1/2),(1/2),1,(1/2),2,1,1,1,1,1,1,2,1,1,1,(1/2),2],              // 16 Steel
  [1,(1/2),1,1,1,1,2,(1/2),1,1,1,1,1,1,2,2,(1/2),1],                  // 17 Fairy
];


double damageMultiplierCalculator (int attackTypeIndex, List<int> defenderTypesIndexes, bool isLevitating) {
  double damageMultiplier = 1;

  for (int i = 0; i < defenderTypesIndexes.length; i++){
     damageMultiplier = damageMultiplier * pokemonTypeChart[attackTypeIndex][defenderTypesIndexes[i]];
     if (isLevitating){
      if(attackTypeIndex == 8){
        damageMultiplier = 0;
      }
     }
  }

  return damageMultiplier;

}

int parsePokemonTypeTextToIndex(String pokemonTypeName){
  return pokemonTypes.indexWhere((element) => element == pokemonTypeName);
}

bool checkIfPokemonIsLevitating(int pokemonId) {
   return levitatingPokemons.contains(pokemonId);
}



