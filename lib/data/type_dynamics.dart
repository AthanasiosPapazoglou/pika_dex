
/// Offense Board Map
Map<String, List<double>> offenseBoard = {"": []};


/// Defence Board Map
Map<String, List<double>> defenseBoard = {"": []};

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
  [1,1,1,1,1,1,2,2,1,1,(1/2),1,1,1,1,0,(1/2),1],                      // 10 Physic
  [1,(1/2),1,2,1,1,(1/2),(1/2),1,(1/2),2,1,1,(1/2),1,2,(1/2),(1/2)],  // 11 Bug
  [1,2,1,1,1,2,(1/2),1,(1/2),2,1,2,1,1,1,1,(1/2),1],                  // 12 Rock
  [0,1,1,1,1,1,1,1,1,1,2,1,1,2,1,(1/2),1,1],                          // 13 Ghost
  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,(1/2),0],                          // 14 Dragon
  [1,1,1,1,1,1,(1/2),1,1,1,2,1,1,2,1,(1/2),1,(1/2)],                  // 15 Dark
  [1,(1/2),(1/2),1,(1/2),2,1,1,1,1,1,1,2,1,1,1,(1/2),2],              // 16 Steel
  [1,(1/2),1,1,1,1,2,(1/2),1,1,1,1,1,1,2,2,(1/2),1],                  // 17 Fairy
];

damageMultiplierCalculator (int attackTypeIndex, List<int> defenderTypesIndexes) {
  double damageMultiplier = 1;

  for (int i = 0; i < defenderTypesIndexes.length; i++){
     damageMultiplier = damageMultiplier * pokemonTypeChart[attackTypeIndex][defenderTypesIndexes[i]];
  }

  return damageMultiplier;

}


