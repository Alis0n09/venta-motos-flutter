// lib/domain/model/auth_state.dart

import 'auth_models.dart';

enum AuthStatus { checking, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final LoggedUser? user;
  final String? error;

  const AuthState({
    required this.status,
    this.user,
    this.error,
  });

  const AuthState.checking()
      : status = AuthStatus.checking,
        user = null,
        error = null;

  const AuthState.authenticated(this.user)
      : status = AuthStatus.authenticated,
        error = null;

  const AuthState.unauthenticated([this.error])
      : status = AuthStatus.unauthenticated,
        user = null;

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isChecking => status == AuthStatus.checking;
  bool get isUnauthenticated => status == AuthStatus.unauthenticated;

  bool get isStaff => user?.isStaff ?? false;
  String? get rol => user?.rol;

  bool get isAdmin => rol == 'admin';
  bool get isVendedor => rol == 'vendedor';
  bool get isBodeguero => rol == 'bodeguero';
  bool get isCliente => isAuthenticated && !isStaff;

  AuthState copyWith({AuthStatus? status, LoggedUser? user, String? error}) =>
      AuthState(
        status: status ?? this.status,
        user: user ?? this.user,
        error: error,
      );
}