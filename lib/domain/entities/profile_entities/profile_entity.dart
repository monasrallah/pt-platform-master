class ProfileEntity {
  int id;
  String firstName;
  String lastName;
  String email;
  int? phoneNumber;
  String? avatar;
  String? description;

  ProfileEntity({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.avatar,
    required this.description,
  });

  factory ProfileEntity.init() {
    return ProfileEntity(
        id: 0,
        firstName: "",
        lastName: "",
        email: "",
        phoneNumber: 1,
        avatar: "",
        description: "");
  }
}
