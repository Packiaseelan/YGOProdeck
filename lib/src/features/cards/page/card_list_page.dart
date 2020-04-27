import 'package:YGOProdeck/src/features/cards/cards.dart';
import 'package:YGOProdeck/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CardListBloc>(context).add(FetchCardList());

    return Scaffold(
      appBar: AppBar(
        title: AtmTextHeading4(text: 'All Cards'),
      ),
      body: BlocBuilder<CardListBloc, CardListState>(
        builder: (context, state) {
          if (state is CardListLoading)
            return Center(child: CircularProgressIndicator());

          if (state is CardListLoaded)
            return TmplCardListPage(cards: state.cards);

          return Center(child: Text('Error'));
        },
      ),
    );
  }
}
