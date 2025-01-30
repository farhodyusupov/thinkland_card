part of 'card_bloc.dart';

@immutable
sealed class CardEvent {}

class GetCards extends CardEvent {}

class AddCard extends CardEvent {
  CardModel card;
  AddCard(this.card);
}

class EditCardScale extends CardEvent {
  double scale;
  EditCardScale(this.scale);
}
