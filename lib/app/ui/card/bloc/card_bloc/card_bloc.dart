import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:thinkland_card/app/helper/custom.dart';

import '../../../../data/models/card_model.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  CardBloc() : super(CardInitial()) {
    on<GetCards>((event, emit) {
      emit(CardLoaded(cardList: cardList));
    });
    on<AddCard>((event, emit) {
      addCard(event.card);
      emit(CardLoaded(cardList: cardList));
    });
    on<EditCardScale>((event, emit) {
      cardScale = event.scale;
      emit(CardScaled(cardScale));
    });
  }

  double cardScale = 1.0;
  List<CardModel> cardList = [
    CardModel(
        id: 1,
        ownerFamilyName: "Yusubov",
        ownerName: "Farhod",
        cardNumber: '9999 9999 9999 9999',
        cardType: CardTypes.cCard,
        cvc: '999',
        validUntil: '11/2030',
        predefinedImagePath: defaultImages.first)
  ];

  addCard(CardModel card) {
    cardList.add(card);
  }
}
