import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pt_platform/app/extensions.dart';

import '../../../../../../domain/entities/coach_entities/challenge_entity.dart';
import '../../../../../../domain/entities/coach_entities/personalized_entity.dart';
import '../../../../../../domain/entities/home_entities/recipe_entity.dart';
import '../../../exercises/widget/exercises_card.dart';

class PersonalTrainingWorkoutListWidget extends StatelessWidget {
  const PersonalTrainingWorkoutListWidget({
    Key? key,
    required this.personalTraining,
    required this.onTap,
  }) : super(key: key);
  final ChallengeEntity personalTraining;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 300.h,
          child: InkWell(
            onTap: () => onTap(),
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 12.w),
              child: ExerciseCard(
                title: personalTraining.title,
                image: personalTraining.icon.orEmpty(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PersonalTrainingMealsListWidget extends StatelessWidget {
  const PersonalTrainingMealsListWidget({
    Key? key,
    required this.recipeEntity,
    required this.onTap,
  }) : super(key: key);
  final RecipeEntity recipeEntity;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 300.h,
          child: InkWell(
            onTap: () => onTap(),
            child: Padding(
              padding: EdgeInsetsDirectional.only(end: 12.w),
              child: ExerciseCard(
                title: recipeEntity.title,
                image: recipeEntity.image.orEmpty(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PersonalisedListWidget extends StatelessWidget {
  const PersonalisedListWidget({
    Key? key,
    required this.data,
    required this.onTap,
    this.image,
  }) : super(key: key);
  final List<DataEntity> data;
  final Function onTap;
  final String? image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 300.h,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onTap(index);
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(end: 12.w),
                  child: ExerciseCard(
                    title: "",
                    imageLocal: image,
                    image: data[index].value,
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
