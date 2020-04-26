import 'package:YGOProdeck/src/features/cards/cards.dart';
import 'package:YGOProdeck/src/shared/shared.dart';
import 'package:YGOProdeck/src/widgets/molecules/mol_card_info_item.dart';
import 'package:flutter/material.dart';

class OrgCardList extends StatelessWidget {
  final CardListResponse cards;

  const OrgCardList({Key key, this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      physics: BouncingScrollPhysics(),
      itemCount: cards.data.length,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        return MolCardInfoItem(
          cardName: cards.data[index].name,
          cardImageUrl: cards.data[index].cardImages.first.imageUrlSmall,
          cardAttributeName: cards.data[index].attribute == null
              ? cards.data[index].race
              : cards.data[index].attribute,
          cardAttributeImageUrl: 'https://ygoprodeck.com/pics/24140059.jpg',
          cardColor: dark,
        );
      },
    );
  }
}