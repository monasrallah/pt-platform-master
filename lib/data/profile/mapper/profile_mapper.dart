import 'package:pt_platform/data/auth/mapper/auth_mapper.dart';
import 'package:pt_platform/data/auth/models/coach_model.dart';
import 'package:pt_platform/domain/entities/auth_entities/coach_entity.dart';
import 'package:pt_platform/domain/entities/profile_entities/profile_entity.dart';

import '../models/profile_model.dart';

extension ProfileModelMapper on ProfileModel {
  ProfileEntity toDomain() {
    return ProfileEntity(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        avatar: avatar,
        description: description);
  }
}

extension CoachesModelMapper on CoachesModel {
  List<CoachEntity> toDomain() {
    List<CoachEntity> allSliders = [];
    for (var element in coaches) {
      allSliders.add(element.toDomainCoach());
    }
    return allSliders;
  }
}