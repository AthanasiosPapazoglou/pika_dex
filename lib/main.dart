import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pika_dex/models/pokemon.dart';
import 'package:pika_dex/pages/pokemon_list_page.dart';
import 'package:pika_dex/themes/app_themes.dart';

void main() {
  runApp(const PikaDex());
}

class PikaDex extends StatefulWidget {
  const PikaDex({super.key});

  @override
  State<PikaDex> createState() => _PikaDexState();
}


class _PikaDexState extends State<PikaDex> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: MainPokemonList(),
    );
  }
}

