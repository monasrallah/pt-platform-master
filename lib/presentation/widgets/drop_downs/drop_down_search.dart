import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../resources/design_constants.dart';

class CustomDropDownSearch extends StatelessWidget {
  const CustomDropDownSearch(
      {Key? key,
      this.asyncItems,
      this.enabled = true,
      required this.selectedItem,
      required this.onChanged,
      this.prefixIcon,
      this.textStyle,
      this.height,
      this.vertical,
      this.errorText,
      this.maxHeight,
      this.items})
      : super(key: key);
  final DropdownSearchOnFind<String>? asyncItems;
  final List<String>? items;
  final bool enabled;
  final double? maxHeight;
  final double? height;
  final double? vertical;
  final String selectedItem;
  final String? errorText;
  final TextStyle? textStyle;
  final Function(String?) onChanged;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(vertical: vertical ?? 0),
        child: DropdownSearch<String>(
          validator: (String? value) {
            if (value == null) {
              return errorText;
            }
            return null;
          },
          asyncItems: asyncItems != null
              ? (String filter) => asyncItems!(filter)
              : null,
          items: items != null ? items! : [],
          itemAsString: (String u) => u,
          autoValidateMode: AutovalidateMode.always,
          popupProps: PopupPropsMultiSelection.menu(
              showSelectedItems: true,
              showSearchBox: false,
              constraints: BoxConstraints(maxHeight: maxHeight ?? 150.h)),
          enabled: enabled,
          selectedItem: selectedItem,
          onChanged: (String? data) {
            onChanged(data);
          },
          dropdownDecoratorProps: DropDownDecoratorProps(
            baseStyle: textStyle ??
                theme.textTheme.titleSmall!.copyWith(fontSize: 20.sp),
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            dropdownSearchDecoration: InputDecoration(
              prefixIcon: prefixIcon,
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              border:
                  kUnderlinedBorderGrey, //theme.inputDecorationTheme.border,

              // enabled border
              enabledBorder:
                  kUnderlinedBorderGrey, //theme.inputDecorationTheme.enabledBorder,

              // focused border
              focusedBorder:
                  kUnderlinedBorderGrey, //theme.inputDecorationTheme.focusedBorder,

              // error border
              errorBorder:
                  kUnderlinedBorderRed, //theme.inputDecorationTheme.errorBorder,

              // focused error border
              focusedErrorBorder:
                  kUnderlinedBorderRed, //theme.inputDecorationTheme.focusedErrorBorder,
            ),
          ),
        ),
      ),
    );
  }
}
