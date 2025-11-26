import 'package:equatable/equatable.dart';

class HotelsResult extends Equatable {
  const HotelsResult({required this.hotelCount, required this.hotels});

  final int hotelCount;
  final List<Hotel> hotels;

  @override
  List<Object?> get props => [hotelCount, hotels];
}

class Hotel extends Equatable {
  const Hotel({
    required this.id,
    required this.name,
    required this.destination,
    required this.category,
    required this.images,
    required this.ratingInfo,
    required this.bestOffer,
    required this.analytics,
  });

  final String id;
  final String name;
  final String destination;
  final int category;
  final List<HotelImage> images;
  final RatingInfo ratingInfo;
  final BestOffer bestOffer;
  final HotelAnalytics analytics;

  @override
  List<Object?> get props => [
    id,
    name,
    destination,
    category,
    images,
    ratingInfo,
    bestOffer,
    analytics,
  ];
}

class HotelImage extends Equatable {
  const HotelImage({required this.large, required this.small});

  final String large;
  final String small;

  @override
  List<Object?> get props => [large, small];
}

class RatingInfo extends Equatable {
  const RatingInfo({
    required this.reviewsCount,
    required this.score,
    required this.scoreDescription,
  });

  final int reviewsCount;
  final double score;
  final String scoreDescription;

  @override
  List<Object?> get props => [reviewsCount, score, scoreDescription];
}

class BestOffer extends Equatable {
  const BestOffer({
    required this.flightIncluded,
    required this.simplePricePerPerson,
    required this.total,
    required this.rooms,
    required this.travelDate,
  });

  final bool flightIncluded;
  final int simplePricePerPerson;
  final int total;
  final Rooms rooms;
  final TravelDate travelDate;

  @override
  List<Object?> get props => [flightIncluded, simplePricePerPerson, total, rooms, travelDate];
}

class Rooms extends Equatable {
  const Rooms({required this.overall});

  final RoomOverall overall;

  @override
  List<Object?> get props => [overall];
}

class RoomOverall extends Equatable {
  const RoomOverall({
    required this.boarding,
    required this.name,
    required this.adultCount,
    required this.childrenCount,
  });

  final String boarding;
  final String name;
  final int adultCount;
  final int childrenCount;

  @override
  List<Object?> get props => [boarding, name, adultCount, childrenCount];
}

class TravelDate extends Equatable {
  const TravelDate({required this.days, required this.nights});

  final int days;
  final int nights;

  @override
  List<Object?> get props => [days, nights];
}

class HotelAnalytics extends Equatable {
  const HotelAnalytics({required this.currency});

  final String currency;

  @override
  List<Object?> get props => [currency];
}
