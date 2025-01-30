class CardModel {
  int? id;
  String ownerName;
  String ownerFamilyName;
  String validUntil;
  CardTypes cardType;
  String cardNumber;
  String cvc;
  String? backgroundColor;
  final double? blurAmount;
  String? predefinedImagePath;
  final String? customImagePath;
  double? scale;

  CardModel(
      {this.id,
      required this.cardNumber,
      required this.ownerFamilyName,
      required this.ownerName,
      required this.cardType,
      required this.cvc,
      required this.validUntil,
      this.backgroundColor,
      this.blurAmount,
      this.predefinedImagePath,
      this.customImagePath,
      this.scale});
}

enum CardTypes { mastercard, humo, cCard }
