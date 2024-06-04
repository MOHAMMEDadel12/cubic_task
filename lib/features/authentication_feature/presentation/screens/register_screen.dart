import 'package:cubic_task/core/cubits/Language_Cubit/language_cubit.dart';
import 'package:cubic_task/core/cubits/Language_Cubit/language_states.dart';
import 'package:cubic_task/core/rotues/route_keys.dart';
import 'package:cubic_task/core/utils/constants/font_sizes.dart';
import 'package:cubic_task/core/utils/constants/font_weights.dart';
import 'package:cubic_task/core/utils/helpers/validators.dart';
import 'package:cubic_task/core/widgets/images/common_asset_image_widget.dart';
import 'package:cubic_task/core/widgets/images/common_network_svg_widget.dart';
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
  const RegisterScreen({super.key});

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
        onTap: () => Helpers.hideKeyboard(context),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            // Add listener handlers here
          },
          builder: (context, state) {
            return SafeArea(
                child: SingleChildScrollView(
              child: Form(
                key: registerCubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60.h,
                    ),
                    CommonTextWidget(
                      text: "LOGO HERE",
                      textColor: AppColors.topaz,
                      fontSize: AppFontSize.s36.sp,
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34.w),
                      child: Column(
                        children: [
                          CustomTextField(
                            filledColor: registerCubit.isNameError
                                ? AppColors.errorBackground
                                : AppColors.generalWhite,
                            isError: registerCubit.isNameError,
                            showTitle: true,
                            title: AppLocalizations.of(context)!.fullName,
                            controller: registerCubit.nameController,
                            hintText:
                                AppLocalizations.of(context)!.enterYourName,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .nameCannotBeEmpty;
                              } else if (!RegExp(r'^[a-zA-Z\s]+$')
                                  .hasMatch(value)) {
                                return AppLocalizations.of(context)!
                                    .nameMustContainOnlyAlphabeticCharacters;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            filledColor: registerCubit.isEmailError
                                ? AppColors.errorBackground
                                : AppColors.generalWhite,
                            isError: registerCubit.isEmailError,
                            showTitle: true,
                            title: AppLocalizations.of(context)!.email,
                            controller: registerCubit.emailController,
                            hintText:
                                AppLocalizations.of(context)!.enterYourEmail,
                            validate: (value) {
                              if (!Validators.emailRegExp.hasMatch(value!)) {
                                return AppLocalizations.of(context)!
                                    .pleaseEnterAValidEmail;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          CustomTextField(
                            filledColor: registerCubit.isPhoneError
                                ? AppColors.errorBackground
                                : AppColors.generalWhite,
                            isError: registerCubit.isPhoneError,
                            showTitle: true,
                            title: AppLocalizations.of(context)!.phoneNumber,
                            controller: registerCubit.phoneController,
                            hintText: AppLocalizations.of(context)!
                                .enterYourPhoneNumber,
                            inputType: TextInputType.number,
                            validate: (value) {
                              if (!RegExp(r'^[0-9]{10}$').hasMatch(value!)) {
                                return AppLocalizations.of(context)!
                                    .pleaseEnterAValidPhoneNumber;
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.h),
                          DropdownButtonFormField<String>(
                            value: registerCubit.selectedBranchId,
                            borderRadius: BorderRadius.circular(10),
                            hint: Text(
                                AppLocalizations.of(context)!.chooseBranch),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                registerCubit.setSelectedBranch(newValue);
                              }
                            },
                            items: registerCubit.branches
                                .map<DropdownMenuItem<String>>((branch) {
                              return DropdownMenuItem<String>(
                                value: branch.id,
                                child: Text(branch.branchName.toString()),
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 84.h),
                          CommonButton(
                              buttonColor: AppColors.topaz,
                              text: AppLocalizations.of(context)!.createAccount,
                              textColor: AppColors.generalWhite,
                              textFontSize: AppFontSize.s14.sp,
                              onTap: () {
                                if (registerCubit.formKey.currentState!
                                    .validate()) {
                                  registerCubit.register();
                                }
                              },
                              isEnable: true),
                          SizedBox(
                            height: 20.h,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () {
                                LanguageCubit.get(context).changeLang(
                                    LanguageCubit.get(context).currentLang ==
                                            'en'
                                        ? 'ar'
                                        : 'en',
                                    context);
                              },
                              child: BlocBuilder<LanguageCubit, LanguageState>(
                                builder: (context, state) {
                                  final lang =
                                      LanguageCubit.get(context).currentLang;
                                  return CommonTextWidget(
                                      underLine: true,
                                      text:
                                          lang == 'ar' ? 'English' : 'العربية',
                                      fontSize: AppFontSize.s25.sp,
                                      fontWeight: AppFontWeights.fw400,
                                      textColor: AppColors.black);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}
