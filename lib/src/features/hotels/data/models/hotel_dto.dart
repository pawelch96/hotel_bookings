import 'package:json_annotation/json_annotation.dart';

import 'package:hotel_bookings/src/features/hotels/domain/entities/hotel.dart';

part 'hotel_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class HotelResponseDto {
  const HotelResponseDto({required this.hotelCount, required this.hotels});

  factory HotelResponseDto.fromJson(Map<String, dynamic> json) => _$HotelResponseDtoFromJson(json);

  @JsonKey(name: 'hotel-count')
  final int hotelCount;
  final List<HotelDto> hotels;

  Map<String, dynamic> toJson() => _$HotelResponseDtoToJson(this);

  HotelsResult toEntity() => HotelsResult(
    hotelCount: hotelCount,
    hotels: hotels.map((hotel) => hotel.toEntity()).toList(),
  );
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
  factory HotelDto.fromEntity(Hotel hotel) => HotelDto(
    hotelId: hotel.id,
    name: hotel.name,
    destination: hotel.destination,
    category: hotel.category,
    images: hotel.images.map(HotelImageDto.fromEntity).toList(),
    ratingInfo: RatingInfoDto.fromEntity(hotel.ratingInfo),
    bestOffer: BestOfferDto.fromEntity(hotel.bestOffer),
    analytics: HotelAnalyticsDto.fromEntity(hotel.analytics),
  );

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
  factory HotelImageDto.fromEntity(HotelImage image) =>
      HotelImageDto(large: image.large, small: image.small);

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
  factory RatingInfoDto.fromEntity(RatingInfo rating) => RatingInfoDto(
    reviewsCount: rating.reviewsCount,
    score: rating.score,
    scoreDescription: rating.scoreDescription,
  );

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
    required this.travelDate,
  });

  factory BestOfferDto.fromJson(Map<String, dynamic> json) => _$BestOfferDtoFromJson(json);
  factory BestOfferDto.fromEntity(BestOffer offer) => BestOfferDto(
    flightIncluded: offer.flightIncluded,
    simplePricePerPerson: offer.simplePricePerPerson * 100,
    total: offer.total * 100,
    rooms: RoomsDto.fromEntity(offer.rooms),
    travelDate: TravelDateDto.fromEntity(offer.travelDate),
  );

  @JsonKey(name: 'flight-included')
  final bool flightIncluded;
  @JsonKey(name: 'simple-price-per-person')
  final int simplePricePerPerson;
  final int total;
  final RoomsDto rooms;
  @JsonKey(name: 'travel-date')
  final TravelDateDto travelDate;

  Map<String, dynamic> toJson() => _$BestOfferDtoToJson(this);

  BestOffer toEntity() => BestOffer(
    flightIncluded: flightIncluded,
    simplePricePerPerson: simplePricePerPerson ~/ 100,
    total: total ~/ 100,
    rooms: rooms.toEntity(),
    travelDate: travelDate.toEntity(),
  );
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class RoomsDto {
  const RoomsDto({required this.overall});

  factory RoomsDto.fromJson(Map<String, dynamic> json) => _$RoomsDtoFromJson(json);
  factory RoomsDto.fromEntity(Rooms rooms) =>
      RoomsDto(overall: RoomOverallDto.fromEntity(rooms.overall));

  final RoomOverallDto overall;

  Map<String, dynamic> toJson() => _$RoomsDtoToJson(this);

  Rooms toEntity() => Rooms(overall: overall.toEntity());
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
  factory RoomOverallDto.fromEntity(RoomOverall overall) => RoomOverallDto(
    boarding: overall.boarding,
    name: overall.name,
    adultCount: overall.adultCount,
    childrenCount: overall.childrenCount,
  );

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
  factory TravelDateDto.fromEntity(TravelDate travelDate) =>
      TravelDateDto(days: travelDate.days, nights: travelDate.nights);

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
  factory HotelAnalyticsDto.fromEntity(HotelAnalytics analytics) =>
      HotelAnalyticsDto(currencyItem: AnalyticsCurrencyDto(currency: analytics.currency));

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
