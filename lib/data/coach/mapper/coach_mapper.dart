import 'package:pt_platform/data/home/mapper/home_mapper.dart';
import 'package:pt_platform/domain/entities/coach_entities/personalized_entity.dart';
import 'package:pt_platform/domain/entities/coach_entities/video_entity.dart';

import '../../../domain/entities/coach_entities/calender_entity.dart';
import '../../../domain/entities/coach_entities/challenge_entity.dart';
import '../../../domain/entities/coach_entities/chat_entity.dart';
import '../../../domain/entities/coach_entities/exercise_logs_entity.dart';
import '../../../domain/entities/coach_entities/section_exercise_entity.dart';
import '../../../domain/entities/coach_entities/shop_entity.dart';
import '../../../domain/entities/home_entities/recipe_entity.dart';
import '../models/calender_model.dart';
import '../models/challenge_model.dart';
import '../models/chat_model.dart';
import '../models/exercise_log_model.dart';
import '../models/personal_training_model.dart';
import '../models/section_exercise_model.dart';
import '../models/shop_model.dart';
import '../models/video_model.dart';

extension ChallengeModelMapper on ChallengeModel {
  ChallengeEntity toDomain() {
    return ChallengeEntity(
        id: id, title: title, description: description, icon: icon);
  }
}

