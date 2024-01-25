import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/color_manager.dart';

class CustomDropDownList extends StatelessWidget {
  final String hint;
  final String? value;
  final double? height;
  final List<DropdownMenuItem<String>>? items;
  final EdgeInsets? contentPadding;
  final Function(String? value) onChanged;

  const CustomDropDownList(
      {Key? key,
      required this.hint,
      required this.value,
      required this.items,
      this.height,
      this.contentPadding,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: height ?? 50,
      child: DropdownButtonFormField<String>(
        items: items,
        value: value,
        // isExpanded: true,
        padding: EdgeInsets.zero,
        onChanged: onChanged,
        dropdownColor: theme.scaffoldBackgroundColor,
        style: theme.textTheme.titleSmall!.copyWith(fontSize: 20.sp),
        icon: Icon(Icons.expand_more_sharp, color: ColorManager.primary),
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.zero,
          // isDense: isDense ?? true,
          // isCollapsed: isCollapsed ?? false,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 20.w),
          // errorText: errorText,
          // suffixIcon: suffixIcon,
          // prefixIcon: prefixIcon,
          // prefixIconConstraints: BoxConstraints(
          //   minWidth: 25,
          //   minHeight: 25,
          // ),
          hintText: hint,
          hintStyle: theme.textTheme.headlineSmall!.copyWith(fontSize: 21.sp),
          border: theme.inputDecorationTheme.border,
          // enabled border
          enabledBorder: theme.inputDecorationTheme.enabledBorder,
          // focused border
          focusedBorder: theme.inputDecorationTheme.focusedBorder,
          // error border
          errorBorder: theme.inputDecorationTheme.errorBorder,
          // focused error border
          focusedErrorBorder: theme.inputDecorationTheme.focusedErrorBorder,
        ),
      ),
    );
  }
}
