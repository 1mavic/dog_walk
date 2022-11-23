import 'package:doggie_walker/entity/models/pet/pet_model.dart';
import 'package:doggie_walker/entity/models/user_model.dart/user_model.dart';

/// Logged user
class LoggedUser extends AppUser {
  /// Logged user
  const LoggedUser({
    required String id,
    required String name,
    List<Pet>? pets,
  })  : _userId = id,
        _userName = name,
        _userPets = pets ?? const [];

  /// factory constructor from firestore
  factory LoggedUser.fromFs(
    Map<String, dynamic> map,
    List<Map<String, dynamic>> userPets,
  ) {
    return LoggedUser(
      id: map['userId'] as String? ?? '',
      name: map['name'] as String? ?? '',
      pets: userPets.map(Pet.fromFs).toList(),
    );
  }

  /// user Id
  final String _userId;

  /// user name
  final String _userName;

  /// list of user pets
  final List<Pet> _userPets;

  /// get user Id
  String get id => _userId;

  /// get user name
  String get name => _userName;

  /// get list of users pets
  List<Pet> get pets => _userPets;

  /// make firestore map from user
  Map<String, dynamic> toFsMap() {
    return {
      'userId': _userId,
      'userName': _userName,
      'userPets': _userPets.map((pet) => pet.id).toList(),
    };
  }

  @override
  List<Object?> get props => [
        _userId,
        _userName,
        _userPets,
      ];

  @override
  bool? get stringify => throw UnimplementedError();
}
