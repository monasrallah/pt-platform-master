import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/value_manager.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final String? errorText;
  final Widget? prefix;
  final Widget? suffixIcon;
  final bool? obscureText;
  final bool? readOnly;
  final Function? onTap;
  final Function? onChanged;
  final Function? onSubmit;
  final Function? onTapOutside;
  final double? height;
  final bool isUnderLineBorderStyle;
  final int? maxLines;
  final Color? color;
  final bool? filled;
  final Color? fillColor;
  final Color? cursorColor;
  final EdgeInsetsDirectional? contentPadding;
  final String? Function(String?)? validator;

  // final InputBorder? en;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? textEditingController;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final TextAlign? textAlign;
  final bool isPhone;
  final bool showCountryFlag;
  final bool showDropdownIcon;
  final bool disableLengthCheck;

  const CustomTextField(
      {Key? key,
      this.obscureText,
      this.suffixIcon,
      this.prefix,
      required this.hint,
      this.textEditingController,
      this.errorText,
      this.hintStyle,
      this.style,
      this.readOnly,
      this.onTap,
      this.onChanged,
      this.onSubmit,
      this.onTapOutside,
      this.color,
      this.textAlign,
      this.inputFormatters,
      this.height,
      this.filled,
      this.fillColor,
      this.cursorColor,
      this.textInputAction,
      this.textInputType,
      this.isUnderLineBorderStyle = false,
      this.maxLines,
      this.contentPadding,
      this.isPhone = false,
      this.showCountryFlag = true,
      this.showDropdownIcon = true,
      this.disableLengthCheck = true,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    print(MediaQuery.textScaleFactorOf(context));
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        // textScaler: TextScaler.linear(
        //     getSuitableBigScale(MediaQuery.textScaleFactorOf(context)))
        textScaler:
            TextScaler.linear(0.8 * MediaQuery.textScaleFactorOf(context)),
      ),
      child: Padding(
        padding: EdgeInsets.all(1.5.h),
        child: isPhone
            ? IntlPhoneField(
                readOnly: readOnly ?? false,
                onTap: () {
                  onTap != null ? onTap!() : {};
                },
                controller: textEditingController,
                textAlign: textAlign ?? TextAlign.start,
                obscureText: obscureText ?? false,
                textInputAction: textInputAction ?? TextInputAction.next,
                keyboardType: textInputType ?? TextInputType.emailAddress,
                disableLengthCheck: disableLengthCheck,
                autovalidateMode: AutovalidateMode.disabled,
                dropdownTextStyle:
                    theme.textTheme.bodySmall!.copyWith(fontSize: 21.sp),
                decoration: InputDecoration(
                  isDense: true,
                  isCollapsed: false,
                  contentPadding: contentPadding ??
                      EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 20.w),
                  errorText: errorText,
                  suffixIcon: suffixIcon,
                  // prefixIcon: prefixIcon,
                  hintText: hint,
                  hintStyle:
                      theme.textTheme.headlineSmall!.copyWith(fontSize: 21.sp),
                  border: isUnderLineBorderStyle
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          borderSide: BorderSide(
                            color: color ?? theme.scaffoldBackgroundColor,
                            width: 6.h,
                          ),
                        )
                      : theme.inputDecorationTheme.border,

                  // enabled border
                  enabledBorder: isUnderLineBorderStyle
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          borderSide: BorderSide(
                            color: color ?? theme.scaffoldBackgroundColor,
                            width: 6.h,
                          ),
                        )
                      : theme.inputDecorationTheme.enabledBorder,

                  // focused border
                  focusedBorder: isUnderLineBorderStyle
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          borderSide: BorderSide(
                            color: color ?? theme.primaryColor,
                            width: AppSize.s1_5,
                          ),
                        )
                      : theme.inputDecorationTheme.focusedBorder,

                  // error border
                  errorBorder: isUnderLineBorderStyle
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          borderSide: BorderSide(
                            color: ColorManager.error,
                            width: AppSize.s1_5,
                          ),
                        )
                      : theme.inputDecorationTheme.errorBorder,

                  // focused error border
                  focusedErrorBorder: isUnderLineBorderStyle
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          borderSide: BorderSide(
                            color: color ?? theme.primaryColor,
                            width: AppSize.s1_5,
                          ),
                        )
                      : theme.inputDecorationTheme.focusedErrorBorder,
                ),
                style: style ??
                    theme.textTheme.bodyLarge!.copyWith(fontSize: 20.sp),
                initialCountryCode: 'SA',
                languageCode: "en",
                showCountryFlag: showCountryFlag,
                showDropdownIcon: showDropdownIcon,
                onChanged: (PhoneNumber phone) {
                  onChanged != null ? onChanged!(phone) : {};
                },
              )
            : TextFormField(
                cursorColor: cursorColor ?? theme.primaryColor,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  onTapOutside != null ? onTapOutside!() : () {};
                  // FocusScope.of(context).unfocus();
                },
                readOnly: readOnly ?? false,
                onTap: () {
                  onTap != null ? onTap!() : {};
                },
                onChanged: (value) {
                  onChanged != null ? onChanged!(value) : {};
                },
                onFieldSubmitted: (value) {
                  onSubmit != null ? onSubmit!(value) : {};
                },
                onSaved: (value) {
                  onSubmit != null ? onSubmit!(value) : {};
                },
                maxLines: maxLines ?? 1,
                controller: textEditingController,
                obscureText: obscureText ?? false,
                textInputAction: textInputAction ?? TextInputAction.next,
                inputFormatters: inputFormatters,
                keyboardType: textInputType ?? TextInputType.emailAddress,
                textAlign: textAlign ?? TextAlign.start,
                decoration: InputDecoration(
                  contentPadding: contentPadding ??
                      EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 16.w),
                  errorText: errorText,
                  suffixIcon: suffixIcon,
                  prefixIcon: prefix,
                  hintText: hint,
                  filled: filled ?? false,
                  fillColor: fillColor,
                  hintStyle: hintStyle ??
                      theme.textTheme.bodySmall
                          ?.copyWith(fontSize: 20.sp, color: color),
                  border: isUnderLineBorderStyle
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          borderSide: BorderSide(
                            color: color ?? theme.primaryColor,
                            width: AppSize.s1_5,
                          ),
                        )
                      : theme.inputDecorationTheme.border,

                  // enabled border
                  enabledBorder: isUnderLineBorderStyle
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          borderSide: BorderSide(
                            color: color ?? theme.scaffoldBackgroundColor,
                            width: AppSize.s1_5,
                          ),
                        )
                      : theme.inputDecorationTheme.enabledBorder,

                  // focused border
                  focusedBorder: isUnderLineBorderStyle
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          borderSide: BorderSide(
                            color: color ?? theme.primaryColor,
                            width: AppSize.s1_5,
                          ),
                        )
                      : theme.inputDecorationTheme.focusedBorder,

                  // error border
                  errorBorder: isUnderLineBorderStyle
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          borderSide: BorderSide(
                            color: ColorManager.error,
                            width: AppSize.s1_5,
                          ),
                        )
                      : theme.inputDecorationTheme.errorBorder,

                  // focused error border
                  focusedErrorBorder: isUnderLineBorderStyle
                      ? UnderlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s16),
                          borderSide: BorderSide(
                            color: color ?? theme.primaryColor,
                            width: AppSize.s1_5,
                          ),
                        )
                      : theme.inputDecorationTheme.focusedErrorBorder,
                ),
                style: style ??
                    theme.textTheme.bodyLarge!.copyWith(fontSize: 20.sp),
                validator: validator,
              ),
      ),
    );
  }
}
