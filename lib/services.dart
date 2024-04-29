import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchPokemon(String pokemonName) async {
  final response = await http.get(
    Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'),
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    return data;
  } else {
    // throw Exception('Failed to fetch product data');
    return {'Error': "No Data"};
  }
}
