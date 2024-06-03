import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cubic_task/core/utils/constants/font_weights.dart';
import 'package:cubic_task/core/utils/constants/images.dart';
import 'package:cubic_task/core/widgets/images/common_asset_svg_widget.dart';
import 'package:cubic_task/core/widgets/text/common_text_widget.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/padding.dart';
import 'package:cubic_task/core/utils/constants/font_sizes.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? title;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool isPassword;
  final void Function(String)? onChanged;
  final Function? onSubmit;
  final void Function()? onTap;
  final Function? onSaved;
  final String? Function(String?)? validate;
  final bool isEnabled;
  final int maxLines;
  final int minLines;
  final TextCapitalization capitalization;
  final Widget? prefixIcon;
  final bool divider;
  final bool showTitle;
  final Widget? suffixIcon;
  final bool showCursor;
  final bool isError;
  final double? height;
  final Color filledColor;

  const CustomTextField({
    super.key,
    this.hintText = 'Write something...',
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.isEnabled = true,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.maxLines = 1,
    this.minLines = 1,
    this.onSubmit,
    this.onChanged,
    this.prefixIcon,
    this.capitalization = TextCapitalization.none,
    this.isPassword = false,
    this.divider = false,
    this.showTitle = false,
    this.showCursor = true,
    this.suffixIcon,
    this.onTap,
    this.onSaved,
    this.validate,
    this.title,
    this.height,
    this.isError = false,
    this.filledColor = AppColors.generalWhite,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.showTitle
            ? CommonTextWidget(
                text: "${widget.title}".toUpperCase(),
                fontSize: AppFontSize.s12.sp,
                fontWeight: AppFontWeights.fw500,
                textColor: AppColors.steel,
              )
            : const SizedBox(),
        SizedBox(
          height: widget.showTitle ? 8.h : 0,
        ),
        TextFormField(
           autovalidateMode: AutovalidateMode.disabled,
          validator: widget.validate,
          showCursor: widget.showCursor,
          enableInteractiveSelection: widget.showCursor,
          onTap: widget.onTap,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: TextStyle(
            fontSize: AppFontSize.s14.sp,
            fontWeight: AppFontWeights.fw400,
          ),
          textInputAction: widget.inputAction,
          keyboardType: widget.inputType,
          cursorColor: AppColors.steel,
          textCapitalization: widget.capitalization,
          enabled: widget.isEnabled,
          autofocus: false,
          obscureText: widget.isPassword ? _obscureText : false,
          inputFormatters: widget.inputType == TextInputType.phone
              ? <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp('[0-9+]'))
                ]
              : null,
          decoration: InputDecoration(
            focusedErrorBorder:   OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.errorDefault,
                width: 1.w,
              ),
            ),
            errorBorder:   OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.cerise,
                width: 1.w,
              ),
            ),
            prefix: SizedBox(width: 10.w),
            errorMaxLines: 2,
            errorStyle: TextStyle(
              fontSize: AppFontSize.s12.sp,
              fontWeight: AppFontWeights.fw400,
              color: AppColors.cerise,
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: AppPadding.p10.r,
              horizontal: 0.r,
            ),
            enabledBorder:   OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.r)),
                borderSide:
                    BorderSide(width: 1.w, color: AppColors.lightGrey100)),
            border:   OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(2.r)),
                borderSide:
                      BorderSide(width: 1.w, color: AppColors.lightGrey100)),
            isDense: true,
            focusedBorder:   OutlineInputBorder(
                borderRadius: BorderRadius.all(  Radius.circular(2.r)),
                borderSide:   BorderSide(width: 1.w, color: Colors.grey)),
            hintText: widget.hintText,
            fillColor: widget.filledColor,
            suffixIconConstraints: BoxConstraints(
              maxHeight: 48.h,
              maxWidth: 40.w,
            ),
            hintStyle: TextStyle(
              fontSize: AppFontSize.s14.sp,
              fontWeight: AppFontWeights.fw400,
              color: AppColors.steel,
            ),
            filled: true,
            prefixIcon: widget.prefixIcon != null
                ? Padding(
                    padding:   EdgeInsets.symmetric(horizontal: 15.w),
                    child: widget.prefixIcon!,
                  )
                : null,

            suffixIcon: widget.isPassword
                ? IconButton(
                    onPressed: _toggle,
                    icon: !_obscureText
                        ? CommonAssetSVGImage(
                            imageName: ImagesPath.visibility,
                            height: 16.h,
                      width: 16.h,

                    )
                        : CommonAssetSVGImage(
                            imageName: ImagesPath.visibilityOff,
                            height: 16.h,
                            width: 16.h,
                          ),
                  )
                : widget.isError
                    ? IconButton(
                        onPressed: () {},
                        icon: CommonAssetSVGImage(
                          imageName: ImagesPath.commonErrorIcon,
                          height: 20.h,
                          imageColor: AppColors.errorDefault,
                        )
            )
                    : widget.suffixIcon,
          ),
          onFieldSubmitted: (text) => widget.nextFocus != null
              ? FocusScope.of(context).requestFocus(widget.nextFocus)
              : widget.onSubmit != null
                  ? widget.onSubmit!(text)
                  : null,
          onChanged: widget.onChanged,
        ),
        widget.divider
            ?   Padding(
                padding:   EdgeInsets.symmetric(horizontal: 10.w),
                child: const Divider(),
              )
            : const SizedBox(),
      ],
    );
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
}
