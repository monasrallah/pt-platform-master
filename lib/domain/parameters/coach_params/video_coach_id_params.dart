class VideoCoachIdParams {
  int videoId;
  String coachId;
  String? date;

  VideoCoachIdParams({required this.videoId, required this.coachId ,this.date});

  Map<String, dynamic> toJson() => {
        "video_id": videoId,
        "coach_id": coachId,
    if(date != null) "date" :date,
      };
}
