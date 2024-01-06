import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/font_manager.dart';
import '../../resources/value_manager.dart';

class CustomListTile extends StatelessWidget {
  Widget? titleWidget;
  String? title;
  Widget? leading;
  Widget? trailing;
  final Function? onTap;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double? borderRadius;
  final bool? centerTitle;
  final double? elevation;
  final TextStyle? titleStyle;
  final ShapeBorder? shape;
  final Color? borderColor;
  final Alignment? titleAlignment;
  final Color? backGroundColor;
  final Widget? subtitle;

  CustomListTile({
    this.titleWidget,
    this.title,
    this.onTap,
    this.leading,
    this.trailing,
    this.elevation,
    Key? key,
    this.borderRadius,
    this.verticalPadding,
    this.horizontalPadding,
    this.centerTitle,
    this.titleStyle,
    this.shape,
    this.borderColor,
    this.titleAlignment,
    this.backGroundColor,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(

      tileColor: Colors.transparent,
      shape: shape,
      onTap: onTap != null ? () => onTap!() : null,
      dense: true,
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      contentPadding: EdgeInsets.symmetric(
          vertical: verticalPadding ?? AppPadding.p0,
          horizontal: horizontalPadding ?? AppPadding.p0),
      leading: leading,
      title: titleAlignment != null
          ? Align(
              alignment: titleAlignment!,
              child: titleWidget ?? buildRowTextTitle(theme))
          : titleWidget ?? buildRowTextTitle(theme),
      subtitle: subtitle,
      trailing: trailing,
    );
  }

  Row buildRowTextTitle(ThemeData theme) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title ?? "",
            style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeightManager.medium, fontSize: 20.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
