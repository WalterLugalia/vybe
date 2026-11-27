import '../../../core/errors/app_exception.dart';
import '../models/app_user.dart';



class AuthState {
  const AuthState({this.user, this.isBusy = false, this.error});

  final AppUser? user;
  final bool isBusy;
  final AppException? error;

  bool get isAuthenticated => user != null;

}