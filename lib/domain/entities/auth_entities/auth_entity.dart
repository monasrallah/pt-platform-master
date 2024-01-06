import 'package:pt_platform/domain/entities/auth_entities/coach_entity.dart';
import 'package:pt_platform/domain/entities/auth_entities/trainee_entity.dart';

class AuthCoachEntity {
  String token;
  CoachEntity coachEntity;

  AuthCoachEntity({required this.token, required this.coachEntity});
}

class AuthTraineeEntity {
  String token;
  TraineeEntity traineeEntity;

  AuthTraineeEntity({required this.token, required this.traineeEntity});
}
