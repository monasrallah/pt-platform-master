import 'package:pt_platform/data/coach_app/models/calender_model.dart';

import '../../../domain/entities/coach_app_entity/calender_entity.dart';
import '../../../domain/entities/coach_app_entity/user_entity.dart';
import '../models/user_model.dart';

// extension ChallengeModelMapper on ChallengeModel {
//   ChallengeEntity toDomain() {
//     return ChallengeEntity(
//         id: id, title: title, description: description, icon: icon);
//   }
// }
//
// extension AllChallengesModelMapper on AllChallengesModel {
//   List<ChallengeEntity> toDomain() {
//     List<ChallengeEntity> allSliders = [];
//     for (var element in challenges) {
//       allSliders.add(element.toDomain());
//     }
//     return allSliders;
//   }
// }
//
// extension AllVideoModelMapper on AllVideoModel {
//   List<VideoEntity> toDomain() {
//     List<VideoEntity> allSliders = [];
//     for (var element in videos) {
//       allSliders.add(element.toDomain());
//     }
//     return allSliders;
//   }
// }
//
// extension VideoModelMapper on VideoModel {
//   VideoEntity toDomain() {
//     return VideoEntity(
//       id: id,
//       // exerciseVideoId: exerciseVideoId,
//       title: title,
//       description: description,
//       image: image,
//       video: video,
//       isFavourite: isFavourite,
//       isTodayLog: isTodayLog,
//       isWorkout: isWorkout,
//       weight: weight,
//       sets: sets,
//       repetition: repetition,
//     );
//   }
// }
//
// extension ChallengeVideoModelMapper on ChallengeVideoModel {
//   ChallengeVideoEntity toDomain() {
//     return ChallengeVideoEntity(
//         id: id, isComplete: isComplete, video: video.toDomain());
//   }
// }
//
// extension AllChallengesVideoModelMapper on AllChallengesVideoModel {
//   List<ChallengeVideoEntity> toDomain() {
//     List<ChallengeVideoEntity> allSliders = [];
//     for (var element in challenges) {
//       allSliders.add(element.toDomain());
//     }
//     return allSliders;
//   }
// }
//
// extension AllSectionExercisesModelMapper on AllSectionModel {
//   List<SectionExercisesEntity> toDomain() {
//     List<SectionExercisesEntity> allSliders = [];
//     for (var element in sections) {
//       allSliders.add(element.toDomain());
//     }
//     return allSliders;
//   }
// }
//
// extension SectionExercisesModelMapper on SectionModel {
//   SectionExercisesEntity toDomain() {
//     return SectionExercisesEntity(
//         id: id,
//         title: title,
//         category: category.map((e) => e.toDomain()).toList());
//   }
// }
//
// extension CategoryExercisesModelMapper on CategoryExercisesModel {
//   CategoryExercisesEntity toDomain() {
//     return CategoryExercisesEntity(
//         id: id,
//         title: title,
//         exercises: exercises.map((e) => e.toDomain()).toList());
//   }
// }
//
extension AllUsersModelMapper on AllUsersModel {
  List<UserEntity> toDomain() {
    List<UserEntity> allSliders = [];
    for (var element in users) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension UserModelMapper on UserModel {
  UserEntity toDomain() {
    return UserEntity(
      id: id,
      avatar: avatar,
      name: name,
      startDate: startDate,
      endDate: endDate,
      packageName: packageName,
      type: type,
      style: style,
    );
  }
}

extension AllCalendersCoachModelMapper on AllCalendersCoachModel {
  List<CalenderCoachEntity> toDomain() {
    List<CalenderCoachEntity> allSliders = [];
    for (var element in calenders) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension CalenderModelMapper on CalenderCoachModel {
  CalenderCoachEntity toDomain() {
    return CalenderCoachEntity(
        id: id,
        date: date,
        time: time,
        isAutoAccept: isAutoAccept,
        userName: userName,
        status: status);
  }
}

// extension AllChatsModelMapper on AllChatsModel {
//   List<ChatEntity> toDomain() {
//     List<ChatEntity> allSliders = [];
//     for (var element in chats) {
//       allSliders.add(element.toDomain());
//     }
//     return allSliders;
//   }
// }
//
// extension ChatModelMapper on ChatModel {
//   ChatEntity toDomain() {
//     return ChatEntity(
//         id: id,
//         userId: userId,
//         time: time,
//         coachName: coachName,
//         isAutoAccept: isAutoAccept,
//         date: date,
//         deletedAt: deletedAt,
//         createdAt: createdAt,
//         updatedAt: updatedAt,
//         coachTimeReservation: coachTimeReservation.toDomain());
//   }
// }
//
// extension CoachTimeReservationModelMapper on CoachTimeReservationModel {
//   CoachTimeReservationEntity toDomain() {
//     return CoachTimeReservationEntity(
//         id: id,
//         coachTimeId: coachTimeId,
//         userId: userId,
//         status: status,
//         zoom: zoom.toDomain(),
//         deletedAt: deletedAt,
//         createdAt: createdAt,
//         updatedAt: updatedAt);
//   }
// }
//
// extension ZoomModelMapper on ZoomModel {
//   ZoomEntity toDomain() {
//     return ZoomEntity(success: success, data: data.toDomain());
//   }
// }
//
// extension ZoomDataModelMapper on ZoomDataModel {
//   ZoomDataEntity toDomain() {
//     return ZoomDataEntity(
//         code: code,
//         message: message,
//         uuid: uuid,
//         id: id,
//         host_id: host_id,
//         host_email: host_email,
//         topic: topic,
//         type: type,
//         status: status,
//         start_time: start_time,
//         duration: duration,
//         timezone: timezone,
//         created_at: created_at,
//         start_url: start_url,
//         join_url: join_url,
//         password: password,
//         h323_password: h323_password,
//         pstn_password: pstn_password,
//         encrypted_password: encrypted_password,
//         pre_schedule: pre_schedule);
//   }
// }
//
// extension DataModelMapper on DataModel {
//   DataEntity toDomain() {
//     return DataEntity(id: id, value: value);
//   }
// }
//
// extension PersonalizedModelMapper on PersonalizedModel {
//   PersonalizedEntity toDomain() {
//     return PersonalizedEntity(
//         video: video.map((e) => e.toDomain()).toList(),
//         image: image.map((e) => e.toDomain()).toList(),
//         pdf: pdf.map((e) => e.toDomain()).toList(),
//         freeText: freeText.map((e) => e.toDomain()).toList());
//   }
// }
//
// extension AllAssignedWorkoutsModelMapper on AllAssignedWorkoutsModel {
//   List<ChallengeEntity> toDomain() {
//     List<ChallengeEntity> allSliders = [];
//     for (var element in challenges) {
//       allSliders.add(element.toDomain());
//     }
//     return allSliders;
//   }
// }
//
// extension AllAssignedMealsModelMapper on AllAssignedMealsModel {
//   List<RecipeEntity> toDomain() {
//     List<RecipeEntity> allSliders = [];
//     for (var element in meals) {
//       allSliders.add(element.toDomain());
//     }
//     return allSliders;
//   }
// }
//
// extension PersonalTrainingModelMapper on PersonalTrainingModel {
//   PersonalTrainingEntity toDomain() {
//     return PersonalTrainingEntity(
//         id: id,
//         name: name,
//         description: description,
//         price: price,
//         priceObject: priceObject.toDomain(),
//         date: date,
//         style: style,
//         isFree: isFree,
//         purchaseAppleId: purchaseAppleId,
//         purchaseAndroidId: purchaseAndroidId,
//         userPackage: userPackage,
//         permissions: permissions.toDomain());
//   }
// }
//
// extension PermissionsModelMapper on PermissionsModel {
//   PermissionsEntity toDomain() {
//     return PermissionsEntity(
//         callVideo: callVideo,
//         workoutSchedule: workoutSchedule,
//         foodPlan: foodPlan);
//   }
// }
//
// extension PriceObjectModelMapper on PriceObjectModel {
//   PriceObjectEntity toDomain() {
//     return PriceObjectEntity(
//         amount: amount,
//         formatted: formatted,
//         currency: currencyValues.reverse[currency] ?? "");
//   }
// }
//
// extension AllExerciseLogsModelMapper on AllExerciseLogsModel {
//   List<ExerciseLogsEntity> toDomain() {
//     List<ExerciseLogsEntity> allSliders = [];
//     for (var element in logs) {
//       allSliders.add(element.toDomain());
//     }
//     return allSliders;
//   }
// }
//
// extension ExerciseLogsModelMapper on ExerciseLogsModel {
//   ExerciseLogsEntity toDomain() {
//     return ExerciseLogsEntity(
//         id: id,
//         number: number,
//         weight: weight,
//         weightUnit: weightUnit,
//         repetition: repetition,
//         note: note,
//         type: type,
//         createdAt: createdAt);
//   }
// }
