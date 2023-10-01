part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginPageUpdate extends AuthState {}

class ButtonLoadingState extends AuthState {}

class PasswordState extends AuthState {}
