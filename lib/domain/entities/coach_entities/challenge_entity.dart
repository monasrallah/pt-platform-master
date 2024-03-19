import 'video_entity.dart';

class ChallengeEntity {
  int id;
  String title;
  String description;
  String icon;

  ChallengeEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class ChallengeVideoEntity {
  int id;
  bool isComplete;
  VideoEntity video;

  ChallengeVideoEntity({
    required this.id,
    required this.isComplete,
    required this.video,
  });
}
