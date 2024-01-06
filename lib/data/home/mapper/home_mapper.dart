import 'package:pt_platform/app/extensions.dart';
import 'package:pt_platform/domain/entities/home_entities/banner_entity.dart';
import 'package:pt_platform/domain/entities/home_entities/food_entity.dart';
import 'package:pt_platform/domain/entities/home_entities/news_entity.dart';
import 'package:pt_platform/domain/entities/home_entities/progress_entity.dart';
import 'package:pt_platform/domain/entities/home_entities/recipe_entity.dart';

import '../../../domain/entities/home_entities/faqs_entity.dart';
import '../../../domain/entities/home_entities/measurements_entity.dart';
import '../models/banner_model.dart';
import '../models/faqs_model.dart';
import '../models/food_model.dart';
import '../models/measurements_model.dart';
import '../models/news_model.dart';
import '../models/progress_model.dart';
import '../models/recipe_model.dart';

extension AllNewsModelMapper on AllNewsModel {
  List<NewsEntity> toDomain() {
    List<NewsEntity> allSliders = [];
    for (var element in news) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension NewsModelMapper on NewsModel {
  NewsEntity toDomain() {
    return NewsEntity(
        id: id, image: image, title: title, description: description);
  }
}

extension SurveyModelMapper on SurveyModel {
  SurveyEntity toDomain() {
    return SurveyEntity(
        surveyId: surveyId,
        description: description,
        questions: questions.map((e) => e.toDomain()).toList());
  }
}

extension AllFaqsModelMapper on AllFaqsModel {
  List<FaqsEntity> toDomain() {
    List<FaqsEntity> allSliders = [];
    for (var element in faqs) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension AllSurveysModelMapper on AllSurveysModel {
  List<SurveyEntity> toDomain() {
    List<SurveyEntity> allSliders = [];
    for (var element in surveys) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension FaqsModelMapper on FaqsModel {
  FaqsEntity toDomain() {
    return FaqsEntity(id: id, question: question, answer: answer.orEmpty(), video: video);
  }
}

extension FoodModelMapper on FoodModel {
  FoodEntity toDomain() {
    return FoodEntity(
        userTarget: userTarget,
        user: user.toDomain(),
        foodTarget: foodTarget,
        exerciseTarget: exerciseTarget,
        carb: carb,
        fat: fat,
        protein: protein,
        food: food.toDomain());
  }
}

extension EatModelMapper on EatModel {
  EatEntity toDomain() {
    return EatEntity(
      breakfast: breakfast?.map((e) => e.toDomain()).toList(),
      dinner: dinner?.map((e) => e.toDomain()).toList(),
      snack: snack?.map((e) => e.toDomain()).toList(),
      supplements: supplements?.map((e) => e.toDomain()).toList(),
      lunch: lunch?.map((e) => e.toDomain()).toList(),
    );
  }
}

extension DishesModelMapper on DishesModel {
  DishesEntity toDomain() {
    return DishesEntity(
        userFoodId: userFoodId,
        id: id,
        sku: sku,
        calorie: calorie,
        carb: carb,
        fat: fat,
        protein: protein,
        name: name,
        title: title);
  }
}

extension UserTargetModelMapper on UserTargetModel {
  UserTargetEntity toDomain() {
    return UserTargetEntity(
        targetCalorie: targetCalorie,
        targetCarb: targetCarb,
        targetFat: targetFat,
        targetProtein: targetProtein);
  }
}

extension AllAddFoodModelMapper on AllAddFoodModel {
  List<AddFoodEntity> toDomain() {
    List<AddFoodEntity> allSliders = [];
    for (var element in foods) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension AddFoodModelMapper on AddFoodModel {
  AddFoodEntity toDomain() {
    return AddFoodEntity(
        id: id,
        sku: sku,
        calorie: calorie,
        carb: carb,
        fat: fat,
        protein: protein,
        name: name,
        title: title);
  }
}

extension AllRecipeModelMapper on AllRecipeModel {
  List<RecipeEntity> toDomain() {
    List<RecipeEntity> allSliders = [];
    for (var element in recipes) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension AllSupplementsModelMapper on AllSupplementsModel {
  List<RecipeEntity> toDomain() {
    List<RecipeEntity> allSliders = [];
    for (var element in recipes) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension RecipeModelMapper on RecipeModel {
  RecipeEntity toDomain() {
    return RecipeEntity(
        id: id,
        image: image,
        time: time,
        name: name,
        title: title,
        description: description,
        ingredients: ingredients);
  }
}

extension AllProgressModelMapper on AllProgressModel {
  List<ProgressEntity> toDomain() {
    List<ProgressEntity> allSliders = [];
    for (var element in progress) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension ProgressModelMapper on ProgressModel {
  ProgressEntity toDomain() {
    return ProgressEntity(
        weight: weight ?? 0.0,
        percentage: percentage.toDomain(),
        muscle: muscle ?? 0.0,
        fat: fat ?? 0.0,
        water: water ?? 0.0,
        activeCalories: activeCalories ?? 0.0,
        steps: steps ?? 0.0);
  }
}

extension PercentageModelMapper on PercentageModel {
  PercentageEntity toDomain() {
    return PercentageEntity(value: value, type: type);
  }
}

extension AllMeasurementsModelMapper on AllMeasurementsModel {
  List<MeasurementsEntity> toDomain() {
    List<MeasurementsEntity> allSliders = [];
    for (var element in measurements) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension MeasurementsModelMapper on MeasurementsModel {
  MeasurementsEntity toDomain() {
    return MeasurementsEntity(
        id: id,
        date: date,
        neck: neck,
        chest: chest,
        leftArm: leftArm,
        rightArm: rightArm,
        waist: waist,
        belly: belly,
        lowerBelly: lowerBelly,
        upperBelly: upperBelly,
        hips: hips,
        leftThigh: leftThigh,
        rightThigh: rightThigh,
        liftCalf: liftCalf,
        rightCalf: rightCalf);
  }
}

extension AllBannerModelMapper on AllBannerModel {
  List<BannerEntity> toDomain() {
    List<BannerEntity> allSliders = [];
    for (var element in banners) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension BannerModelMapper on BannerModel {
  BannerEntity toDomain() {
    return BannerEntity(id: id, image: image, text: text, url: url);
  }
}
