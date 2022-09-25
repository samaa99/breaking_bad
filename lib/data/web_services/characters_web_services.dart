import 'package:breaking/constants/strings.dart';
import 'package:dio/dio.dart';

class CharacterWebService {
  var dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
    ),
  );

  Future<List<dynamic>> getCharacters() async {
    try {
      Response response = await dio.get('/characters');
      //print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<dynamic>> getQuotes(String charName) async {
    try {
      Response response =
          await dio.get('quote', queryParameters: {'author': charName});
      //print(response.data);
      return response.data;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
