import 'package:e_commerce/core/enteties/review_entite.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AddProductIntety extends Equatable {
  late final String name;
  final num price;
  final String code;
  final String description;
  String? imageurl;
  final int expirationDate;
  final int unitAmount;
  final bool isOrganic;
  final num numberOfcalories;
  final num averageRating = 0;
  final int ratingcount = 0;
  final List<ReviewEntite> reviews;

  AddProductIntety({
    required this.name,
    required this.price,
    required this.code,
    required this.description,
    this.imageurl,
    required this.expirationDate,
    required this.unitAmount,
    this.isOrganic = false,
    required this.numberOfcalories,
    required this.reviews,
  });

  @override
  List<Object?> get props => [code];
}
