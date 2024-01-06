import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../domain/entities/coach_entities/section_exercise_entity.dart';
import '../../resources/assets_manager.dart';
import 'buttons/app_back_bar.dart';

class ExerciseSearchPage extends StatelessWidget {
  const ExerciseSearchPage(
      {required this.exercises,
      super.key,
      required this.onTap,
      required this.onWillPop});

  final List<ExercisesEntity> exercises;
  final Function onTap;
  final Function onWillPop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBackBar(title: 'Search Result'),
      body: exercises.isEmpty
          ? SizedBox(
              height: 0.7.sh,
              width: 1.sw,
              child: SvgPicture.asset(IconsAssets.noData),
            )
          : GridView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => onTap(index),
                  child: ExerciseCard(
                    image: exercises[index].icon,
                    title: exercises[index].title,
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 5,
                  childAspectRatio: 1.sw / 0.5.sh,
                  crossAxisCount: 2),
            ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({super.key, required this.image, required this.title});

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: SizedBox(
              width: 0.4.sw,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          10.verticalSpace,
          Expanded(
            flex: 1,
            child: Text(
              title,
              // maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Get.textTheme.bodySmall!.copyWith(fontSize: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
