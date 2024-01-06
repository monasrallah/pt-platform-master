class AllVideoModel {
  List<VideoModel> videos;

  AllVideoModel({required this.videos});

  factory AllVideoModel.fromJson(Map<String, dynamic> json) {
    List<VideoModel> all = [];
    for (var element in (json['videos'] as List<dynamic>)) {
      all.add(VideoModel.fromJson(element as Map<String, dynamic>));
    }
    return AllVideoModel(videos: all);
  }
}

class VideoModel {
  int id;

  // int? exerciseVideoId;
  String title;
  String description;
  String image;
  String video;
  bool isFavourite;
  bool isTodayLog;
  bool isWorkout;
  String? weight;
  String? sets;
  String? repetition;

  VideoModel({
    required this.id,
    // this.exerciseVideoId,
    required this.title,
    required this.description,
    required this.image,
    required this.video,
    required this.isFavourite,
    required this.isTodayLog,
    required this.isWorkout,
    this.weight,
    this.sets,
    this.repetition,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        id: json["id"],
        // exerciseVideoId: json["exercise_video_id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        video: json["video"],
        isFavourite: json["is_favourite"],
        isTodayLog: json["is_today_log"],
        isWorkout: json["is_workout"],
        weight: json["weight"].toString(),
        sets: json["sets"].toString(),
        repetition: json["repetition"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "video": video,
        "is_favourite": isFavourite,
        "is_today_log": isTodayLog,
        "is_workout": isWorkout,
      };
}
