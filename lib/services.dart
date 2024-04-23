import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchPokemon(String pokemonName) async {
  final response = await http.get(
    Uri.parse('https://pokeapi.co/api/v2/pokemon/bulbasaur'),
  );
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    // print('function: $response');
    // (data['products'].length != 0)
    //     ? showSuccessSnackBar(pageContext)
    //     : showErrorSnackBar(pageContext);
    return data;
  } else {
    // showErrorSnackBar(pageContext);
    throw Exception('Failed to fetch product data');
  }
}
