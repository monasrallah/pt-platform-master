class MeasurementsEntity {
  int id;
  DateTime date;
  double neck;
  double chest;
  double leftArm;
  double rightArm;
  double waist;
  double belly;
  double lowerBelly;
  double upperBelly;
  double hips;
  double leftThigh;
  double rightThigh;
  double liftCalf;
  double rightCalf;

  MeasurementsEntity({
    required this.id,
    required this.date,
    required this.neck,
    required this.chest,
    required this.leftArm,
    required this.rightArm,
    required this.waist,
    required this.belly,
    required this.lowerBelly,
    required this.upperBelly,
    required this.hips,
    required this.leftThigh,
    required this.rightThigh,
    required this.liftCalf,
    required this.rightCalf,
  });

  factory MeasurementsEntity.init() {
    return MeasurementsEntity(
        id: 0,
        date: DateTime.now(),
        neck: 0,
        chest: 0,
        leftArm: 0,
        rightArm: 0,
        waist: 0,
        belly: 0,
        lowerBelly: 0,
        upperBelly: 0,
        hips: 0,
        leftThigh: 0,
        rightThigh: 0,
        liftCalf: 0,
        rightCalf: 0);
  }
}
