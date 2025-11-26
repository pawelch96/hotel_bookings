import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/hotel.dart';

part 'hotel_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class HotelResponseDto {
  const HotelResponseDto({required this.hotelCount, required this.hotels});

  factory HotelResponseDto.fromJson(Map<String, dynamic> json) => _$HotelResponseDtoFromJson(json);

  @JsonKey(name: 'hotel-count')
  final int hotelCount;
  final List<HotelDto> hotels;

  Map<String, dynamic> toJson() => _$HotelResponseDtoToJson(this);

  List<Hotel> toEntities() => hotels.map((hotel) => hotel.toEntity()).toList();
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class HotelDto {
  const HotelDto({
    required this.hotelId,
    required this.name,
    required this.destination,
    required this.category,
    required this.images,
    required this.ratingInfo,
    required this.bestOffer,
    required this.analytics,
  });

  factory HotelDto.fromJson(Map<String, dynamic> json) => _$HotelDtoFromJson(json);

  @JsonKey(name: 'hotel-id')
  final String hotelId;
  final String name;
  final String destination;
  final int category;
  final List<HotelImageDto> images;
  @JsonKey(name: 'rating-info')
  final RatingInfoDto ratingInfo;
  @JsonKey(name: 'best-offer')
  final BestOfferDto bestOffer;
  final HotelAnalyticsDto analytics;

  Map<String, dynamic> toJson() => _$HotelDtoToJson(this);

  Hotel toEntity() => Hotel(
    id: hotelId,
    name: name,
    destination: destination,
    category: category,
    images: images.map((image) => image.toEntity()).toList(),
    ratingInfo: ratingInfo.toEntity(),
    bestOffer: bestOffer.toEntity(),
    analytics: analytics.toEntity(),
  );
}

@JsonSerializable()
class HotelImageDto {
  const HotelImageDto({required this.large, required this.small});

  factory HotelImageDto.fromJson(Map<String, dynamic> json) => _$HotelImageDtoFromJson(json);

  final String large;
  final String small;

  Map<String, dynamic> toJson() => _$HotelImageDtoToJson(this);

  HotelImage toEntity() => HotelImage(large: large, small: small);
}

@JsonSerializable()
class RatingInfoDto {
  const RatingInfoDto({
    required this.reviewsCount,
    required this.score,
    required this.scoreDescription,
  });

  factory RatingInfoDto.fromJson(Map<String, dynamic> json) => _$RatingInfoDtoFromJson(json);

  @JsonKey(name: 'reviews-count')
  final int reviewsCount;
  final double score;
  @JsonKey(name: 'score-description')
  final String scoreDescription;

  Map<String, dynamic> toJson() => _$RatingInfoDtoToJson(this);

  RatingInfo toEntity() =>
      RatingInfo(reviewsCount: reviewsCount, score: score, scoreDescription: scoreDescription);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class BestOfferDto {
  const BestOfferDto({
    required this.flightIncluded,
    required this.simplePricePerPerson,
    required this.total,
    required this.rooms,
  });

  factory BestOfferDto.fromJson(Map<String, dynamic> json) => _$BestOfferDtoFromJson(json);

  @JsonKey(name: 'flight-included')
  final bool flightIncluded;
  @JsonKey(name: 'simple-price-per-person')
  final int simplePricePerPerson;
  final int total;
  final RoomsDto rooms;

  Map<String, dynamic> toJson() => _$BestOfferDtoToJson(this);

  BestOffer toEntity() => BestOffer(
    flightIncluded: flightIncluded,
    simplePricePerPerson: simplePricePerPerson,
    total: total,
    rooms: rooms.toEntity(),
  );
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class RoomsDto {
  const RoomsDto({required this.overall, required this.travelDate});

  factory RoomsDto.fromJson(Map<String, dynamic> json) => _$RoomsDtoFromJson(json);

  final RoomOverallDto overall;
  @JsonKey(name: 'travel-date')
  final TravelDateDto travelDate;

  Map<String, dynamic> toJson() => _$RoomsDtoToJson(this);

  Rooms toEntity() => Rooms(overall: overall.toEntity(), travelDate: travelDate.toEntity());
}

@JsonSerializable(fieldRename: FieldRename.snake)
class RoomOverallDto {
  const RoomOverallDto({
    required this.boarding,
    required this.name,
    required this.adultCount,
    required this.childrenCount,
  });

  factory RoomOverallDto.fromJson(Map<String, dynamic> json) => _$RoomOverallDtoFromJson(json);

  final String boarding;
  final String name;
  @JsonKey(name: 'adult-count')
  final int adultCount;
  @JsonKey(name: 'children-count')
  final int childrenCount;

  Map<String, dynamic> toJson() => _$RoomOverallDtoToJson(this);

  RoomOverall toEntity() => RoomOverall(
    boarding: boarding,
    name: name,
    adultCount: adultCount,
    childrenCount: childrenCount,
  );
}

@JsonSerializable()
class TravelDateDto {
  const TravelDateDto({required this.days, required this.nights});

  factory TravelDateDto.fromJson(Map<String, dynamic> json) => _$TravelDateDtoFromJson(json);

  final int days;
  final int nights;

  Map<String, dynamic> toJson() => _$TravelDateDtoToJson(this);

  TravelDate toEntity() => TravelDate(days: days, nights: nights);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class HotelAnalyticsDto {
  const HotelAnalyticsDto({required this.currencyItem});

  factory HotelAnalyticsDto.fromJson(Map<String, dynamic> json) =>
      _$HotelAnalyticsDtoFromJson(json);

  @JsonKey(name: 'select_item.item.0')
  final AnalyticsCurrencyDto currencyItem;

  Map<String, dynamic> toJson() => _$HotelAnalyticsDtoToJson(this);

  HotelAnalytics toEntity() => HotelAnalytics(currency: currencyItem.currency);
}

@JsonSerializable()
class AnalyticsCurrencyDto {
  const AnalyticsCurrencyDto({required this.currency});

  factory AnalyticsCurrencyDto.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsCurrencyDtoFromJson(json);

  final String currency;

  Map<String, dynamic> toJson() => _$AnalyticsCurrencyDtoToJson(this);
}
