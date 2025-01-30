part of 'card_bloc.dart';

@immutable
sealed class CardState {}

final class CardInitial extends CardState {}

class CardLoaded extends CardState {
  final List<CardModel> cardList;

  CardLoaded({required this.cardList});
}

class CardAdded extends CardState {}

class CardScaled extends CardState {
  double cardScale;
  CardScaled(this.cardScale);
}
