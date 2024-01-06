import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../domain/entities/coach_entities/section_exercise_entity.dart';
import '../../../trainee/coach/exercises/widget/exercises_card.dart';
import '../getx/workout_controller.dart';
import 'workout_video_page.dart';
import 'workouts_details_page.dart';

class WorkoutCoachListWidget extends GetView<WorkoutsCoachController> {
  const WorkoutCoachListWidget(
      {Key? key, required this.title, required this.workout})
      : super(key: key);
  final String title;
  final List<ExercisesEntity> workout;

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
            itemCount: workout.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () async {
                  Get.to(
                    () => WorkoutDetailsCoachPage(
                      id: workout[index].id,
                      title: workout[index].title,
                      image: workout[index].icon,
                      des: workout[index].description,
                      onTap: () {
                        controller.getWorkOutVideo(workout[index].id);
                        return Get.off(
                          () => const WorkoutCoachVideoPage(),
                        );
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 12.w),
                  child: ExerciseCard(
                    title: workout[index].title,
                    image: workout[index].icon,
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
