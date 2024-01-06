class CompleteChallengeVideoParams {
  String coachId;
  List<int> challenge_video_ids;

  CompleteChallengeVideoParams(
      {required this.challenge_video_ids, required this.coachId});

  Map<String, dynamic> toJson() => {
        "challenge_video_ids": challenge_video_ids,
      };
}
