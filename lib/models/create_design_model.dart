class CreateDesignModel {
  String coverType = '';
  int? coverTypeId;

  String coverColor = '';
  int? coverColorId;

  String tapeType = '';
  int? tapeTypeId;

  String tapeColor = '';
  int? tapeColorId;

  String flowerType = '';
  int? flowerTypeId;

  String cardType = '';
  int? cardTypeId;
  CardDescriptionModel? cardDescription;
}

class CardDescriptionModel {
  String from = '';
  String to = '';
  String link = '';
  String message = '';

  CardDescriptionModel(
      {required this.from,
      required this.to,
      required this.link,
      required this.message});
}
