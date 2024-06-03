import 'package:cubic_task/core/rotues/route_keys.dart';
import 'package:cubic_task/core/utils/constants/font_sizes.dart';
import 'package:cubic_task/core/utils/constants/font_weights.dart';
import 'package:cubic_task/core/utils/helpers/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/constants/enums/toast_status_enum.dart';
import '../../../../core/utils/helpers/helpers.dart';
import '../../../../core/widgets/buttons/common_button_widget.dart';
import '../../../../core/widgets/form_field/common_text_form_field_widget.dart';
import '../../../../core/widgets/text/common_text_widget.dart';
import '../logic/register_cubit/register_cubit.dart';
import '../logic/register_cubit/register_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late RegisterCubit registerCubit;

  @override
  void initState() {
    registerCubit = BlocProvider.of(context);
    registerCubit.clearErrors();
    registerCubit.init();
    super.initState();
  }

  @override
  void dispose() {
    registerCubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.generalWhite,
      body: GestureDetector(
        onTap: () {
          Helpers.hideKeyboard(context);
        },
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (registerContext, registerState) {
            // /// Register Error
            // if (registerState is RegisterErrorState) {
            //   Navigator.pop(context);
            //   Helpers.showCommonSnackBar(
            //     context,
            //     registerState.customError.errorMessage,
            //     SnackBarStatus.error,
            //   );
            // }
            //
            // /// Register Successful
            // if (registerState is RegisterSuccessState) {
            //   Navigator.pop(context);
            //   registerCubit.init();
            //   SocketCubit.stopService();
            //   SocketCubit.initSocket();
            //   if (SharedText.activeWorkspaceID.isEmpty) {
            //     Navigator.pushNamedAndRemoveUntil(
            //       context,
            //       RouteKeys.enterWorkspaceName,
            //       (route) => false,
            //     );
            //   } else {
            //     Navigator.pushNamedAndRemoveUntil(
            //       context,
            //       RouteKeys.layoutKey,
            //       (route) => false,
            //     );
            //   }
            // }
            //
            // /// Register Loading
            // if (registerState is RegisterLoadingState) {
            //   Helpers.showLoaderWidget(context);
            // }
          },
          builder: (registerContext, registerState) {
            return Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(bottom: 16.r),
              child: SingleChildScrollView(
                child: Form(
                  key: registerCubit.formKey,
                  child: Column(
                    children: [
                      /// Header
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34.w),
                        child: Column(
                          children: [
                            /// Name FormField
                            CustomTextField(
                              filledColor: registerCubit.isNameError
                                  ? AppColors.errorBackground
                                  : AppColors.generalWhite,
                              isError: registerCubit.isNameError,
                              showTitle: true,
                              title: AppLocalizations.of(context)!.fullName,
                              controller:
                                  RegisterCubit.get(context).nameController,
                              inputType: TextInputType.emailAddress,
                              hintText:
                                  AppLocalizations.of(context)!.enterYourName,
                              onChanged: (p0) => registerCubit.setData(),
                              validate: (value) {
                                if (value!.isEmpty) {
                                  registerCubit.isNameError = true;
                                  return AppLocalizations.of(context)!
                                      .nameIsRequired;
                                } else if (!RegExp(r'[A-Za-z]')
                                    .hasMatch(value)) {
                                  registerCubit.isNameError = true;
                                  return AppLocalizations.of(context)!
                                      .nameMustStartWithCharacter;
                                } else {
                                  registerCubit.isNameError = false;
                                  return null;
                                }
                              },
                            ),

                            /// Space
                            SizedBox(
                              height: 16.h,
                            ),

                            /// Email FormField
                            CustomTextField(
                                filledColor: registerCubit.isEmailError
                                    ? AppColors.errorBackground
                                    : AppColors.generalWhite,
                                isError: registerCubit.isEmailError,
                                showTitle: true,
                                title: AppLocalizations.of(context)!.email,
                                controller:
                                    RegisterCubit.get(context).emailController,
                                inputType: TextInputType.emailAddress,
                                hintText:
                                    AppLocalizations.of(context)!.testEmail,
                                onChanged: (p0) =>
                                    RegisterCubit.get(context).setData(),
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    registerCubit.isEmailError = true;
                                    return AppLocalizations.of(context)!
                                        .emailMustBeNotEmpty;
                                  } else if (!Validators.emailRegExp
                                      .hasMatch(value)) {
                                    registerCubit.isEmailError = true;
                                    return AppLocalizations.of(context)!
                                        .emailIsInvalid;
                                  } else {
                                    registerCubit.isEmailError = false;
                                    return null;
                                  }
                                }),

                            /// Space
                            SizedBox(
                              height: 16.h,
                            ),

                            /// Password
                            CustomTextField(
                              filledColor: registerCubit.isPasswordError
                                  ? AppColors.errorBackground
                                  : AppColors.generalWhite,
                              showTitle: true,
                              title: AppLocalizations.of(context)!.password,
                              controller:
                                  RegisterCubit.get(context).passwordController,
                              inputType: TextInputType.text,
                              isPassword: true,
                              hintText: AppLocalizations.of(context)!
                                  .enterYourPassword,
                              onChanged: (p0) =>
                                  RegisterCubit.get(context).setData(),
                              validate: (value) {
                                if (!RegExp(
                                        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&*`()_+={}|~/<>,.;:،?!\\]).{8,}$')
                                    .hasMatch(value!)) {
                                  registerCubit.isPasswordError = true;
                                  return AppLocalizations.of(context)!
                                      .passwordRequirementsNotMet;
                                } else {
                                  registerCubit.isPasswordError = false;
                                  return null;
                                }

                                // if (value!.length < 8) {
                                //   registerCubit.isPasswordError = true;
                                //   return AppLocalizations.of(context)!
                                //       .passwordMustBeAtLeast8Characters;
                                // }
                                // else if (!RegExp(r'[0-9]').hasMatch(value)) {
                                //   registerCubit.isPasswordError = true;
                                //   return AppLocalizations.of(context)!
                                //       .yourPasswordMustContainAtLeastOneNumber;
                                // } else if (!RegExp(r'[A-Z]').hasMatch(value) ||
                                //     !RegExp(r'[a-z]').hasMatch(value)) {
                                //   registerCubit.isPasswordError = true;
                                //   return AppLocalizations.of(context)!
                                //       .yourPasswordMustHaveMixtureOfUppercaseAndLowercaseLetters;
                                // } else if (!RegExp(r'[#?!@$%^&*-./=+()]')
                                //     .hasMatch(value)) {
                                //   registerCubit.isPasswordError = true;
                                //   return AppLocalizations.of(context)!
                                //       .yourPasswordMustHaveAtLeastOnSpecialCharacter;
                                // } else {
                                //   registerCubit.isPasswordError = false;
                                //   return null;
                                // }
                              },
                            ),

                            /// Space
                            SizedBox(
                              height: 84.h,
                            ),

                            /// Create Account
                            CommonButton(
                              buttonColor: AppColors.topaz,
                              text: AppLocalizations.of(context)!.createAccount,
                              textColor: AppColors.generalWhite,
                              textFontSize: AppFontSize.s14.sp,
                              onTap: () {
                                Helpers.hideKeyboard(context);
                                if (registerCubit.formKey.currentState!
                                    .validate()) {
                                  RegisterCubit.get(context).register();
                                }
                              },
                              isEnable: RegisterCubit.get(context)
                                  .checkValidationBeforeRegister(),
                            ),

                            /// Space
                            SizedBox(
                              height: 16.h,
                            ),

                            /// Space
                            SizedBox(
                              height: 19.h,
                            ),

                            CommonTextWidget(
                              text: AppLocalizations.of(context)!
                                  .bySigningUpIAgree,
                              fontSize: AppFontSize.s12.sp,
                              textColor: AppColors.steel,
                              softWrap: true,
                              fontWeight: AppFontWeights.fw400,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
