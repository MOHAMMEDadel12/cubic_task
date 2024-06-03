import 'package:cubic_task/core/network/errors/custom_error.dart';

abstract class RegisterStates {}

/// Initial
class RegisterInitialState extends RegisterStates {}

/// Register States
class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}
class CheekDataBeforeRegisterState extends RegisterStates {}
class RegisterErrorState extends RegisterStates {
  final CustomError customError;

  RegisterErrorState({
    required this.customError,
  });
}