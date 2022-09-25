import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:breaking/buisness_logic/characters_cubit.dart';
import 'package:flutter/material.dart';
import 'package:breaking/data/models/characters.dart' as char;
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final char.Characters character;

  const CharacterDetailsScreen({super.key, required this.character});

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.grey[700],
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          character.actorNickName,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        background: Hero(
          tag: character.actorId,
          child: Image.network(
            character.actorImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildChararterInfo({required String title, required String value}) {
    return RichText(
      textAlign: TextAlign.start,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        TextSpan(
          text: value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      thickness: 3,
      color: Colors.redAccent,
    );
  }

  Widget checkIfQuotesAreLoaded(CharactersState state) {
    if (state is QuoteLoaded) {
      return displayRandomQuoteOrEmptySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuoteOrEmptySpace(state) {
    var quotes = (state).quotes;
    if (quotes.length != 0) {
      int randomQuoteNum = Random().nextInt(quotes.length - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.redAccent,
            shadows: [
              Shadow(
                offset: Offset.zero,
                blurRadius: 5,
                color: Colors.grey,
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuoteNum].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: Colors.redAccent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context)
        .getQuotes(character.actorSeriesName);
    return Scaffold(
      backgroundColor: Colors.grey[700],
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildChararterInfo(
                        title: 'Jod: ',
                        value: character.actorJobs.join('/ '),
                      ),
                      buildDivider(305),
                      buildChararterInfo(
                        title: 'Appeared in: ',
                        value: character.categoryForTwoSeries,
                      ),
                      buildDivider(230),
                      buildChararterInfo(
                        title: 'Seasons: ',
                        value: character.actorApperanceBreacking.join('/ '),
                      ),
                      buildDivider(265),
                      buildChararterInfo(
                        title: 'Status: ',
                        value: character.actorStatus,
                      ),
                      buildDivider(280),
                      character.actorApperanceBetterCall.isEmpty
                          ? Container()
                          : buildChararterInfo(
                              title: 'Better Call Saul Seasons: ',
                              value:
                                  character.actorApperanceBetterCall.join('/ '),
                            ),
                      character.actorApperanceBetterCall.isEmpty
                          ? Container()
                          : buildDivider(120),
                      buildChararterInfo(
                          title: 'Actor/Actress: ', value: character.actorName),
                      buildDivider(220),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
