part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharacterLoaded extends CharactersState {
  final List<char.Characters> characters;
  CharacterLoaded(this.characters);
}

class QuoteLoaded extends CharactersState {
  final List<Quote> quotes;
  QuoteLoaded(this.quotes);
}
