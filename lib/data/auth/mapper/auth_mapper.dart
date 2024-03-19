import '../../../domain/entities/auth_entities/auth_entity.dart';
import '../../../domain/entities/auth_entities/category_entity.dart';
import '../../../domain/entities/auth_entities/coach_entity.dart';
import '../../../domain/entities/auth_entities/trainee_entity.dart';
import '../models/auth_model.dart';
import '../models/coach_model.dart';
import '../models/token_verification_model.dart';
import '../models/trainee_model.dart';

extension AuthTraineeMapper on AuthModel {
  AuthTraineeEntity toDomainTrainee() {
    return AuthTraineeEntity(
      token: token,
      traineeEntity: (user as TraineeModel).toDomain(),
    );
  }
}

extension AuthCoachMapper on AuthModel {
  AuthCoachEntity toDomainCoach() {
    return AuthCoachEntity(
      token: token,
      coachEntity: (user as CoachModel).toDomainCoach(),
    );
  }
}

extension TokenVerificationMapper on TokenVerificationModel {
  String toDomain() {
    return token;
  }
}

extension CoachModelMapper on CoachModel {
  CoachEntity toDomainCoach() {
    return CoachEntity(
        id: id,
        firstName: fullName,
        lastName: nickName,
        email: email,
        avatar: avatar,
        logo: logo,
        phoneNumber: phoneNumber,
        description: description,
        isSubscription: isSubscription,
        // linkSocialMedia: linkSocialMedia,
        // potentialClients: potentialClients,
        categories: categories.map((e) => e.toDomain()).toList(),
        role: role);
  }
}

extension TraineeModelMapper on TraineeModel {
  TraineeEntity toDomain() {
    return TraineeEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      status: status,
      avatar: avatar,
      role: role,
      isSendNotification: isSendNotification,
      // categories: categories
    );
  }
}

extension CategoriesModelMapper on CategoriesModel {
  List<CategoryEntity> toDomain() {
    List<CategoryEntity> allSliders = [];
    for (var element in categories) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension CategoryModelMapper on CategoryModel {
  CategoryEntity toDomain() {
    return CategoryEntity(id: id, name: name);
  }
}

extension TipsModelMapper on TipsModel {
  List<TipEntity> toDomain() {
    List<TipEntity> allSliders = [];
    for (var element in tips) {
      allSliders.add(element.toDomain());
    }
    return allSliders;
  }
}

extension TipModelMapper on TipModel {
  TipEntity toDomain() {
    return TipEntity(id: id, value: value);
  }
}
