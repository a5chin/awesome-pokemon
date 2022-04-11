import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

const String apiroot = "https://pokeapi.co/api/v2/";

class Pokemon {
  final int id;
  final String name;
  final List<String> types;
  final String imageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.types,
    required this.imageUrl,
  });

  factory Pokemon.fromJson(
      Map<String, dynamic> jsonEn, Map<String, dynamic> jsonJa) {
    List<String> typesToList(dynamic types) {
      List<String> ret = [];
      for (int i = 0; i < types.length; i++) {
        ret.add(types[i]['type']['name']);
      }
      return ret;
    }

    return Pokemon(
      id: jsonEn['id'],
      name: jsonJa['names'][0]['name'],
      types: typesToList(jsonEn['types']),
      imageUrl: jsonEn['sprites']['other']['official-artwork']['front_default'],
    );
  }
}

Future<Pokemon> fetchPokemon(int id) async {
  final resEn = await http.get(Uri.parse('$apiroot/pokemon/$id'));
  final resJa = await http.get(Uri.parse('$apiroot/pokemon-species/$id'));
  if (resEn.statusCode == 200 && resJa.statusCode == 200) {
    return Pokemon.fromJson(jsonDecode(resEn.body), jsonDecode(resJa.body));
  } else {
    throw Exception('Failed to Load Pokemon');
  }
}

class PokemonsNotifier extends ChangeNotifier {
  final Map<int, Pokemon?> _pokeMap = {};

  Map<int, Pokemon?> get pokes => _pokeMap;

  void addPoke(Pokemon poke) {
    _pokeMap[poke.id] = poke;
    notifyListeners();
  }

  void fetchPoke(int id) async {
    _pokeMap[id] = null;
    addPoke(await fetchPokemon(id));
  }

  Pokemon? byId(int id) {
    if (!_pokeMap.containsKey(id)) {
      fetchPoke(id);
    }
    return _pokeMap[id];
  }
}
