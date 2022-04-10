import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:pokemon/model/pokemon.dart';
import 'package:pokemon/model/pokemon_color.dart';

class PokemonDetail extends StatelessWidget {
  const PokemonDetail({Key? key, required this.pokemon}) : super(key: key);
  final Pokemon? pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: (typeColors[pokemon!.types.first] ?? Colors.grey[100])
            ?.withOpacity(.5),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              const SizedBox(height: 32),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      height: 280,
                      width: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(180),
                        color: Colors.white.withOpacity(.5),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Hero(
                      tag: pokemon!.name,
                      child: CachedNetworkImage(
                        imageUrl: pokemon!.imageUrl,
                        height: 250,
                        width: 250,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90),
                  color: Colors.white.withOpacity(.5),
                ),
                child: Text(
                  '#${pokemon!.id.toString().padLeft(3, "0")}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '${pokemon!.name.substring(0, 1).toUpperCase()}${pokemon!.name.substring(1)}',
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: pokemon!.types
                    .map(
                      (type) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Chip(
                          backgroundColor: typeColors[type] ?? Colors.grey,
                          label: Text(
                            type,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: (typeColors[type] ?? Colors.grey)
                                          .computeLuminance() >
                                      0.5
                                  ? Colors.black
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
