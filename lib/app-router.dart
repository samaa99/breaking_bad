import 'package:breaking/buisness_logic/characters_cubit.dart';
import 'package:breaking/data/repositories/characters_repositiry.dart';
import 'package:breaking/data/web_services/characters_web_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'constants/strings.dart';
import 'presentation/screens/characters_screen.dart';
import 'presentation/screens/characters_details_screen.dart';
import 'package:breaking/data/models/characters.dart' as char;

class AppRouter {
  late CharactersCubit charactersCubit;
  late CharacterRepository characterRepository;

  AppRouter() {
    characterRepository = CharacterRepository(CharacterWebService());
    charactersCubit = CharactersCubit(characterRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailsScreen:
        final character = settings.arguments as char.Characters;
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (BuildContext context) =>
                      CharactersCubit(characterRepository),
                  child: CharacterDetailsScreen(
                    character: character,
                  ),
                ));
    }
  }
}
