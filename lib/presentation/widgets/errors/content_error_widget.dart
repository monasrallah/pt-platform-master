import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../resources/color_manager.dart';
import '../../../resources/functions/error_image.dart';
import '../buttons/out_lined_button.dart';

class ContentErrorWidget extends StatelessWidget {
  final String description;
  final Function onPress;
  final String buttonTitle;
  final int errorCode;
  final double? width;
  final double? height;

  const ContentErrorWidget(
      {Key? key,
      required this.description,
      required this.onPress,
      required this.buttonTitle,
      required this.errorCode,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width != null ? 0.04 * width! : 0.15.sw),
      child: SizedBox(
        width: width ?? 0.85.sw,
        height: height ?? 0.95.sh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //todo make function getImageError(Status code) and return suitable image
            SvgPicture.asset(
              getErrorImage(errorCode),
              color: ColorManager.lightBlack,
              height: height != null ? 0.5 * height! : 0.23.sh,
            ),
            SizedBox(
              height: height != null ? 0.04 * height! : 0.04.sh,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(description,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelLarge?.copyWith(
                          letterSpacing: 0.8,
                          fontSize: width != null ? 0.03 * width! : 23.sp)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: OutLinedButton(
                  title: buttonTitle,
                  onPress: () {
                    onPress();
                  },
                  borderColor: ColorManager.darkGrey,
                  borderWidth: 1,
                  height: 0.06.sh,
                  elevation: 0,
                  width: width != null ? 0.4 * width! : 0.5.sw,
                  textStyle:
                      theme.textTheme.bodyLarge?.copyWith(fontSize: 20.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
