class ChallengeVideoParams {
  String coachId;
  String challengeId;

  ChallengeVideoParams({
    required this.coachId,
    required this.challengeId,
  });

  Map<String, dynamic> toJson() => {
        "coach_id": coachId,
        "challenge_id": challengeId,
      };
}
