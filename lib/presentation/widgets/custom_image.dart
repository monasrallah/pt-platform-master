import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../resources/color_manager.dart';

class CustomImage extends StatelessWidget {
  final double? width;
  final double? height;
  final String imagePath;
  final Color color;
  final Color? borderColor;
  final BoxShape? shape;
  final IconData? icon;
  final Color? iconColor;
  final Color? iconBackGroundColor;
  final double? borderWidth;
  final Function? onPressed;
  final bool? isFileImage;
  final bool? isUpdating;
  final BoxFit? boxFit;
  final BorderRadius? borderRadius;

  const CustomImage({
    Key? key,
    this.width,
    this.height,
    required this.imagePath,
    this.icon,
    this.onPressed,
    this.borderWidth,
    required this.shape,
    required this.color,
    this.borderColor,
    this.iconColor,
    this.iconBackGroundColor,
    this.isFileImage,
    this.isUpdating,
    this.boxFit,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(imagePath);
    return icon == null
        ? GestureDetector(
            onTap: onPressed != null
                ? () {
                    onPressed!();
                  }
                : null,
            child: buildImage())
        : Stack(
            clipBehavior: Clip.none,
            children: [
              imagePath.contains("http")
                  ? CachedNetworkImage(
                      imageUrl: imagePath,
                      imageBuilder: (context, imageProvider) => Container(
                            width: width,
                            height: height,
                            decoration: BoxDecoration(
                              shape: shape ?? BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                              color: borderColor,
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                  color: ColorManager.primary, width: 3),
                            ),
                          ),
                      progressIndicatorBuilder: (_, __, ___) {
                        return Container(
                          color: Theme.of(context).colorScheme.background,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.6),
                            size: 120.w,
                          ),
                        );
                      },
                      placeholder: (context, url) =>
                          _buildEmptyImagePlaceHolder(),
                      errorWidget: (context, url, error) =>
                          _buildEmptyImagePlaceHolder(isError: true))
                  : buildImage(),
              Positioned(
                bottom: -10,
                right: -7,
                child: onPressed != null ? buildEditIcon(context) : Container(),
              )
            ],
          );
  }

  Container buildImage() {
    return Container(
      decoration: BoxDecoration(
        shape: shape ?? BoxShape.circle,
        color: color,
        borderRadius: borderRadius,
        border: Border.all(
          width: borderWidth != null ? borderWidth! : 0,
          color: borderColor ?? Colors.transparent,
        ),
      ),
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: color,
              borderRadius: borderRadius,
              shape: shape ?? BoxShape.circle,
              image: imagePath.contains("http")
                  ? DecorationImage(
                      image: NetworkImage(imagePath),
                      fit: boxFit ?? BoxFit.cover)
                  : isFileImage != null
                      ? isFileImage!
                          ? DecorationImage(
                              image: FileImage(File(imagePath)),
                              fit: BoxFit.cover)
                          : DecorationImage(
                              image: AssetImage(imagePath), fit: BoxFit.cover)
                      : DecorationImage(
                          image: AssetImage(imagePath), fit: BoxFit.cover))),
    );
  }

  _buildEmptyImagePlaceHolder({bool isError = false}) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.circle,
          color: color,
          border: Border.all(
            width: borderColor != null ? 10 : 0,
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: color,
            shape: shape ?? BoxShape.circle,
          ),
          child: Visibility(
            visible: isError,
            child: const Center(
              child: Icon(Icons.error),
            ),
          ),
        ));
  }

  Container buildEditIcon(BuildContext context) {
    return Container(
        decoration:
            BoxDecoration(color: iconBackGroundColor, shape: BoxShape.circle),
        width: 35,
        child: IconButton(
          icon: Icon(
            icon,
            size: 20,
            color: iconColor,
          ),
          onPressed: () {
            onPressed!();
          },
        ));
  }
}
