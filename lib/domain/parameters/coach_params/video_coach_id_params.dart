class VideoCoachIdParams {
  int videoId;
  String coachId;
  String date;

  VideoCoachIdParams(
      {required this.videoId, required this.coachId, required this.date});

  Map<String, dynamic> toJson() => {
        "video_id": videoId,
        "coach_id": coachId,
        "date": date,
      };
}
