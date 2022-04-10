import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:pokemon/model/pokemon.dart';
import 'package:pokemon/components/item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final pokemonsNotifier = PokemonsNotifier();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<PokemonsNotifier>(
          create: (context) => pokemonsNotifier,
        ),
      ],
      child: const PokemonApp(),
    ),
  );
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon App',
      theme: ThemeData.light(),
      home: const TopPage(title: 'Pokemon Page'),
    );
  }
}

class TopPage extends StatefulWidget {
  const TopPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Consumer<PokemonsNotifier>(
          builder: (context, pokemons, child) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemCount: 20,
            itemBuilder: (context, index) {
              return PokemonGrid(
                pokemon: pokemons.byId(index + 1),
              );
            },
          ),
        ));
  }
}
