import 'package:doggie_walker/entity/models/user_model.dart/user_model.dart';

/// Not logged user
class NotLoggedUser extends AppUser {
  /// Not logged user
  const NotLoggedUser();
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => null;
}
