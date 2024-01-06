class VideoEntity {
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

  VideoEntity({
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

  factory VideoEntity.fromJson(Map<String, dynamic> json) => VideoEntity(
        id: json["id"],
        title: json["title"],
        // exerciseVideoId: json["exercise_video_id"],
        description: json["description"],
        image: json["image"],
        video: json["video"],
        isFavourite: json["is_favourite"],
        isTodayLog: json["is_today_log"],
        isWorkout: json["is_workout"],
        weight: json["weight"],
        sets: json["sets"],
        repetition: json["repetition"],
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
