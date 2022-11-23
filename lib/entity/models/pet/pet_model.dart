import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

/// Pet model class. Contains full info about users pet.
class Pet extends Equatable {
  /// Pet model class. Contains full info about users pet.
  const Pet(
    String id,
    String petName,
    DateTime? birthDate,
    String? photo,
    String? info,
  )   : _id = id,
        _petName = petName,
        _birthDate = birthDate,
        _photo = photo,
        _info = info;

  /// factory constructor from firestore
  factory Pet.fromFs(Map<String, dynamic> map) {
    return Pet(
      map['petId'] as String? ?? '',
      map['name'] as String? ?? '',
      (map['birthDate'] as Timestamp?)?.toDate(),
      map['photoUrl'] as String?,
      map['info'] as String?,
    );
  }

  /// to firestore Map
  Map<String, dynamic> toFsMap() {
    return {
      'id': _id,
      'petName': _petName,
      'birthDate': _birthDate,
      'photo': _photo,
      'info': _info,
    };
  }

  /// pet id
  final String _id;

  /// pet nickname
  final String _petName;

  /// pet birth date
  final DateTime? _birthDate;

  /// link to pets photo
  final String? _photo;

  /// text with pet information
  final String? _info;

  /// get pet id
  String get id => _id;

  /// get pet name
  String get name => _petName;

  /// get url to pet photo
  String? get photo => _photo;

  /// get information text about pet
  String? get info => _info;

  /// get pet age
  int? get age {
    final petBirth = _birthDate;
    if (petBirth == null) {
      return null;
    }
    final currentDate = DateTime.now();
    var petAge = currentDate.year - petBirth.year;
    if (petBirth.month > currentDate.month) {
      petAge--;
    } else if (petBirth.month == currentDate.month) {
      if (petBirth.day > currentDate.day) {
        petAge--;
      }
    }
    return max(petAge, 0);
  }

  @override
  List<Object?> get props => [
        _id,
        _petName,
        _birthDate,
        _photo,
        _info,
      ];

  /// copy with method
  Pet copyWith({
    String? id,
    String? petName,
    DateTime? birthDate,
    String? photo,
    String? info,
  }) {
    return Pet(
      id ?? _id,
      petName ?? _petName,
      birthDate ?? _birthDate,
      photo ?? _photo,
      info ?? _info,
    );
  }
}
