import 'video_model.dart';

class AllChallengesModel {
  List<ChallengeModel> challenges;

  AllChallengesModel({required this.challenges});

  factory AllChallengesModel.fromJson(Map<String, dynamic> json) {
    List<ChallengeModel> all = [];
    for (var element in (json['challenges'] as List<dynamic>)) {
      all.add(ChallengeModel.fromJson(element as Map<String, dynamic>));
    }
    return AllChallengesModel(challenges: all);
  }
}

class ChallengeModel {
  int id;
  String title;
  String description;
  String icon;

  ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) => ChallengeModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "icon": icon,
      };
}

class AllChallengesVideoModel {
  List<ChallengeVideoModel> challenges;

  AllChallengesVideoModel({required this.challenges});

  factory AllChallengesVideoModel.fromJson(Map<String, dynamic> json) {
    List<ChallengeVideoModel> all = [];
    for (var element in (json['challenges'] as List<dynamic>)) {
      all.add(ChallengeVideoModel.fromJson(element as Map<String, dynamic>));
    }
    return AllChallengesVideoModel(challenges: all);
  }
}

class ChallengeVideoModel {
  int id;
  bool isComplete;
  VideoModel video;

  ChallengeVideoModel({
    required this.id,
    required this.isComplete,
    required this.video,
  });

  factory ChallengeVideoModel.fromJson(Map<String, dynamic> json) =>
      ChallengeVideoModel(
        id: json["id"],
        isComplete: json["is_complete"],
        video: VideoModel.fromJson(json["video"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "is_complete": isComplete,
        "video": video.toJson(),
      };
}
