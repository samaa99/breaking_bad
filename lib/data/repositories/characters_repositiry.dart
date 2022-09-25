import 'package:breaking/data/models/quotes.dart';
import 'package:breaking/data/web_services/characters_web_services.dart';
import 'package:breaking/data/models/characters.dart';

class CharacterRepository {
  final CharacterWebService characterWebService;
  CharacterRepository(this.characterWebService);

  Future<List<Characters>> getCharacters() async {
    final characters = await characterWebService.getCharacters();
    print(
        characters.map((character) => Characters.fromJson(character)).toList());
    return characters
        .map((character) => Characters.fromJson(character))
        .toList();
  }

  Future<List<Quote>> getQuotes(String charName) async {
    final quotes = await characterWebService.getQuotes(charName);
    return quotes.map((quote) => Quote.fromJson(quote)).toList();
  }
}
