import 'package:cubic_task/core/network/errors/custom_error.dart';

abstract class RegisterStates {}

/// Initial
class RegisterInitialState extends RegisterStates {}

/// Register States
class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class BranchSelectedState extends RegisterStates {
  final String selectedBranchId;

  BranchSelectedState({required this.selectedBranchId});
}

/// Initial

/// Register States
class GetBranchesLoadingState extends RegisterStates {}

class GetBranchesSuccessState extends RegisterStates {}

class GetBranchesErrorState extends RegisterStates {
  final CustomError customError;

  GetBranchesErrorState({
    required this.customError,
  });
}

class CheekDataBeforeRegisterState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final CustomError customError;

  RegisterErrorState({
    required this.customError,
  });
}
