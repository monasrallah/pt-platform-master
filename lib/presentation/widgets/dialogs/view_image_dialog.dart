import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

import '../../../resources/color_manager.dart';

class ViewImageDialog extends StatelessWidget {
  const ViewImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 1,
      titlePadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.r))),
      contentPadding: EdgeInsets.zero,
      content: Stack(
        children: [
          SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: PhotoView(
              tightMode: true,
              imageProvider: const NetworkImage(
                  "https://techmonitor.ai/wp-content/uploads/sites/4/2016/06/what-is-URL.jpg"),
              heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
            ),
          ),
          PositionedDirectional(
            end: 20.w,
            top: 20.h,
            child: InkWell(
              onTap: () => Get.back(),
              child: Icon(
                Icons.close,
                color: ColorManager.primary,
                size: 22.w,
              ),
            ),
          )
        ],
      ),
    );
  }

  static funDialog(String image) {
    showGeneralDialog(
      context: Get.context!,
      barrierColor: Colors.black12.withOpacity(0.6),
      // Background color
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Stack(
          children: <Widget>[
            SizedBox(
              height: 1.sh,
              width: 1.sw,
              child: PhotoView(
                tightMode: true,
                imageProvider: NetworkImage(
                    // "https://techmonitor.ai/wp-content/uploads/sites/4/2016/06/what-is-URL.jpg"
                    image),
                heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
              ),
            ),
            PositionedDirectional(
              end: 20.w,
              top: 70.h,
              child: TextButton(
                onPressed: () => Get.back(),
                child: Icon(
                  Icons.close,
                  color: ColorManager.primary,
                  size: 27.w,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