extension AllChallengesModelMapper on AllChallengesModel {
  List<ChallengeEntity> toDomain() {
    List<ChallengeEntity> allSliders = [];
    for (var element in challenges) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension AllVideoModelMapper on AllVideoModel {
  List<VideoEntity> toDomain() {
    List<VideoEntity> allSliders = [];
    for (var element in videos) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension VideoModelMapper on VideoModel {
  VideoEntity toDomain() {
    return VideoEntity(
      id: id,
      // exerciseVideoId: exerciseVideoId,
      title: title,
      description: description,
      image: image,
      video: video,
      isFavourite: isFavourite,
      isTodayLog: isTodayLog,
      isWorkout: isWorkout,
      weight: weight,
      sets: sets,
      repetition: repetition,
    );
  }
}

extension ChallengeVideoModelMapper on ChallengeVideoModel {
  ChallengeVideoEntity toDomain() {
    return ChallengeVideoEntity(
        id: id, isComplete: isComplete, video: video.toDomain());
  }
}

extension AllChallengesVideoModelMapper on AllChallengesVideoModel {
  List<ChallengeVideoEntity> toDomain() {
    List<ChallengeVideoEntity> allSliders = [];
    for (var element in challenges) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension AllSectionExercisesModelMapper on AllSectionModel {
  List<SectionExercisesEntity> toDomain() {
    List<SectionExercisesEntity> allSliders = [];
    for (var element in sections) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension SectionExercisesModelMapper on SectionModel {
  SectionExercisesEntity toDomain() {
    return SectionExercisesEntity(
        id: id,
        title: title,
        category: category.map((e) => e.toDomain()).toList());
  }
}

extension CategoryExercisesModelMapper on CategoryExercisesModel {
  CategoryExercisesEntity toDomain() {
    return CategoryExercisesEntity(
        id: id,
        title: title,
        exercises: exercises.map((e) => e.toDomain()).toList());
  }
}

extension AllExercisesModelMapper on AllExercisesModel {
  List<ExercisesEntity> toDomain() {
    List<ExercisesEntity> allSliders = [];
    for (var element in exercises) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension ExercisesModelMapper on ExercisesModel {
  ExercisesEntity toDomain() {
    return ExercisesEntity(
        id: id, title: title, description: description, icon: icon);
  }
}

extension AllCalendersModelMapper on AllCalendersModel {
  List<CalenderEntity> toDomain() {
    List<CalenderEntity> allSliders = [];
    for (var element in calenders) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension CalenderModelMapper on CalenderModel {
  CalenderEntity toDomain() {
    return CalenderEntity(
        id: id,
        time: time,
        isAutoAccept: isAutoAccept,
        isAvailable: isAvailable);
  }
}

extension AllChatsModelMapper on AllChatsModel {
  List<ChatEntity> toDomain() {
    List<ChatEntity> allSliders = [];
    for (var element in chats) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension ChatModelMapper on ChatModel {
  ChatEntity toDomain() {
    return ChatEntity(
        id: id,
        userId: userId,
        username: username??"",
        time: time??"",
        isAutoAccept: isAutoAccept,
        date: date,
        deletedAt: deletedAt,
        createdAt: createdAt,
        updatedAt: updatedAt,
        coachTimeReservation: coachTimeReservation?.toDomain());
  }
}

extension CoachTimeReservationModelMapper on CoachTimeReservationModel {
  CoachTimeReservationEntity toDomain() {
    return CoachTimeReservationEntity(
        id: id,
        coachTimeId: coachTimeId,
        userId: userId,
        status: status,
        zoom: zoom.toDomain(),
        deletedAt: deletedAt,
        createdAt: createdAt,
        updatedAt: updatedAt);
  }
}

extension ZoomModelMapper on ZoomModel {
  ZoomEntity toDomain() {
    return ZoomEntity(success: success, data: data.toDomain());
  }
}

extension ZoomDataModelMapper on ZoomDataModel {
  ZoomDataEntity toDomain() {
    return ZoomDataEntity(
        uuid: uuid,
        id: id,
        hostId: hostId,
        hostEmail: hostEmail,
        topic: topic,
        type: type,
        status: status,
        startTime: startTime,
        duration: duration,
        timezone: timezone,
        createdAt: createdAt,
        startUrl: startUrl,
        joinUrl: joinUrl,
        password: password,
        h323Password: h323Password,
        pstnPassword: pstnPassword,
        encryptedPassword: encryptedPassword,
        preSchedule: preSchedule);
  }
}

extension DataModelMapper on DataModel {
  DataEntity toDomain() {
    return DataEntity(id: id, value: value);
  }
}

extension PersonalizedModelMapper on PersonalizedModel {
  PersonalizedEntity toDomain() {
    return PersonalizedEntity(
        video: video.map((e) => e.toDomain()).toList(),
        image: image.map((e) => e.toDomain()).toList(),
        pdf: pdf.map((e) => e.toDomain()).toList(),
        freeText: freeText.map((e) => e.toDomain()).toList());
  }
}

extension AllAssignedWorkoutsModelMapper on AllAssignedWorkoutsModel {
  List<ChallengeEntity> toDomain() {
    List<ChallengeEntity> allSliders = [];
    for (var element in challenges) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension AllAssignedMealsModelMapper on AllAssignedMealsModel {
  List<RecipeEntity> toDomain() {
    List<RecipeEntity> allSliders = [];
    for (var element in meals) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension TipsModelMapper on TipsModel {
  List<DataEntity> toDomain() {
    List<DataEntity> allSliders = [];
    for (var element in tips) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension ShopModelMapper on ShopModel {
  ShopEntity toDomain() {
    return ShopEntity(
        subscription: subscription.map((e) => e.toDomain()).toList(),
        personalTraining: personalTraining.map((e) => e.toDomain()).toList(),
        premium: premium.map((e) => e.toDomain()).toList());
  }
}

extension PersonalTrainingModelMapper on PersonalTrainingModel {
  PersonalTrainingEntity toDomain() {
    return PersonalTrainingEntity(
        id: id,
        name: name,
        description: description,
        price: price,
        priceObject: priceObject.toDomain(),
        date: date,
        style: style,
        isFree: isFree,
        purchaseAppleId: purchaseAppleId,
        purchaseAndroidId: purchaseAndroidId,
        userPackage: userPackage,
        permissions: permissions?.toDomain());
  }
}

extension PermissionsModelMapper on PermissionsModel {
  PermissionsEntity toDomain() {
    return PermissionsEntity(
        callVideo: callVideo,
        workoutSchedule: workoutSchedule,
        foodPlan: foodPlan);
  }
}

extension PriceObjectModelMapper on PriceObjectModel {
  PriceObjectEntity toDomain() {
    return PriceObjectEntity(
        amount: amount,
        formatted: formatted,
        currency: currencyValues.reverse[currency] ?? "");
  }
}

extension PromoCodeModelMapper on DiscountModel {
  DiscountEntity toDomain() {
    return DiscountEntity(
        discount: discount, old_price: old_price, price: price);
  }
}

extension StripeModelMapper on StripeModel {
  StripeEntity toDomain() {
    return StripeEntity(status: status, url: url);
  }
}

extension AllExerciseLogsModelMapper on AllExerciseLogsModel {
  List<ExerciseLogsEntity> toDomain() {
    List<ExerciseLogsEntity> allSliders = [];
    for (var element in logs) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension ExerciseLogsModelMapper on ExerciseLogsModel {
  ExerciseLogsEntity toDomain() {
    return ExerciseLogsEntity(
        id: id,
        number: number,
        weight: weight,
        weightUnit: weightUnit,
        repetition: repetition,
        note: note,
        type: type,
        createdAt: createdAt);
  }
}
