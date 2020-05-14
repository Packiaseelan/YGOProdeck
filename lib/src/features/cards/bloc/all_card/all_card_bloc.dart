import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../cards.dart';

part 'all_card_event.dart';

part 'all_card_state.dart';

class AllCardBloc extends Bloc<AllCardEvent, AllCardState> {
  final CardRepository cardRepository;

  AllCardBloc({@required this.cardRepository})
      : assert(cardRepository != null);

  @override
  AllCardState get initialState => AllCardEmpty();

  @override
  Stream<Transition<AllCardEvent, AllCardState>> transformEvents(
    Stream<AllCardEvent> events,
    TransitionFunction<AllCardEvent, AllCardState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<AllCardState> mapEventToState(AllCardEvent event) async* {
    if (event is InitFetchAllCard) {
      yield AllCardEmpty();
    }
    if (event is FetchAllCard) {
      yield* _mapFetchCardsToState(event);
    }
    if (event is RefreshAllCard) {
      yield* _mapRefreshCardListToState(event);
    }
  }

  Stream<AllCardState> _mapFetchCardsToState(FetchAllCard event) async* {
    final currentState = state;
    if (event is FetchAllCard && !_hasReachedMax(currentState)) {
      try {
        if (currentState is AllCardEmpty) {
          final cards = await cardRepository.fetchAllCardList(num: 8, offset: 0);
          yield AllCardLoaded(cards: cards.data, hasReachedMax: false);
          return;
        }
        if (currentState is AllCardLoaded) {
          final cards = await cardRepository.fetchAllCardList(
              num: 8, offset: currentState.cards.length);
          yield cards.data.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : AllCardLoaded(
                  cards: currentState.cards + cards.data, hasReachedMax: false);
        }
      } catch (_) {
        yield AllCardError();
      }
    }
  }

  Stream<AllCardState> _mapRefreshCardListToState(
      RefreshAllCard event) async* {
    try {
      final cards = await cardRepository.fetchAllCardList(num: 8, offset: 0);
      yield AllCardLoaded(cards: cards.data, hasReachedMax: false);
    } catch (_) {
      yield state;
    }
  }

  bool _hasReachedMax(AllCardState state) =>
      state is AllCardLoaded && state.hasReachedMax;
}