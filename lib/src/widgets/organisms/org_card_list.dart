import 'package:flutter/material.dart';

import '../../features/cards/cards.dart';
import '../../shared/shared.dart';
import '../widgets.dart';

class OrgCardList extends StatelessWidget {
  final List<CardListData> cards;
  final ScrollController scrollController;
  final bool hasReachedMax;

  const OrgCardList(
      {Key key, this.cards, this.scrollController, this.hasReachedMax})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildCardListView();
  }

  Widget buildCardListView() {
    return ListView.builder(
      controller: scrollController,
      shrinkWrap: false,
      physics: BouncingScrollPhysics(),
      itemCount: hasReachedMax ? cards.length : cards.length + 1,
      padding: EdgeInsets.all(16),
      itemBuilder: (context, index) {
        print("Index $index -- Lenght ${cards.length}");
        if (index >= cards.length) {
          if (cards.length >= 10) {
            return Center(child: AtmPrimaryLoading());
          }
          return Container();
        } else {
          if (cards[index].type.toLowerCase().contains('monster')) {
            return MolMonsterCardInfoItem(
              cardName: cards[index].name,
              cardImageUrl: cards[index].cardImages.first.imageUrl,
              cardAttributeName:
                  cards[index].attribute.toLowerCase().capitalize(),
              cardAttributeImageUrl: cardAttributeIcon(cards[index].attribute),
              cardRaceName: cards[index].race,
              cardRaceImageUrl: cardRaceIcon(cards[index].race),
              cardColor: cardColor(cards[index]),
              atkDef: atkDefList(cards[index]),
              onPressed: () =>
                  onNavigateToDetail(context, cardName: cards[index].name),
            );
          } else {
            return MolNonMonsterCardInfoItem(
              cardName: cards[index].name,
              cardImageUrl: cards[index].cardImages.first.imageUrl,
              cardRaceName: cards[index].race,
              cardRaceImageUrl: cardRaceIcon(cards[index].race),
              cardColor: cardColor(cards[index]),
              onPressed: () =>
                  onNavigateToDetail(context, cardName: cards[index].name),
            );
          }
        }
      },
    );
  }

  void onNavigateToDetail(context, {@required String cardName}) =>
      Navigator.pushNamed(context, routeCardDetail, arguments: cardName);
}
