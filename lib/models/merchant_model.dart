class MerchantModel {
  MerchantModel(
      {this.id,
      this.name,
      this.image,
      this.type,
      this.regionId,
      this.cityId,
      this.streetName,
      this.desc,
        this.whatsapp,
      this.latitude,
      this.longitude,
      this.openAt,
      this.closeAt,
      this.isCustomize,
      this.isOpen,
      this.distance,
      this.attributes,
      this.isDisabled,
      this.star,
      this.merchantPolicy});

  final int? id;
  final String? name;
  final String? image;
  final int? type;
  final int? regionId;
  final int? cityId;
  final String? streetName;
  final String? desc;
  final String? whatsapp;
  final String? latitude;
  final String? longitude;
  final String? openAt;
  final String? closeAt;
  final bool? isCustomize;
  final bool? isOpen;
  final bool? isDisabled;
  final String? distance;
  final int? star;
  final Map<String, dynamic>? attributes;
  final String? merchantPolicy;

  factory MerchantModel.fromJson(Map<String, dynamic> json) {
    return MerchantModel(
        id: json['id'],
        name: json['brand_name'] ?? '',
        image: json['image'] ?? '',
        type: int.parse(json['type_merchant_id'].toString()),
        regionId: int.parse(json['region_id'].toString()),
        cityId: int.parse(json['city_id'].toString()),
        streetName: json['street_name'] ?? '',
        desc: json['description'] ?? '',
        latitude: json['latitude'] ?? '',
        longitude: json['longitude'] ?? '',
        openAt: json['open_at'] ?? '',
        closeAt: json['close_at'] ?? '',
        isCustomize: json['enable_customization'] == 0 ? false : true,
        isOpen: json['is_open'] ?? false,
        distance: json['distance'] ?? '',
        whatsapp: json['whatsapp_number'] ?? '',
        attributes: json['attributes'] ?? {},
        isDisabled: json['is_disabled'] ?? false,
        star: json['star'] ?? 0,
        merchantPolicy: json['return_policy'] ?? '');
  }
}
