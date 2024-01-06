import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../domain/entities/coach_entities/section_exercise_entity.dart';
import '../getx/exercises_controller.dart';
import 'exercises_card.dart';
import 'exercises_coach_details_page.dart';

class ExercisesCoachListWidget extends GetView<ExercisesCoachController> {
  const ExercisesCoachListWidget(
      {Key? key, required this.title, required this.exercises})
      : super(key: key);
  final String title;
  final List<ExercisesEntity> exercises;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Get.textTheme.bodyLarge,
        ),
        10.verticalSpace,
        SizedBox(
          height: 300.h,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: exercises.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  controller.getExerciseVideo(exercises[index].id);
                  Get.to(
                    () => const ExercisesCoachDetailsPage(),
                  );
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 12.w),
                  child: ExerciseCoachCard(
                    title: exercises[index].title,
                    image: exercises[index].icon,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
