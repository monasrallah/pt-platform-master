import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomEmptyContent extends StatelessWidget {
  final String description;
  final Function? onRefresh;
  final String? image;
  final double? height;
  final double? width;
  final TextStyle? style;

  const CustomEmptyContent.fromText(
      {Key? key,
      required this.description,
      this.onRefresh,
      this.image,
      this.height,
      this.width,
      this.style})
      : super(key: key);

  const CustomEmptyContent.fromTextWithIcon(
      {Key? key,
      required this.description,
      required this.onRefresh,
      this.image,
      required this.height,
      required this.width,
      this.style})
      : super(key: key);

  const CustomEmptyContent.fromImage(
      {Key? key,
      required this.description,
      required this.image,
      this.onRefresh,
      this.height,
      this.width,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onRefresh != null ? buildTextWithRefreshIcon() : buildEmptyText();
  }

  SizedBox buildTextWithRefreshIcon() {
    return SizedBox(
      width: width ?? 0.3.sw,
      height: height ?? 0.3.sh,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 16,
            child: Text(
              description,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: style ??
                  Get.theme.textTheme.bodySmall?.copyWith(
                      fontSize: width != null ? 0.03 * width! : 0.03 * 0.3.sw),
            ),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  onRefresh!();
                },
                icon: Icon(
                  Icons.restart_alt_outlined,
                  size: width != null ? 0.04 * width! : 0.03 * 0.3.sw,
                )),
          )
        ],
      ),
    );
  }

  SizedBox buildEmptyText() {
    return SizedBox(
        height: height ?? 0.6.sh,
        child: Center(
            child: Text(
          description,
          style:
              style ?? Get.theme.textTheme.bodySmall?.copyWith(fontSize: 23.sp),
        )));
  }
}
