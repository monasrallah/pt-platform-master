class VideoCoachIdParams {
  int videoId;
  String coachId;

  VideoCoachIdParams({required this.videoId, required this.coachId});

  Map<String, dynamic> toJson() => {
        "video_id": videoId,
        "coach_id": coachId,
      };
}
