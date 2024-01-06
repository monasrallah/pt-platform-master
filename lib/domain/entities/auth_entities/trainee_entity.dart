class TraineeEntity {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? status;
  String? avatar;
  String? role;
  int? isSendNotification;
  // List<dynamic>? categories;

  TraineeEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.status,
    this.avatar,
    this.role,
    this.isSendNotification,
    // this.categories,
  });

  factory TraineeEntity.init() {
    return TraineeEntity();
  }
}
