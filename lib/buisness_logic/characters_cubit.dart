import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:breaking/data/repositories/characters_repositiry.dart';
import 'package:breaking/data/models/characters.dart' as char;
import 'package:breaking/data/models/quotes.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharacterRepository characterRepository;
  List<char.Characters> characters = [];
  CharactersCubit(this.characterRepository) : super(CharactersInitial());

  List<char.Characters> getCharacters() {
    characterRepository.getCharacters().then((characters) {
      emit(CharacterLoaded(characters));
      this.characters = characters;
    });
    return characters;
  }

  void getQuotes(String charName) {
    characterRepository.getQuotes(charName).then((quotes) {
      emit(QuoteLoaded(quotes));
    });
  }
}
