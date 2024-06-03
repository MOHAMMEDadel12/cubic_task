import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubic_task/features/authentication_feature/domain/usecases/register_usecase.dart';
import 'package:cubic_task/features/authentication_feature/presentation/logic/register_cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  final RegisterUseCase registerUseCase;

  RegisterCubit({
    required this.registerUseCase,
  }) : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;
  bool isNameError = false;
  bool isEmailError = false;
  bool isPasswordError = false;

  /// Clear Errors
  clearErrors() {
    isPasswordError = false;
    isEmailError = false;
    isNameError = false;
  }

  /// Init
  init() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  /// Dispose
  dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  /// register
  register() async {
    emit(RegisterLoadingState());
    var result = await registerUseCase(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    result.fold((l) {
      emit(
        RegisterErrorState(
          customError: l,
        ),
      );
    }, (r) {
      emit(
        RegisterSuccessState(),
      );
    });
  }

  /// Set Data
  setData() {
    checkValidationBeforeRegister();
    emit(CheekDataBeforeRegisterState());
  }

  /// Check Validation Before Register
  bool checkValidationBeforeRegister() {
    if (nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        (emailController.text.isEmpty)) {
      return false;
    } else {
      return true;
    }
  }
}
