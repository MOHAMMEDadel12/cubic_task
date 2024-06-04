import 'dart:convert';

import 'package:cubic_task/features/authentication_feature/domain/entities/branch_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubic_task/features/authentication_feature/domain/usecases/register_usecase.dart';
import 'package:cubic_task/features/authentication_feature/presentation/logic/register_cubit/register_states.dart';
import 'package:http/http.dart' as http;

import '../../../domain/usecases/get_branches_usecase.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  final RegisterUseCase registerUseCase;
  final GetBranchesUseCase getBranchesUseCase;

  RegisterCubit({
    required this.registerUseCase,
    required this.getBranchesUseCase,
  }) : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late GlobalKey<FormState> formKey;
  bool isNameError = false;
  bool isEmailError = false;
  bool isPhoneError = false;
  bool isPasswordError = false;

  String? selectedBranchId;
  List<BranchEntity> branches = [];

// Method to fetch branches
  void fetchBranches() async {
    emit(RegisterLoadingState());
    try {
      final response = await http
          .get(Uri.parse('http://81.29.111.142:8085/WRBOBSB/api/getBranches'));
      final data = json.decode(response.body);
      if (data['success'] && data['result'] != null) {
        branches = data['result'];
        //  emit(RegisterLoadedState());
      } else {
        // emit(RegisterErrorState(customError: 'Failed to fetch branches'));
      }
    } catch (e) {
      //   emit(RegisterErrorState(customError: e.toString()));
    }
  }

  /// Clear Errors
  clearErrors() {
    isPasswordError = false;
    isEmailError = false;
    isPhoneError = false;
    isNameError = false;
  }

  /// Init
  init() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    formKey = GlobalKey<FormState>();
    getBranches();
  }

  /// Dispose
  dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
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

  void setSelectedBranch(String branchId) {
    selectedBranchId = branchId;
    emit(BranchSelectedState(
        selectedBranchId: selectedBranchId!)); // Define this state if necessary
  }

  /// register
  getBranches() async {
    emit(GetBranchesLoadingState());
    var result = await getBranchesUseCase();
    result.fold((l) {
      emit(
        GetBranchesErrorState(
          customError: l,
        ),
      );
    }, (r) {
      branches = r;
      emit(
        GetBranchesSuccessState(),
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
