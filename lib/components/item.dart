import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pokemon/model/pokemon.dart';
import 'package:pokemon/model/pokemon_color.dart';
import 'package:pokemon/pages/details.dart';

class PokemonGrid extends StatelessWidget {
  const PokemonGrid({Key? key, required this.pokemon}) : super(key: key);
  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Column(
      children: [
        InkWell(
            onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PokemonDetail(pokemon: pokemon!),
                    ),
                  ),
                },
            child: Hero(
              tag: pokemon!.name,
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: (typeColors[pokemon!.types.first] ?? Colors.grey[100])
                      ?.withOpacity(.3),
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: CachedNetworkImageProvider(
                      pokemon!.imageUrl,
                    ),
                  ),
                ),
              ),
            )),
        Text(
          pokemon!.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    ));
  }
}
