import 'package:breaking/buisness_logic/characters_cubit.dart';
import 'package:breaking/presentation/widgets/character_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:breaking/data/models/characters.dart' as char;
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  List<char.Characters> allCharacters = [];
  List<char.Characters> searchedForCharacters = [];
  bool _isSearching = false;
  final _searchTFController = TextEditingController();

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharactersCubit>(context).getCharacters();
  }

  Widget _buildSearchTF() {
    return TextField(
      controller: _searchTFController,
      cursorColor: Colors.white54,
      decoration: InputDecoration(
        hintText: 'Find a character',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Colors.white54,
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        color: Colors.white,
        fontSize: 18,
      ),
      onChanged: (searchedCharater) {
        _addSearchedItemToSearchedList(searchedCharater);
      },
    );
  }

  void _addSearchedItemToSearchedList(String searchedChar) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.actorSeriesName.toLowerCase().startsWith(searchedChar))
        .toList();
    setState(() {});
  }

  List<Widget> _appBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearchTF();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: Colors.white,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchTF();
    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchTF() {
    setState(() {
      _searchTFController.clear();
    });
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharacterLoaded) {
          allCharacters = (state).characters;
          //print('Character loaded state');
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.redAccent,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey[300],
        child: Column(
          children: [buildCharactersList()],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1,
        childAspectRatio: 2 / 3,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTFController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: _searchTFController.text.isEmpty
              ? allCharacters[index]
              : searchedForCharacters[index],
        );
      },
    );
  }

  Widget _buildRegularAppBar() {
    return Text(
      'Characters',
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Can\'t connect.. Please check your internet connection!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Image.asset('assets/images/error.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: _isSearching ? _buildSearchTF() : _buildRegularAppBar(),
        actions: _appBarActions(),
        leading: _isSearching
            ? BackButton(
                color: Colors.white,
              )
            : Container(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
