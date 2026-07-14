enum CardType { physical, virtual }

class CardModel {
  final String id;
  final String holderName;
  final String last4;
  final String expiryDate;
  final String cvv;
  final CardType type;

  const CardModel({
    required this.id,
    required this.holderName,
    required this.last4,
    required this.expiryDate,
    required this.cvv,
    required this.type,
  });
}

final List<CardModel> dummyCards = [
  const CardModel(
    id: 'card_1',
    holderName: 'Tayyab Sohail',
    last4: '2345',
    expiryDate: '12/02/2024',
    cvv: '633',
    type: CardType.physical,
  ),
  const CardModel(
    id: 'card_2',
    holderName: 'Tayyab Sohail',
    last4: '7821',
    expiryDate: '05/09/2025',
    cvv: '104',
    type: CardType.physical,
  ),
  const CardModel(
    id: 'card_3',
    holderName: 'Tayyab Sohail',
    last4: '4590',
    expiryDate: '08/11/2026',
    cvv: '229',
    type: CardType.virtual,
  ),
];
