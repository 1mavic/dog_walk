import 'package:equatable/equatable.dart';

/// Pet model class. Contains full info about users pet.
class Pet extends Equatable {
  /// Pet model class. Contains full info about users pet.
  const Pet(
    this.id,
    this.petName,
    this.age,
    this.photo,
    this.info,
  );

  /// pet id
  final int id;

  /// pet nickname
  final String petName;

  /// pet age
  final int? age;

  /// link to pets photo
  final String? photo;

  /// text with pet information
  final String? info;

  @override
  List<Object?> get props => [
        id,
        petName,
        age,
        photo,
        info,
      ];

  /// copy with method
  Pet copyWith({
    int? id,
    String? petName,
    int? age,
    String? photo,
    String? info,
  }) {
    return Pet(
      id ?? this.id,
      petName ?? this.petName,
      age ?? this.age,
      photo ?? this.photo,
      info ?? this.info,
    );
  }
}
