// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelResponseDto _$HotelResponseDtoFromJson(Map<String, dynamic> json) =>
    HotelResponseDto(
      hotelCount: (json['hotel-count'] as num).toInt(),
      hotels: (json['hotels'] as List<dynamic>)
          .map((e) => HotelDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HotelResponseDtoToJson(HotelResponseDto instance) =>
    <String, dynamic>{
      'hotel-count': instance.hotelCount,
      'hotels': instance.hotels.map((e) => e.toJson()).toList(),
    };

HotelDto _$HotelDtoFromJson(Map<String, dynamic> json) => HotelDto(
  hotelId: json['hotel-id'] as String,
  name: json['name'] as String,
  destination: json['destination'] as String,
  category: (json['category'] as num).toInt(),
  images: (json['images'] as List<dynamic>)
      .map((e) => HotelImageDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  ratingInfo: RatingInfoDto.fromJson(
    json['rating-info'] as Map<String, dynamic>,
  ),
  bestOffer: BestOfferDto.fromJson(json['best-offer'] as Map<String, dynamic>),
  analytics: HotelAnalyticsDto.fromJson(
    json['analytics'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$HotelDtoToJson(HotelDto instance) => <String, dynamic>{
  'hotel-id': instance.hotelId,
  'name': instance.name,
  'destination': instance.destination,
  'category': instance.category,
  'images': instance.images.map((e) => e.toJson()).toList(),
  'rating-info': instance.ratingInfo.toJson(),
  'best-offer': instance.bestOffer.toJson(),
  'analytics': instance.analytics.toJson(),
};

HotelImageDto _$HotelImageDtoFromJson(Map<String, dynamic> json) =>
    HotelImageDto(
      large: json['large'] as String,
      small: json['small'] as String,
    );

Map<String, dynamic> _$HotelImageDtoToJson(HotelImageDto instance) =>
    <String, dynamic>{'large': instance.large, 'small': instance.small};

RatingInfoDto _$RatingInfoDtoFromJson(Map<String, dynamic> json) =>
    RatingInfoDto(
      reviewsCount: (json['reviews-count'] as num).toInt(),
      score: (json['score'] as num).toDouble(),
      scoreDescription: json['score-description'] as String,
    );

Map<String, dynamic> _$RatingInfoDtoToJson(RatingInfoDto instance) =>
    <String, dynamic>{
      'reviews-count': instance.reviewsCount,
      'score': instance.score,
      'score-description': instance.scoreDescription,
    };

BestOfferDto _$BestOfferDtoFromJson(Map<String, dynamic> json) => BestOfferDto(
  flightIncluded: json['flight-included'] as bool,
  simplePricePerPerson: (json['simple-price-per-person'] as num).toInt(),
  total: (json['total'] as num).toInt(),
  rooms: RoomsDto.fromJson(json['rooms'] as Map<String, dynamic>),
  travelDate: TravelDateDto.fromJson(
    json['travel-date'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$BestOfferDtoToJson(BestOfferDto instance) =>
    <String, dynamic>{
      'flight-included': instance.flightIncluded,
      'simple-price-per-person': instance.simplePricePerPerson,
      'total': instance.total,
      'rooms': instance.rooms.toJson(),
      'travel-date': instance.travelDate.toJson(),
    };

RoomsDto _$RoomsDtoFromJson(Map<String, dynamic> json) => RoomsDto(
  overall: RoomOverallDto.fromJson(json['overall'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RoomsDtoToJson(RoomsDto instance) => <String, dynamic>{
  'overall': instance.overall.toJson(),
};

RoomOverallDto _$RoomOverallDtoFromJson(Map<String, dynamic> json) =>
    RoomOverallDto(
      boarding: json['boarding'] as String,
      name: json['name'] as String,
      adultCount: (json['adult-count'] as num).toInt(),
      childrenCount: (json['children-count'] as num).toInt(),
    );

Map<String, dynamic> _$RoomOverallDtoToJson(RoomOverallDto instance) =>
    <String, dynamic>{
      'boarding': instance.boarding,
      'name': instance.name,
      'adult-count': instance.adultCount,
      'children-count': instance.childrenCount,
    };

TravelDateDto _$TravelDateDtoFromJson(Map<String, dynamic> json) =>
    TravelDateDto(
      days: (json['days'] as num).toInt(),
      nights: (json['nights'] as num).toInt(),
    );

Map<String, dynamic> _$TravelDateDtoToJson(TravelDateDto instance) =>
    <String, dynamic>{'days': instance.days, 'nights': instance.nights};

HotelAnalyticsDto _$HotelAnalyticsDtoFromJson(Map<String, dynamic> json) =>
    HotelAnalyticsDto(
      currencyItem: AnalyticsCurrencyDto.fromJson(
        json['select_item.item.0'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$HotelAnalyticsDtoToJson(HotelAnalyticsDto instance) =>
    <String, dynamic>{'select_item.item.0': instance.currencyItem.toJson()};

AnalyticsCurrencyDto _$AnalyticsCurrencyDtoFromJson(
  Map<String, dynamic> json,
) => AnalyticsCurrencyDto(currency: json['currency'] as String);

Map<String, dynamic> _$AnalyticsCurrencyDtoToJson(
  AnalyticsCurrencyDto instance,
) => <String, dynamic>{'currency': instance.currency};
