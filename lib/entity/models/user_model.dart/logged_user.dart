import 'package:doggie_walker/entity/models/pet/pet_model.dart';
import 'package:doggie_walker/entity/models/user_model.dart/user_model.dart';

/// Logged user
class LoggedUser extends AppUser {
  /// Logged user
  const LoggedUser({
    required int id,
    required String name,
    List<Pet>? pets,
  })  : _userId = id,
        _userName = name,
        _userPets = pets ?? const [];

  /// user Id
  final int _userId;

  /// user name
  final String _userName;

  /// list of user pets
  final List<Pet> _userPets;

  /// get user Id
  int get id => _userId;

  /// get user name
  String get name => _userName;

  /// get list of users pets
  List<Pet> get pets => _userPets;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
