import 'package:flutter/material.dart';
import 'package:breaking/data/models/characters.dart' as char;
import 'package:breaking/constants/strings.dart';

class CharacterItem extends StatelessWidget {
  final char.Characters character;
  CharacterItem({required this.character});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.fromSTEB(4, 4, 4, 4),
      padding: EdgeInsets.all(4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white60,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, characterDetailsScreen,
              arguments: character);
        },
        child: GridTile(
          child: Hero(
            tag: character.actorId,
            child: Container(
              color: Colors.white,
              child: character.actorImage.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: 'assets/images/loading.gif',
                      image: character.actorImage,
                      fit: BoxFit.cover,
                    )
                  : Image.asset('assets/images/placeholder.png'),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              '${character.actorSeriesName}',
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
