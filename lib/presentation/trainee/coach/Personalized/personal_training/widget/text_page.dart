import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextPage extends StatelessWidget {
  const TextPage({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text'),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(start: 12.w, end: 12.w),
        child: SizedBox(
          width: 0.9.sw,
          child: Text(
            text,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: Get.textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
